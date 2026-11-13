-- If you're struggling with coding, feel free to use this source, and you can join my Discord to learn and improve your coding skills together with us 😚: discord.gg/gFC9eqRKA

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local localPlayer = Players.LocalPlayer
local PlayerGui = localPlayer:WaitForChild("PlayerGui", 10)
local playerCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local Camera = Workspace.CurrentCamera

localPlayer.CharacterAdded:Connect(function(c)
    playerCharacter = c
end)

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/72msreal-pixel/WindUI/refs/heads/main/Main.luau"))()
local Modules = loadstring(game:HttpGet("https://raw.githubusercontent.com/72msreal-pixel/WindUI/refs/heads/main/Modules.luau"))()
local LangController = Modules:Install(WindUI)

WindUI.Creator.AddIcons("NaN", {
    Discord = "rbxassetid://76958837964147",
    Robux = "rbxassetid://92207254124270",
    Youtube = "rbxassetid://117641022373030",
    Tiktok = "rbxassetid://81692384839738",
})

if getgenv().MyESPFramwork then
    getgenv().MyESPFramwork:RemoveAllEsp()
end

ESP = {
    Objects = {},
    Order = {},
    Cursor = 1,
    TracerOrigin = "Bottom",
    Connections = {},
    Config = {
        MaxDistance = 500,
        UpdateInterval = 0.12,
    },
    Cache = {
        ViewSize = Camera.ViewportSize,
        LocalPos = Vector3.zero,
    },
    Gui = {},
    Kinds = {
        {Setting = "UseText", Key = "TextBill", Prop = "Enabled"},
        {Setting = "UseBox", Key = "Box", Prop = "Enabled"},
        {Setting = "UseTracer", Key = "Tracer", Prop = "Visible"},
    },
    Defaults = {
        ShowName = true,
        UseHighlight = false,
        UseText = false,
        UseBox = false,
        UseTracer = false,
        ShowHP = false,
        ShowDistance = false,
        FillTransparency = 0.5,
        Color = Color3.new(1, 1, 1),
    },
}
getgenv().MyESPFramwork = ESP

for Key, Class in next, {Folder = "Folder", TracerGui = "ScreenGui"} do
    local Gui = CoreGui:FindFirstChild("MyHybridESP_" .. Key) or Instance.new(Class)
    Gui.Name = "MyHybridESP_" .. Key
    Gui.Parent = CoreGui
    Gui:ClearAllChildren()
    ESP.Gui[Key] = Gui
end
ESP.Gui.TracerGui.IgnoreGuiInset = true

function ESP.New(Class, Props, Parent)
    local Object = Instance.new(Class)
    for Key, Value in next, Props do
        Object[Key] = Value
    end
    Object.Parent = Parent
    return Object
end

function ESP:SetProp(obj, key, value)
    if obj and obj[key] ~= value then
        obj[key] = value
    end
end

function ESP:IsSelf(obj)
    if obj == localPlayer or (playerCharacter and obj == playerCharacter) then return true end
    return playerCharacter ~= nil and typeof(obj) == "Instance" and obj:IsDescendantOf(playerCharacter)
end

function ESP:GetLocalPosition()
    local Root = self.Cache.LocalRoot

    if not (Root and playerCharacter and Root.Parent == playerCharacter) then
        Root = playerCharacter and (playerCharacter:FindFirstChild("HumanoidRootPart") or playerCharacter:FindFirstChild("Head"))
        self.Cache.LocalRoot = Root
    end

    return Root and Root.Position or Camera.CFrame.Position
end

function ESP:GetTracerPos()
    local Size, Origin = self.Cache.ViewSize, self.TracerOrigin

    if Origin == "Mouse" then
        return UserInputService:GetMouseLocation()
    end

    return Vector2.new(Size.X * 0.5, Origin == "Center" and Size.Y * 0.5 or Origin == "Top" and 0 or Size.Y)
end

function ESP:BuildChams(d)
    local Draw, Target, Humanoid = d.Drawings, d.Cache.Adornee, d.Cache.Humanoid

    for _, Cham in ipairs(Draw.Chams or {}) do
        Cham:Destroy()
    end

    local Pool = Target:IsA("BasePart") and {Target} or Humanoid and Target:GetChildren() or Target:GetDescendants()
    local List = {}

    for _, Part in ipairs(Pool) do
        if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" and Part.Transparency < 1 then
            List[#List + 1] = self.New("BoxHandleAdornment", {
                Adornee = Part,
                Size = Part.Size,
                AlwaysOnTop = true,
                ZIndex = 1,
                Visible = false,
            }, self.Gui.Folder)
        end
    end

    Draw.Chams = List
end

function ESP:AllocateDrawings(d)
    local S, C = d.Settings, d.Cache
    d.Drawings = d.Drawings or {}
    local Draw = d.Drawings

    if S.UseHighlight then
        local Signature = C.Humanoid and #C.Adornee:GetChildren() or 0

        if C.ChamTarget ~= C.Adornee or C.ChamSignature ~= Signature then
            C.ChamTarget, C.ChamSignature = C.Adornee, Signature
            self:BuildChams(d)
        end
    end

    if S.UseText and not Draw.TextBill then
        Draw.TextBill = self.New("BillboardGui", {
            AlwaysOnTop = true,
            Size = UDim2.new(0, 200, 0, 50),
            StudsOffset = Vector3.new(0, 4, 0),
            Enabled = false,
        }, self.Gui.Folder)

        Draw.TextLabel = self.New("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            TextStrokeTransparency = 0,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 13,
            FontFace = Font.new("rbxassetid://12187361116", Enum.FontWeight.Bold),
        }, Draw.TextBill)
    end

    if S.UseBox and not Draw.Box then
        Draw.Box = self.New("BillboardGui", {
            AlwaysOnTop = true,
            Size = UDim2.new(4.5, 0, 6.5, 0),
            Enabled = false,
        }, self.Gui.Folder)

        Draw.BoxStroke = self.New("UIStroke", {Thickness = 1.5}, self.New("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
        }, Draw.Box))
    end

    if S.UseTracer and not Draw.Tracer then
        Draw.Tracer = self.New("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,
            Visible = false,
        }, self.Gui.TracerGui)
    end

    return Draw
end

function ESP:SetAllVisible(draw, value)
    if not draw then return end

    for _, Kind in ipairs(self.Kinds) do
        if draw[Kind.Key] then self:SetProp(draw[Kind.Key], Kind.Prop, value) end
    end
    for _, Cham in ipairs(draw.Chams or {}) do
        self:SetProp(Cham, "Visible", value)
    end
end

function ESP:Hide(d)
    if d.Visible then
        d.Visible = false
        self:SetAllVisible(d.Drawings, false)
    end
end

function ESP:BuildText(d, dist)
    local Parts, S, Humanoid = d.Cache.TextParts, d.Settings, d.Cache.Humanoid
    table.clear(Parts)

    if S.ShowName ~= false then Parts[#Parts + 1] = d.BaseName end
    if S.ShowHP and Humanoid then
        Parts[#Parts + 1] = string.format("[%d/%d]", math.floor(Humanoid.Health), math.floor(Humanoid.MaxHealth))
    end
    if S.ShowDistance then Parts[#Parts + 1] = string.format("[%dm]", math.floor(dist)) end

    return table.concat(Parts, " ")
end

function ESP:ClearTargetCache(d)
    d.Cache.Root = nil
    d.Cache.Adornee = nil
    d.Cache.Humanoid = nil
    return false
end

function ESP:GetFallbackPart(obj)
    if obj:IsA("BasePart") then return obj end
    return obj:FindFirstChild("HumanoidRootPart") or
           obj.PrimaryPart or
           obj:FindFirstChild("Head") or
           obj:FindFirstChild("UpperTorso") or
           obj:FindFirstChild("Torso") or
           obj:FindFirstChildWhichIsA("BasePart", true)
end

function ESP:RefreshTargetCache(d)
    local C, Object = d.Cache, d.Object

    if not (d.IsInstance and Object.Parent) then
        return self:ClearTargetCache(d)
    end

    local Target = d.IsPlayer and Object.Character or Object
    if not Target or self:IsSelf(Target) then
        return self:ClearTargetCache(d)
    end

    if Target:IsA("Model") then
        if not (C.Root and C.Root:IsDescendantOf(Target)) then
            C.Root = self:GetFallbackPart(Target)
        end
        if not (C.Humanoid and C.Humanoid:IsDescendantOf(Target)) then
            C.Humanoid = Target:FindFirstChildOfClass("Humanoid")
        end
    elseif Target:IsA("BasePart") then
        local Parent = Target.Parent
        C.Root = Target
        if not (C.Humanoid and C.Humanoid.Parent == Parent) then
            C.Humanoid = Parent and Parent:FindFirstChildOfClass("Humanoid")
        end
    else
        return self:ClearTargetCache(d)
    end

    C.Adornee = Target
    return C.Root ~= nil and not (C.Humanoid and C.Humanoid.Health <= 0)
end

function ESP:UpdateTracer(frame, fromPos, toPos, color)
    local Delta = toPos - fromPos

    frame.Size = UDim2.fromOffset(Delta.Magnitude, 1.5)
    frame.Position = UDim2.fromOffset((fromPos.X + toPos.X) * 0.5, (fromPos.Y + toPos.Y) * 0.5)
    frame.Rotation = math.deg(math.atan2(Delta.Y, Delta.X))
    self:SetProp(frame, "BackgroundColor3", color)
end

function ESP:Process(d)
    local S, C = d.Settings, d.Cache

    if not d.IsActive then
        self:Hide(d)
        return
    end

    if d.IsInstance and not d.Object.Parent then
        self:Huy(d.Id)
        return true
    end

    if not self:RefreshTargetCache(d) then
        self:Hide(d)
        return
    end

    local Root = C.Root
    local Distance = (self.Cache.LocalPos - Root.Position).Magnitude
    if Distance > self.Config.MaxDistance then
        self:Hide(d)
        return
    end

    local Draw = self:AllocateDrawings(d)
    local Color = S.Color
    d.Visible = true

    for _, Cham in ipairs(Draw.Chams or {}) do
        self:SetProp(Cham, "Visible", S.UseHighlight and true or false)
        self:SetProp(Cham, "Color3", Color)
        self:SetProp(Cham, "Transparency", S.FillTransparency)
    end

    for _, Kind in ipairs(self.Kinds) do
        local Inst = Draw[Kind.Key]

        if Inst then
            if Kind.Prop == "Enabled" then
                self:SetProp(Inst, "Adornee", Root)
                self:SetProp(Inst, "Enabled", S[Kind.Setting] and true or false)
            elseif not S[Kind.Setting] then
                self:SetProp(Inst, "Visible", false)
            end
        end
    end

    if S.UseText and Draw.TextLabel then
        self:SetProp(Draw.TextLabel, "Text", self:BuildText(d, Distance))
        self:SetProp(Draw.TextLabel, "TextColor3", Color)
    end
    if S.UseBox and Draw.BoxStroke then
        self:SetProp(Draw.BoxStroke, "Color", Color)
    end
end

function ESP:ApplyDefaults(settings)
    settings = settings or {}
    for key, value in next, self.Defaults do
        if settings[key] == nil then
            settings[key] = value
        end
    end
    return settings
end

function ESP:DangKy(id, obj, settings)
    if not obj or self:IsSelf(obj) then return end
    settings = self:ApplyDefaults(settings)

    local IsInstance = typeof(obj) == "Instance"
    local Info = {
        Object = obj,
        Settings = settings,
        IsInstance = IsInstance,
        IsPlayer = IsInstance and obj:IsA("Player"),
        BaseName = settings.CustomName or (IsInstance and obj.Name or tostring(obj)),
    }

    local Existing = self.Objects[id]
    if Existing then
        for Key, Value in next, Info do
            Existing[Key] = Value
        end
        return
    end

    Info.Id = id
    Info.IsActive = true
    Info.Cache = {TextParts = {}}
    Info.Slot = #self.Order + 1

    self.Order[Info.Slot] = Info
    self.Objects[id] = Info
end

function ESP:Huy(id)
    local d = self.Objects[id]
    if not d then return end

    local Draw = d.Drawings
    if Draw then
        for _, Kind in ipairs(self.Kinds) do
            if Draw[Kind.Key] then Draw[Kind.Key]:Destroy() end
        end
        for _, Cham in ipairs(Draw.Chams or {}) do
            Cham:Destroy()
        end
    end

    local Last = table.remove(self.Order)
    if Last ~= d then
        self.Order[d.Slot] = Last
        Last.Slot = d.Slot
    end

    self.Objects[id] = nil
end

function ESP:RemoveAllEsp()
    for id in next, self.Objects do
        self:Huy(id)
    end

    for Key, Connection in next, self.Connections do
        Connection:Disconnect()
        self.Connections[Key] = nil
    end
end

ESP.Connections.PlayerRemoving = Players.PlayerRemoving:Connect(function(p)
    for id, d in next, ESP.Objects do
        if d.Object == p then ESP:Huy(id) end
    end
end)

ESP.Connections.ViewSize = Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    ESP.Cache.ViewSize = Camera.ViewportSize
end)

ESP.Connections.Render = RunService.RenderStepped:Connect(function(dt)
    local Order = ESP.Order
    if #Order == 0 then return end

    ESP.Cache.LocalPos = ESP:GetLocalPosition()
    for _ = 1, math.min(#Order, math.ceil(#Order * dt / ESP.Config.UpdateInterval)) do
        if #Order == 0 then break end
        if ESP.Cursor > #Order then ESP.Cursor = 1 end

        if not ESP:Process(Order[ESP.Cursor]) then
            ESP.Cursor = ESP.Cursor + 1
        end
    end

    local Origin = ESP:GetTracerPos()
    for _, d in ipairs(Order) do
        local Tracer = d.Drawings and d.Drawings.Tracer

        if Tracer then
            local Root = d.Cache.Root
            local Pos, OnScreen

            if d.Visible and d.Settings.UseTracer and Root and Root.Parent then
                Pos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
            end

            ESP:SetProp(Tracer, "Visible", OnScreen and true or false)
            if OnScreen then
                ESP:UpdateTracer(Tracer, Origin, Vector2.new(Pos.X, Pos.Y), d.Settings.Color)
            end
        end
    end
end)

local old = getgenv().NaNMain
if old then
    pcall(old.adToggle, false)
    pcall(old.bpUnload)
end

local Main = {
    conns = {},
    adOn = false, adCount = 4, adArc = 90, adThick = 0.05, adTilt = 12, adBob = 0.12, adSway = 0.1,
    adMaxLines = 6, adGlide = 4, adBank = 0.035, adDrift = 9, adStagger = 0.1, adLagEase = 12,
    adSpinRef = 3, adSpeed = 16, adSmooth = 10, adSpin = 0, adMove = Vector3.zero, adHist = {},
    adFlickRate = 0.07, adChaos = 0.3, adJitter = 0.04, adAlpha = 0.55, adNext = 0, adPanels = {},
    adColor = Color3.fromRGB(60, 175, 215),
    adRadius = { Min = 4.5, Max = 8 },
    adHeight = { Min = -0.5, Max = 3.5 },
    adWidth = { Min = 3, Max = 4.6 },
    adTall = { Min = 1.3, Max = 2.1 },
    adInterval = { Min = 2, Max = 5 },
    adTypeEvery = { Min = 0.15, Max = 0.6 },
    adSpring = { Min = 14, Max = 40 },
    adRatio = { Min = 0.45, Max = 0.7 },
    adFlicker = { Min = 0.3, Max = 0.85 },
    adDots = '<font color="#FF5F56">●</font> <font color="#FFBD2E">●</font> <font color="#27C93F">●</font>',
    adTitles = { "admin.lua", "console", "cmdbar", "output", "scheduler" },
    adTints = { [":"] = "#7CFFB2", ["-"] = "#6F8FA0", ["["] = "#FFD479", Default = "#C8F5FF" },
    adLines = {
        ":fly all", ":speed me 100", ":noclip me", ":tp me spawn", ":god all", "like and sub!!",
        "local cmd = args[1]:lower()", "for _, p in ipairs(Players:GetPlayers()) do",
        "  if p.Name:find(args[2]) then", "    Admin.Run(cmd, p)", "  end", "end",
        "-- admin level: 5", "-- loading modules...", "[OK] auth passed", "[WARN] rate limit",
        "[ADMIN] loaded", "while task.wait() do", "  workspace.Gravity = 196.2", "return true",
    },
    flOn = false, flAuto = false, flFollowing = false, flForce = 10000, flTime = 1.5, flSince = 0,
    flCC = setmetatable({}, { __mode = "k" }),
    camOn = false, camHeight = 1.5, camPart = "Head", camQuick = false, camSwitch = false,
    camScale = 1, camSmooth = 1, camFov = false, camRadius = 150,
    godOn = false, godConns = {}, godSel = { Undead = true }, godActive = {}, godHp = 100,
    toolAuto = false, toolList = {}, toolDrops = {}, toolDropConns = {}, toolClass = {},
    toolRoots = { PlayerGui, CoreGui },
    toolHint = { "hotbar", "inventory", "backpack", "toolbar", "tools" },
    toolBar = { "hotbar", "backpack", "toolbar", "inventory" },
    toolDropWords = { "drop", "throw", "discard", "toss", "thả", "vứt" },
    toolNotDrop = { "dropdown" },
    toolWords = {
        Equip = { "equip" },
        Refresh = { "refresh", "update", "render", "rebuild", "reload", "sync" },
    },
    hopOn = false, hopLast = 0, hopCheck = 0, hopInterval = 0.01, hopCooldown = 0.3, hopMargin = 0.5,
    hopMin = 2, hopMult = 1, hopParams = OverlapParams.new(),
    hopCache = setmetatable({}, { __mode = "k" }),
    srvId = "", srvMinutes = 30, srvJobs = {},
    mvNoclip = false, mvInfJump = false, mvSaved = {}, mvParts = {}, mvGlideConns = {},
    mvProps = {
        Walk = { Prop = "WalkSpeed", Value = 50, Wanted = false },
        Jump = { Prop = "JumpPower", Use = "UseJumpPower", Value = 100, Wanted = false },
    },
    mvGlide = {
        Swim = { State = Enum.HumanoidStateType.Swimming, Value = 35, Wanted = false },
        Fly = { Value = 50, Freeze = true, Tilt = true, Wanted = false },
    },
    mvSkip = {
        [Enum.HumanoidStateType.Dead] = true,
        [Enum.HumanoidStateType.None] = true,
    },
    gravOrig = Workspace.Gravity,
    tpNames = {}, tpPos = {}, tpCount = 0,
    freeOn = false, freeSpeed = 60, freeVel = Vector3.zero, freeDist = 10,
    fxSaved = {}, fxLevel = 1, fxToken = 0, fxAuto = false,
    fxTerrain = Workspace.Terrain,
    fxNames = { "Lite", "Medium", "High", "Extreme" },
    fxClasses = {
        Effect = { "ParticleEmitter", "Trail", "Beam", "Fire", "Smoke", "Sparkles", "PointLight", "SpotLight", "SurfaceLight" },
        PostFx = { "BlurEffect", "SunRaysEffect", "BloomEffect", "DepthOfFieldEffect" },
        Clothes = { "Accessory", "Shirt", "Pants", "ShirtGraphic" },
        Decal = { "Decal", "Texture" },
    },
    bpOn = false, bpRespawning = false, bpTracks = {},
    bpStateAnim = {
        [Enum.HumanoidStateType.Freefall] = "fall",
        [Enum.HumanoidStateType.Jumping] = "jump",
        [Enum.HumanoidStateType.Climbing] = "climb",
        [Enum.HumanoidStateType.Seated] = "sit",
    },
    espContainers = {}, espConns = {}, espClass = {},
    espFormKeys = { UseHighlight = "Highlight", UseText = "Text", UseBox = "Box", UseTracer = "Tracer" },
    espTextKeys = { ShowName = "Name", ShowHP = "HP", ShowDistance = "Distance" },
    dcUrl = "https://raw.githubusercontent.com/72msreal-pixel/Link/refs/heads/main/Discord.lua",
    dcCustomBanner = "https://raw.githubusercontent.com/72msreal-pixel/Link/main/20261104_061437.jpg",
    dcDefBanner = "35981388401406a4b7dffd6f447a64c4",
    dcIcon = "rbxassetid://0", dcIconSize = 48,
    cfgName = "",
}

getgenv().NaNMain = Main
Main.toolClass.__index = Main.toolClass
Main.hopParams.MaxParts = 10
Main.espClass.__index = Main.espClass

function Main.new(class, props, parent)
    local o = Instance.new(class)
    for k, v in next, props do o[k] = v end
    if parent then o.Parent = parent end
    return o
end

function Main.root(c)
    return c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso"))
end

function Main.char()
    local c = localPlayer.Character
    return c, c and c:FindFirstChildOfClass("Humanoid"), Main.root(c)
end

function Main.alive(c)
    local h = c and c:FindFirstChildOfClass("Humanoid")
    return h ~= nil and h.Health > 0
end

function Main.cam()
    return Workspace.CurrentCamera
end

function Main.clone(v)
    return (WindUI.cloneref or function(x) return x end)(v)
end

function Main.fresh(name)
    local o = CoreGui:FindFirstChild(name)
    if o then o:Destroy() end
end

function Main.listen(key, on, signal, fn)
    local c = Main.conns[key]
    if c then
        c:Disconnect()
        Main.conns[key] = nil
    end
    if on then Main.conns[key] = signal:Connect(fn) end
end

function Main.cut(t)
    for k, c in pairs(t) do
        c:Disconnect()
        t[k] = nil
    end
end

function Main.kill(t, keys)
    for _, k in ipairs(keys) do
        if t[k] then
            t[k]:Destroy()
            t[k] = nil
        end
    end
end

function Main.set(obj, props)
    for k, v in pairs(props) do
        if obj[k] ~= v then obj[k] = v end
    end
end

function Main.num(x)
    local n = tonumber(x)
    return n and n > 0 and n or nil
end

function Main.names(skip)
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= localPlayer and p ~= skip then list[#list + 1] = p.Name end
    end
    table.sort(list)
    return list
end

function Main.notify(title, text, icon)
    WindUI:Notify({ Title = title, Content = tostring(text), Duration = 3, Icon = icon })
end

function Main.tween(obj, props, t)
    if obj then
        TweenService:Create(obj, TweenInfo.new(t or 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), props):Play()
    end
end

function Main.rand(r) return r.Min + (r.Max - r.Min) * math.random() end
function Main.noise(n) return (math.random() * 2 - 1) * n end
function Main.pick(list) return list[math.random(#list)] end
function Main.ease(dt, rate) return 1 - math.exp(-dt * rate) end

function Main.moveDir(hum, jump)
    local cam = Main.cam()
    local look, right = cam.CFrame.LookVector, cam.CFrame.RightVector
    local move = hum.MoveDirection
    local flat = Vector3.new(look.X, 0, look.Z)

    local dir = right * move:Dot(right) + look * (flat.Magnitude > 0 and move:Dot(flat.Unit) or 0)
    if dir.Magnitude > 1 then dir = dir.Unit end

    local up = ((UserInputService:IsKeyDown(Enum.KeyCode.Space) or jump) and 1 or 0)
        - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0)
    return dir + Vector3.yAxis * up, flat
end

function Main.refreshPlayers(leaving)
    local names = Main.names(leaving)

    if Main.flName and not Players:FindFirstChild(Main.flName) then Main.flName = nil end
    if Main.flDrop then pcall(Main.flDrop.Refresh, Main.flDrop, names) end

    if Main.tpDrop then
        Main.tpDrop:Refresh(names)
        if Main.tpPlayer and not table.find(names, Main.tpPlayer) then
            Main.tpPlayer = nil
        elseif Main.tpPlayer then
            Main.tpDrop:Select(Main.tpPlayer)
        end
    end

    if Main.srvStatus then Main.srvStatus:SetDesc(Main.srvText()) end
end

Players.PlayerAdded:Connect(function() Main.refreshPlayers() end)
Players.PlayerRemoving:Connect(function(p) task.defer(Main.refreshPlayers, p) end)

localPlayer.CharacterAdded:Connect(function(c)
    Main.flOrigCF, Main.flSince = nil, tick()
    Main.freeStop()
    task.spawn(Main.toolOnChar, c)
    task.spawn(Main.glideRespawn, c)
    task.spawn(Main.bpBind, c)
end)
localPlayer.CharacterRemoving:Connect(function() Main.toolDropAll() end)

function Main.adLine()
    local t = Main.pick(Main.adLines)
    return ('<font color="%s">%s</font>'):format(Main.adTints[t:sub(1, 1)] or Main.adTints.Default, t)
end

function Main.adType(panel, now)
    table.insert(panel.Lines, Main.adLine())
    if #panel.Lines > Main.adMaxLines then table.remove(panel.Lines, 1) end

    local text = table.concat(panel.Lines, "\n")
    for _, l in ipairs(panel.Labels) do l.Text = text end
    panel.NextType = now + Main.rand(Main.adTypeEvery)
end

function Main.adPlace(panel, now)
    local slot = Main.adArc * 2 / Main.adCount
    local ang = math.rad(slot * (panel.Index - 0.5 + Main.noise(0.3)) - Main.adArc)
    local r = Main.rand(Main.adRadius)
    local pos = Vector3.new(math.sin(ang) * r, Main.rand(Main.adHeight), -math.cos(ang) * r)

    panel.Side = ang / math.rad(Main.adArc)
    panel.Target = CFrame.lookAt(pos, Vector3.new(0, pos.Y, 0)) * CFrame.Angles(0, 0, math.rad(Main.noise(Main.adTilt)))
    panel.Size = Vector3.new(Main.rand(Main.adWidth), Main.rand(Main.adTall), Main.adThick)
    panel.Next = now + Main.rand(Main.adInterval)
end

function Main.adLabel(props, parent)
    props.BackgroundTransparency, props.RichText, props.Font = 1, true, Enum.Font.Code
    props.TextXAlignment, props.TextYAlignment = Enum.TextXAlignment.Left, Enum.TextYAlignment.Top
    return Main.new("TextLabel", props, parent)
end

function Main.adMake(index)
    local now = os.clock()
    local part = Main.new("Part", {
        Anchored = true, CanCollide = false, CanTouch = false, CanQuery = false, CastShadow = false,
        Material = Enum.Material.SmoothPlastic, Color = Main.adColor, Transparency = Main.adAlpha,
    }, Main.adFolder)
    local stiff = Main.rand(Main.adSpring)
    local panel = {
        Part = part, Index = index, Labels = {}, Lines = {},
        Phase = math.random() * math.pi * 2, Vel = 0, Lag = 0,
        Stiff = stiff, Damp = 2 * math.sqrt(stiff) * Main.rand(Main.adRatio),
    }

    Main.adPlace(panel, now)
    panel.Current, part.Size = panel.Target, panel.Size

    local title = Main.adDots .. "  " .. Main.pick(Main.adTitles)
    local edge = Main.adColor:Lerp(Color3.new(1, 1, 1), 0.6)

    for _, face in ipairs({ Enum.NormalId.Front, Enum.NormalId.Back }) do
        local gui = Main.new("SurfaceGui", {
            Face = face, LightInfluence = 0,
            SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, PixelsPerStud = 80,
        }, part)
        local frame = Main.new("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ClipsDescendants = true }, gui)

        Main.new("UIStroke", { Color = edge, Thickness = 2, Transparency = 0.15 }, frame)
        Main.new("Frame", {
            Size = UDim2.new(1, 0, 0, 2), Position = UDim2.new(0, 0, 1, -2),
            BackgroundColor3 = edge, BorderSizePixel = 0,
        }, frame)
        Main.adLabel({ Text = title, TextSize = 9, TextColor3 = edge, Position = UDim2.fromOffset(6, 3), Size = UDim2.new(1, -12, 0, 12) }, frame)
        table.insert(panel.Labels, Main.adLabel({
            TextSize = 10, TextColor3 = Color3.new(1, 1, 1),
            Position = UDim2.fromOffset(6, 19), Size = UDim2.new(1, -12, 1, -24),
        }, frame))
    end

    for _ = 1, Main.adMaxLines do Main.adType(panel, now) end
    table.insert(Main.adPanels, panel)
end

function Main.adSample(time)
    local h = Main.adHist
    for i = #h, 1, -1 do
        local a = h[i]
        if a.Time <= time or i == 1 then
            local b = h[i + 1] or a
            local span = b.Time - a.Time
            local t = span > 0 and math.clamp((time - a.Time) / span, 0, 1) or 0
            return a.Yaw + (b.Yaw - a.Yaw) * t, a.Pos:Lerp(b.Pos, t)
        end
    end
end

function Main.adStep(dt)
    local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    dt = math.min(dt, 1 / 30)
    local now, look = os.clock(), root.CFrame.LookVector
    local glitch = now >= Main.adNext
    if glitch then Main.adNext = now + Main.adFlickRate end

    local glide, ease = Main.ease(dt, Main.adGlide), Main.ease(dt, Main.adSmooth)
    local fade, drift = Main.ease(dt, Main.adLagEase), Main.ease(dt, Main.adDrift)

    local goal = math.atan2(-look.X, -look.Z)
    local last = Main.adYaw or goal
    Main.adYaw = last + (goal - last + math.pi) % (math.pi * 2) - math.pi

    local vel = root.AssemblyLinearVelocity / Main.adSpeed
    Main.adSpin += ((Main.adYaw - last) / dt - Main.adSpin) * ease
    Main.adMove = Main.adMove:Lerp(vel.Magnitude > 1 and vel.Unit or vel, ease)

    local h = Main.adHist
    table.insert(h, { Time = now, Yaw = Main.adYaw, Pos = root.Position })
    while h[2] and h[2].Time < now - Main.adStagger * Main.adCount - 0.5 do table.remove(h, 1) end

    local turn = math.clamp(Main.adSpin / Main.adSpinRef, -1, 1)
    local active = math.max(math.abs(turn), math.min(Main.adMove.Magnitude, 1))
    local facing = CFrame.Angles(0, Main.adYaw, 0)
    local spread = Main.adStagger * (#Main.adPanels - 1) * active
    local shake = glitch and Main.adJitter or 0

    for _, p in ipairs(Main.adPanels) do
        if now >= p.Next then Main.adPlace(p, now) end
        if now >= p.NextType then Main.adType(p, now) end

        local lead = math.clamp(-p.Side * turn + facing:VectorToWorldSpace(p.Target.Position.Unit):Dot(Main.adMove), -1, 1)
        p.Lag += ((1 - lead) / 2 * spread - p.Lag) * fade

        local yaw, pos = Main.adSample(now - p.Lag)
        p.Pos = p.Pos and p.Pos:Lerp(pos, drift) or pos
        p.Yaw = p.Yaw or yaw
        p.Vel += (p.Stiff * (yaw - p.Yaw) - p.Damp * p.Vel) * dt
        p.Yaw += p.Vel * dt

        p.Current = p.Current:Lerp(p.Target, glide)
        p.Part.Size = p.Part.Size:Lerp(p.Size, glide)
        p.Part.CFrame = CFrame.new(p.Pos) * CFrame.Angles(0, p.Yaw, 0) * p.Current
            * CFrame.new(
                Main.noise(shake) + math.sin(now * 0.9 + p.Phase * 2) * Main.adSway,
                Main.noise(shake) + math.sin(now * 1.5 + p.Phase) * Main.adBob,
                0
            )
            * CFrame.Angles(0, 0, -p.Vel * Main.adBank)

        if glitch then
            p.Part.Transparency = math.random() < Main.adChaos and Main.rand(Main.adFlicker) or Main.adAlpha
        end
    end
end

function Main.adToggle(on)
    if on == Main.adOn then return end
    Main.adOn = on

    Main.listen("Admin", false)
    Main.kill(Main, { "adFolder" })
    table.clear(Main.adPanels)
    table.clear(Main.adHist)
    Main.adYaw, Main.adSpin, Main.adMove = nil, 0, Vector3.zero

    if on then
        Main.adFolder = Main.new("Folder", { Name = "AdminPanelFX" }, Workspace)
        for i = 1, Main.adCount do Main.adMake(i) end
        Main.listen("Admin", true, RunService.Heartbeat, Main.adStep)
    end
end

function Main.adRebuild()
    if Main.adOn then
        Main.adToggle(false)
        Main.adToggle(true)
    end
end

function Main.flTgt()
    local p = Players:FindFirstChild(Main.flName or "")
    local c = p and p.Character
    return Main.alive(c) and Main.root(c) or nil
end

function Main.flStep()
    local c = localPlayer.Character
    if not c then return end
    for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") then
            if Main.flCC[p] == nil then Main.flCC[p] = p.CanCollide end
            p.CanCollide = false
        end
    end
end

function Main.flLoop()
    while true do
        RunService.Heartbeat:Wait()
        local c, h, r = Main.char()
        if r and h and h.Health > 0 then
            if tick() - Main.flSince < 0.3 then
                r.AssemblyLinearVelocity = Vector3.zero
            else
                local v = r.AssemblyLinearVelocity
                r.AssemblyLinearVelocity = v * Main.flForce + Vector3.new(Main.flForce / 2, 5, Main.flForce / 2)
                RunService.RenderStepped:Wait()
                r.AssemblyLinearVelocity = v
                RunService.Stepped:Wait()
                r.AssemblyLinearVelocity = v + Vector3.new(0, 0.1, 0)
            end
        end
    end
end

function Main.flReset()
    for p, v in pairs(Main.flCC) do
        if p.Parent then p.CanCollide = v end
        Main.flCC[p] = nil
    end
    local r = Main.root(localPlayer.Character)
    if r then
        r.AssemblyLinearVelocity = Vector3.zero
        r.AssemblyAngularVelocity = Vector3.zero
    end
end

function Main.flSync()
    if Main.flOn or Main.flFollowing then
        if not Main.flJob then
            Main.flSince = tick()
            Main.listen("FlingNoclip", true, RunService.Stepped, Main.flStep)
            Main.flJob = task.spawn(Main.flLoop)
        end
    elseif Main.flJob then
        task.cancel(Main.flJob)
        Main.flJob = nil
        Main.listen("FlingNoclip", false)
        Main.flReset()
    end
end

function Main.flEnd(back)
    if not Main.flFollowing then return end
    Main.flFollowing = false
    Main.listen("FlingFollow", false)
    Main.flSync()

    local r = Main.root(localPlayer.Character)
    if back and r and Main.flOrigCF then
        r.CFrame = Main.flOrigCF
        r.AssemblyLinearVelocity = Vector3.zero
        Main.flSince = tick()
    end
    Main.flOrigCF, Main.flUntil = nil, nil
end

function Main.flFollow(duration)
    if not (Main.flTgt() and Main.root(localPlayer.Character)) then return false end
    Main.flEnd(true)
    Main.flUntil = duration and tick() + duration
    Main.flFollowing = true

    Main.listen("FlingFollow", true, RunService.Heartbeat, function()
        local t = Main.flTgt()
        if not t or (Main.flUntil and tick() > Main.flUntil) then
            Main.flEnd(true)
            return
        end
        local r = Main.root(localPlayer.Character)
        if r then
            Main.flOrigCF = Main.flOrigCF or r.CFrame
            r.CFrame = t.CFrame
        end
    end)

    Main.flSync()
    return true
end

function Main.flWatch(on)
    Main.listen("FlingWatch", on, RunService.Heartbeat, function()
        if not Main.flFollowing then Main.flFollow(nil) end
    end)
end

function Main.camSubject()
    local cam = Main.cam()
    local s = cam and cam.CameraSubject
    if not s then return end
    if s:IsA("Humanoid") then
        local m = s.Parent
        return m, s.RootPart or (m and m:FindFirstChild("HumanoidRootPart"))
    elseif s:IsA("BasePart") then
        return s.Parent, s
    end
end

function Main.camAimPos(model)
    if not model then return end
    local p = model:FindFirstChild(Main.camPart) or model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart")
    return p and p.Position
end

function Main.camValid(root)
    if not (root and root.Parent and root:IsDescendantOf(Workspace)) then return false end
    local plr = Players:GetPlayerFromCharacter(root.Parent)
    return plr ~= nil and plr.Parent ~= nil and plr.Character == root.Parent and Main.alive(root.Parent)
end

function Main.camInFov(root, margin)
    if not Main.camFov then return true end
    local cam = Main.cam()
    if not cam then return false end

    local rel = (Main.camCF or cam.CFrame):PointToObjectSpace(root.Position)
    if rel.Z >= 0 then return false end

    local focal = cam.ViewportSize.Y / 2 / math.tan(math.rad(cam.FieldOfView) / 2)
    return Vector2.new(rel.X, rel.Y).Magnitude / -rel.Z * focal <= Main.camRadius * (margin or 1)
end

function Main.camTargets()
    local model, root = Main.camSubject()
    if not root then return {} end

    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        local c = plr.Character
        if plr ~= localPlayer and c and c ~= model and Main.alive(c) then
            local r = c:FindFirstChild("HumanoidRootPart")
            if r and r:IsDescendantOf(Workspace) and Main.camInFov(r) then
                table.insert(list, { r = r, d = (r.Position - root.Position).Magnitude })
            end
        end
    end
    table.sort(list, function(a, b) return a.d < b.d end)
    return list
end

function Main.camNearest()
    local t = Main.camTargets()
    return t[1] and t[1].r
end

function Main.camNext()
    local list = Main.camTargets()
    if #list <= 1 then return list[1] and list[1].r end

    for i, t in ipairs(list) do
        if t.r == Main.camTarget then return list[(i % #list) + 1].r end
    end
    return list[1].r
end

function Main.camRelease()
    Main.camTarget, Main.camCF, Main.camSeen = nil, nil, nil
end

function Main.camUpdateQuick()
    if not Main.camBtn then return end
    local on = Main.camOn
    Main.camBtn.Text = on and "CAMLOCK: ON" or "CAMLOCK: OFF"
    Main.tween(Main.camBtn, { TextColor3 = on and Color3.fromRGB(255, 75, 75) or Color3.fromRGB(200, 200, 200) }, 0.3)
    Main.tween(Main.camStroke, { Color = on and Color3.fromRGB(255, 75, 75) or Color3.fromRGB(60, 60, 60) }, 0.3)
end

function Main.camResize()
    local s = Main.camScale
    local size = UDim2.new(0, 130 * s, 0, 45 * s)
    for _, p in ipairs({ { Main.camFrame, Main.camBtn }, { Main.camSFrame, Main.camSBtn } }) do
        if p[1] then
            Main.tween(p[1], { Size = size }, 0.2)
            if p[2] then p[2].TextSize = 14 * s end
        end
    end
end

function Main.camSetupFov()
    Main.fresh("CamlockFov")
    local gui = Main.new("ScreenGui", { Name = "CamlockFov", ResetOnSpawn = false, IgnoreGuiInset = true }, CoreGui)

    local circle = Main.new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, Main.camRadius * 2, 0, Main.camRadius * 2),
        BackgroundTransparency = 1, BorderSizePixel = 0, Active = false, Visible = Main.camFov,
    }, gui)
    Main.new("UICorner", { CornerRadius = UDim.new(1, 0) }, circle)
    Main.new("UIStroke", { Thickness = 1, Color = Color3.fromRGB(0, 255, 100) }, circle)

    Main.camCircle = circle
end

function Main.camUpdateFov()
    if not Main.camCircle then return end
    Main.camCircle.Visible = Main.camFov
    Main.tween(Main.camCircle, { Size = UDim2.new(0, Main.camRadius * 2, 0, Main.camRadius * 2) }, 0.1)
end

function Main.camDrag(frame, button, onClick)
    local dragInput, dragging, startPos, dragStart, dist = nil, false, nil, nil, 0

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, dragInput, dragStart, startPos, dist = true, input, input.Position, frame.Position, 0
            Main.tween(frame, { Size = UDim2.new(0, 120 * Main.camScale, 0, 40 * Main.camScale) }, 0.1)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local d = input.Position - dragStart
            dist = d.Magnitude
            if dist > 5 then
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input == dragInput then
            dragging, dragInput = false, nil
            Main.tween(frame, { Size = UDim2.new(0, 130 * Main.camScale, 0, 45 * Main.camScale) }, 0.15)
            if dist < 10 and onClick then onClick() end
        end
    end)
end

function Main.camMakeBtn(gui, y, text)
    local s = Main.camScale
    local frame = Main.new("Frame", {
        Size = UDim2.new(0, 130 * s, 0, 45 * s), Position = UDim2.new(0.85, 0, y, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20), BorderSizePixel = 0, Active = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
    }, gui)
    Main.new("UICorner", { CornerRadius = UDim.new(0, 12) }, frame)
    local stroke = Main.new("UIStroke", { Thickness = 2, Color = Color3.fromRGB(60, 60, 60) }, frame)
    local btn = Main.new("TextButton", {
        Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
        TextSize = 14 * s, Text = text or "", TextColor3 = Color3.fromRGB(200, 200, 200),
    }, frame)
    return frame, btn, stroke
end

function Main.camSetupGui()
    Main.fresh("QuickCamlock")
    local gui = Main.new("ScreenGui", { Name = "QuickCamlock", ResetOnSpawn = false }, CoreGui)

    Main.camFrame, Main.camBtn, Main.camStroke = Main.camMakeBtn(gui, 0.45)
    Main.camFrame.Visible = Main.camQuick
    Main.camSFrame, Main.camSBtn, Main.camSStroke = Main.camMakeBtn(gui, 0.55, "Switch Target")
    Main.camSFrame.Visible = Main.camSwitch

    Main.camDrag(Main.camFrame, Main.camBtn, function() Main.camToggle(not Main.camOn) end)
    Main.camDrag(Main.camSFrame, Main.camSBtn, function()
        if not Main.camOn then return end
        Main.camTarget = Main.camNext()
        Main.tween(Main.camSBtn, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.1)
        Main.tween(Main.camSStroke, { Color = Color3.fromRGB(255, 170, 0) }, 0.1)
        task.delay(0.2, function()
            Main.tween(Main.camSBtn, { TextColor3 = Color3.fromRGB(200, 200, 200) }, 0.2)
            Main.tween(Main.camSStroke, { Color = Color3.fromRGB(60, 60, 60) }, 0.2)
        end)
    end)

    Main.camUpdateQuick()
end

function Main.camToggle(on)
    Main.camOn = on
    Main.camUpdateQuick()

    RunService:UnbindFromRenderStep("Camlock_SyncRender")
    Main.camRelease()
    if not on then return end

    RunService:BindToRenderStep("Camlock_SyncRender", 250, function()
        local cam = Main.cam()
        if not cam then return end

        local _, root = Main.camSubject()
        if not root then
            Main.camRelease()
            return
        end

        local t, now = Main.camTarget, os.clock()
        local valid = Main.camValid(t)
        if valid and Main.camInFov(t, 1.15) then Main.camSeen = now end

        if not (valid and now - (Main.camSeen or 0) < 0.5) then
            t = Main.camNearest()
            if not t then
                Main.camRelease()
                return
            end
            Main.camTarget, Main.camSeen = t, now
        end

        local zoom = (cam.CFrame.Position - cam.Focus.Position).Magnitude
        local aim = Main.camAimPos(t.Parent) or t.Position
        local anchor = root.Position + Vector3.new(0, Main.camHeight, 0)
        local want = (aim - anchor).Unit
        local dir = (Main.camCF or cam.CFrame).LookVector:Lerp(want, Main.camSmooth).Unit
        local pos = anchor - dir * zoom

        Main.camCF = CFrame.lookAt(pos, pos + dir)
        cam.CFrame = Main.camCF
        cam.Focus = CFrame.new(anchor)
    end)
end

function Main.camShow(frame, on)
    if not frame then return end

    local pos = frame.Position
    local out = UDim2.new(1.3, 0, pos.Y.Scale, pos.Y.Offset)
    local a = on and 0 or 1

    if on then
        frame.Visible = true
        frame.Position = out
        frame.BackgroundTransparency = 1
    end

    Main.tween(frame, { Position = on and pos or out, BackgroundTransparency = a }, 0.35)
    for _, c in ipairs(frame:GetChildren()) do
        if c:IsA("TextButton") then Main.tween(c, { TextTransparency = a }, 0.35) end
        if c:IsA("UIStroke") then Main.tween(c, { Transparency = a }, 0.35) end
    end

    if not on then
        task.delay(0.35, function()
            frame.Visible = false
            frame.Position = pos
        end)
    end
end

Main.camSetupGui()
Main.camSetupFov()

Main.godModes = {
    Undead = function(h, on)
        h.RequiresNeck, h.BreakJointsOnDeath = not on, not on
        h:SetStateEnabled(Enum.HumanoidStateType.Dead, not on)
        if on then
            Main.godConn(h.StateChanged, function(_, s)
                if s == Enum.HumanoidStateType.Dead then h:ChangeState(Enum.HumanoidStateType.GettingUp) end
            end)
        end
    end,
    ["Inf Health"] = function(h, on)
        if on then Main.godHp = h.MaxHealth end
        h.MaxHealth = on and math.huge or Main.godHp
        h.Health = h.MaxHealth
        if on then
            Main.godConn(h.HealthChanged, function()
                if h.Health < h.MaxHealth then h.Health = h.MaxHealth end
            end)
        end
    end,
}

function Main.godConn(sig, fn)
    table.insert(Main.godConns, sig:Connect(fn))
end

function Main.godRun(char, on)
    local h = char and char:FindFirstChildOfClass("Humanoid")
    if not h then return end
    if on then Main.godActive = table.clone(Main.godSel) end
    for n in pairs(Main.godActive) do Main.godModes[n](h, on) end
    if not on then table.clear(Main.godActive) end

    local ff = char:FindFirstChild("GodFF")
    if ff then ff:Destroy() end
    if on then
        Main.new("ForceField", { Name = "GodFF", Visible = false }, char)
    end
end

function Main.godSet(on)
    Main.cut(Main.godConns)
    Main.godRun(playerCharacter, false)
    Main.godOn = on
    if on then
        task.spawn(Main.godRun, playerCharacter, true)
        Main.godConn(localPlayer.CharacterAdded, function(c)
            c:WaitForChild("Humanoid", 5)
            Main.godRun(c, true)
        end)
    end
end

function Main.toolHas(text, list)
    text = text:lower()
    for _, w in ipairs(list) do
        if text:find(w, 1, true) then return true end
    end
    return false
end

function Main.toolIsDrop(text)
    return Main.toolHas(text, Main.toolDropWords) and not Main.toolHas(text, Main.toolNotDrop)
end

function Main.toolIsPress(input)
    local k = input.UserInputType
    return k == Enum.UserInputType.Touch or k == Enum.UserInputType.MouseButton1
end

function Main.toolOwn(parent)
    local c = localPlayer.Character
    return parent ~= nil and (parent:IsDescendantOf(localPlayer) or (c ~= nil and (parent == c or parent:IsDescendantOf(c))))
end

function Main.toolPack(wait)
    return localPlayer:FindFirstChildOfClass("Backpack") or (wait and localPlayer:WaitForChild("Backpack", 5)) or nil
end

function Main.toolCurrent()
    for _, t in ipairs(Main.toolList) do
        if t:Held() then return t end
    end
end

function Main.toolAny()
    for _, t in ipairs(Main.toolList) do
        if t.Tool and t.Tool.Parent then return true end
    end
    return false
end

function Main.toolDropAll()
    for _, t in ipairs(Main.toolList) do t:Drop() end
end

function Main.toolRestore()
    if not Main.toolAuto then return end
    for _, t in ipairs(Main.toolList) do
        if t.Owned then t:Give() end
    end
end

function Main.toolNew(def)
    def.Active = false
    def.Conns = {}
    table.insert(Main.toolList, def)
    return setmetatable(def, Main.toolClass)
end

function Main.toolEach(method, fn, ...)
    for _, root in ipairs(Main.toolRoots) do
        local ok, list = pcall(root[method], root, ...)
        for _, obj in ipairs(ok and list or {}) do
            local res = fn(obj)
            if res then return res end
        end
    end
end

function Main.toolWalk(fn)
    return Main.toolEach("GetDescendants", function(o)
        if o:IsA("GuiObject") then return fn(o) end
    end)
end

function Main.toolOverGui(pos)
    return Main.toolEach("GetGuiObjectsAtPosition", function(o)
        return o.Active or o:IsA("GuiButton")
    end, pos.X, pos.Y) == true
end

function Main.toolInBar(obj)
    local n = obj.Parent
    while n do
        if Main.toolHas(n.Name, Main.toolBar) then return true end
        n = n.Parent
    end
    return false
end

function Main.toolFind(name)
    local low = name:lower()
    return Main.toolWalk(function(o)
        if o.Visible and (o.Name:lower() == low
            or ((o:IsA("TextLabel") or o:IsA("TextButton")) and o.Text:lower() == low))
            and Main.toolInBar(o) then
            return o
        end
    end)
end

function Main.toolDiscover()
    if Main.toolCtrl or not getgc then return end

    local n = 0
    for _, obj in ipairs(getgc(true)) do
        n += 1
        if n % 1500 == 0 then task.wait() end
        if type(obj) == "table" then
            local found = {}
            for k, v in pairs(obj) do
                if type(k) == "string" then
                    found.Hint = found.Hint or Main.toolHas(k, Main.toolHint)
                    if type(v) == "function" then
                        for role, words in pairs(Main.toolWords) do
                            if not found[role] and Main.toolHas(k, words) then found[role] = v end
                        end
                    end
                end
            end
            if found.Hint and found.Equip and found.Refresh then
                Main.toolCtrl = { Obj = obj, Refresh = found.Refresh }
                return
            end
        end
    end
end

function Main.toolScanDrops()
    for _, o in ipairs(ReplicatedStorage:GetDescendants()) do
        if (o:IsA("RemoteEvent") or o:IsA("RemoteFunction")) and Main.toolIsDrop(o.Name) then
            Main.toolDrops[o] = true
        end
    end
end

function Main.toolHookDrop()
    if Main.toolHooked or not next(Main.toolDrops) then return end
    if not (hookmetamethod and newcclosure and getnamecallmethod) then return end

    Main.toolHooked = true
    local env = getgenv()
    env.NaNTools = Main
    if env.NaNHooked then return end
    env.NaNHooked = true

    local oldNc
    oldNc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local cur = env.NaNTools
        if cur and cur.toolDrops[self] then
            local m = getnamecallmethod()
            local t = (m == "FireServer" or m == "InvokeServer") and cur.toolCurrent()
            if t then
                t:DropLater(0)
                return
            end
        end
        return oldNc(self, ...)
    end))
end

function Main.toolSetup()
    if Main.toolReady then return end
    for _, step in ipairs({ Main.toolDiscover, Main.toolScanDrops, Main.toolHookDrop }) do
        pcall(step)
    end
    Main.toolReady = true
end

function Main.toolOnDropInput(input)
    local t = Main.toolIsPress(input) and Main.toolCurrent()
    if t then t:DropLater(0.1) end
end

function Main.toolBindDrop(on)
    for o, c in pairs(Main.toolDropConns) do
        if not (on and o.Parent) then
            c:Disconnect()
            Main.toolDropConns[o] = nil
        end
    end
    if not on or next(Main.toolDropConns) then return end

    Main.toolWalk(function(o)
        if o:IsA("GuiButton") and o.Visible
            and (Main.toolIsDrop(o.Name) or (o:IsA("TextButton") and Main.toolIsDrop(o.Text))) then
            Main.toolDropConns[o] = o.InputBegan:Connect(Main.toolOnDropInput)
        end
    end)
end

function Main.toolOnChar(char)
    Main.toolDropAll()

    local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
    if not hum or localPlayer.Character ~= char then return end

    hum.Died:Once(function()
        if localPlayer.Character == char then Main.toolDropAll() end
    end)
    Main.toolRestore()
end

function Main.toolClass:OnActive() end

function Main.toolClass:Held()
    local c = localPlayer.Character
    return self.Tool ~= nil and c ~= nil and self.Tool.Parent == c
end

function Main.toolClass:SetActive(state)
    if self.Active ~= state then
        self.Active = state
        self:OnActive(state)
    end
end

function Main.toolClass:OnTool(state)
    self:SetActive(state)
    task.delay(0.3, self.Check, self)
end

function Main.toolClass:Toggle()
    local want = not self.Active
    local _, hum = Main.char()
    local pack = Main.toolPack()

    if self.Tool and self.Tool.Parent and hum and pack then
        if want then
            pcall(hum.EquipTool, hum, self.Tool)
        else
            self.Tool.Parent = pack
        end
    end
    self:SetActive(want)
end

function Main.toolClass:OnSlotInput(input)
    if not Main.toolIsPress(input) then return end

    local before, tool = self.Active, self.Tool
    task.delay(0.2, function()
        if tool and tool == self.Tool and tool.Parent and self.Active == before then
            self:Toggle()
        end
    end)
end

function Main.toolClass:Bind(ui)
    if self.BindConn then
        self.BindConn:Disconnect()
        self.BindConn = nil
    end
    if not ui then return end

    local btn = ui:IsA("GuiButton") and ui or ui:FindFirstAncestorWhichIsA("GuiButton") or ui
    self.BindConn = btn.InputBegan:Connect(function(input)
        self:OnSlotInput(input)
    end)
end

function Main.toolClass:Check()
    if not (self.Tool and self.Tool.Parent) then return self:Clear() end

    if not (self.Ui and self.Ui.Parent) then
        self.Ui = Main.toolFind(self.Name)
        self:Bind(self.Ui)
    end
    Main.toolBindDrop(true)
end

function Main.toolClass:Clear()
    self.Tool, self.Ui = nil, nil
    Main.cut(self.Conns)
    self:Bind()
    self:SetActive(false)
    Main.toolBindDrop(Main.toolAny())
end

function Main.toolClass:Drop()
    local tool = self.Tool
    self:Clear()
    if tool then tool:Destroy() end
end

function Main.toolClass:DropLater(delay)
    local tool = self.Tool
    task.delay(delay, function()
        if tool == self.Tool then
            self.Owned = false
            self:Drop()
        end
    end)
end

function Main.toolClass:Give()
    Main.toolSetup()

    local pack = Main.toolPack(true)
    if not pack then return end
    self.Owned = true

    if not (self.Tool and self.Tool.Parent) then
        self:Drop()

        local tool = Main.new("Tool", { Name = self.Name, ToolTip = self.ToolTip, RequiresHandle = false, CanBeDropped = true })
        self.Tool = tool

        self.Conns.Equipped = tool.Equipped:Connect(function() self:OnTool(true) end)
        self.Conns.Unequipped = tool.Unequipped:Connect(function() self:OnTool(false) end)
        self.Conns.Ancestry = tool.AncestryChanged:Connect(function(child)
            task.delay(0.15, function()
                if child == self.Tool and not Main.toolOwn(child.Parent) then self:Drop() end
            end)
        end)
    end

    if not self:Held() then self.Tool.Parent = pack end
    if Main.toolCtrl then pcall(Main.toolCtrl.Refresh, Main.toolCtrl.Obj) end

    task.delay(0.6, self.Check, self)
end

Main.toolTeleport = Main.toolNew({
    Name = "Teleport",
    ToolTip = "Tap anywhere to teleport.",
    Input = {},
    Params = RaycastParams.new(),
})
Main.toolTeleport.Params.FilterType = Enum.RaycastFilterType.Exclude

function Main.toolTeleport:Go(pos)
    local c, _, root = Main.char()
    if root then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        c:PivotTo(CFrame.new(pos) * root.CFrame.Rotation)
    end
end

function Main.toolTeleport:Cast(pos)
    local cam = Main.cam()
    if not cam then return end

    self.Params.FilterDescendantsInstances = { localPlayer.Character, Main.bpRealChar }

    local ray = cam:ScreenPointToRay(pos.X, pos.Y)
    local hit = Workspace:Raycast(ray.Origin, ray.Direction * 5000, self.Params)
    if hit then self:Go(hit.Position + Vector3.new(0, 3, 0)) end
end

function Main.toolTeleport:OnBegin(input)
    if not Main.toolIsPress(input) then return end
    self.Tap = {
        Input = input,
        Pos = input.Position,
        Time = os.clock(),
        Blocked = Main.toolOverGui(input.Position),
    }
end

function Main.toolTeleport:OnEnd(input)
    local tap = self.Tap
    if not (tap and tap.Input == input) then return end
    self.Tap = nil

    if not tap.Blocked and not Main.toolOverGui(input.Position)
        and os.clock() - tap.Time < 0.35
        and (input.Position - tap.Pos).Magnitude < 15 then
        self:Cast(input.Position)
    end
end

function Main.toolTeleport:OnActive(state)
    self.Tap = nil
    Main.cut(self.Input)

    if state then
        self.Input.Begin = UserInputService.InputBegan:Connect(function(i) self:OnBegin(i) end)
        self.Input.End = UserInputService.InputEnded:Connect(function(i) self:OnEnd(i) end)
    end
end

Main.toolAnim = Main.toolNew({
    Name = "Animation",
    ToolTip = "Play loop animation.",
    Anims = {
        R6 = { Id = "rbxassetid://72042024", Speed = 0.65 },
        R15 = { Id = "rbxassetid://698251653", Speed = 0.7 },
    },
})

function Main.toolAnim:Stop()
    self.Looping = false
    if self.Track then
        pcall(self.Track.Stop, self.Track)
        self.Track = nil
    end
    if self.Thread then
        pcall(task.cancel, self.Thread)
        self.Thread = nil
    end
end

function Main.toolAnim:Start()
    if self.Looping then return end
    self.Looping = true

    self.Thread = task.spawn(function()
        while self.Looping do
            local _, hum = Main.char()
            if not hum or hum.Health <= 0 then break end

            local cfg = self.Anims[hum.RigType == Enum.HumanoidRigType.R15 and "R15" or "R6"]

            if not self.Track then
                local anim = Main.new("Animation", { AnimationId = cfg.Id })
                self.Track = (hum:FindFirstChildWhichIsA("Animator") or hum):LoadAnimation(anim)
            end

            self.Track:Play()
            self.Track:AdjustSpeed(cfg.Speed)
            self.Track.TimePosition = 0.6
            task.wait(0.1)

            while self.Looping and self.Track and self.Track.TimePosition < cfg.Speed do
                task.wait(0.1)
            end

            if self.Track then
                self.Track:Stop()
                self.Track = nil
            end
        end

        self.Looping = false
        self.Thread = nil
    end)
end

function Main.toolAnim:OnActive(state)
    if state then self:Start() else self:Stop() end
end

if localPlayer.Character then
    task.spawn(Main.toolOnChar, localPlayer.Character)
end

function Main.hopCreature(part)
    local cached = Main.hopCache[part]
    if cached ~= nil then return cached end

    local res = false
    local a = part.Parent
    while a and a ~= Workspace do
        if a:FindFirstChildOfClass("Humanoid") then
            res = true
            break
        end
        a = a.Parent
    end

    Main.hopCache[part] = res
    return res
end

function Main.hopStep()
    local now = os.clock()
    if now - Main.hopCheck < Main.hopInterval then return end
    Main.hopCheck = now

    local hum = playerCharacter:FindFirstChildOfClass("Humanoid")
    local root = playerCharacter:FindFirstChild("HumanoidRootPart")

    if not (hum and root) or hum.Health <= 0 then return end
    if hum.FloorMaterial ~= Enum.Material.Air then return end
    if now - Main.hopLast < Main.hopCooldown then return end

    if Main.hopChar ~= playerCharacter then
        Main.hopChar = playerCharacter
        Main.hopParams.FilterDescendantsInstances = { playerCharacter }
    end

    local walls = 0
    local parts = Workspace:GetPartBoundsInBox(
        root.CFrame,
        root.Size + Vector3.new(Main.hopMargin * 2, 0, Main.hopMargin * 2),
        Main.hopParams
    )
    for _, p in ipairs(parts) do
        if not Main.hopCreature(p) then walls += 1 end
    end

    if walls >= Main.hopMin then
        local v = root.AssemblyLinearVelocity
        local power = hum.UseJumpPower and hum.JumpPower or math.sqrt(2 * Workspace.Gravity * hum.JumpHeight)

        Main.hopLast = now
        root.AssemblyLinearVelocity = Vector3.new(v.X, power * Main.hopMult, v.Z)
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

function Main.srvText()
    return ("Players: %d/%d\nServer ID: %s"):format(#Players:GetPlayers(), Players.MaxPlayers, game.JobId)
end

function Main.srvJoin(id)
    if id ~= "" then
        pcall(TeleportService.TeleportToPlaceInstance, TeleportService, game.PlaceId, id, localPlayer)
    end
end

function Main.srvRejoin()
    if #Players:GetPlayers() <= 1 then
        TeleportService:Teleport(game.PlaceId, localPlayer)
    else
        Main.srvJoin(game.JobId)
    end
end

function Main.srvHop()
    local pool, cursor = {}, ""

    for _ = 1, 3 do
        local ok, data = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s"):format(game.PlaceId, cursor)
            ))
        end)
        if not ok then break end

        for _, s in ipairs(data.data or {}) do
            if s.id ~= game.JobId and s.playing < s.maxPlayers then table.insert(pool, s.id) end
        end

        cursor = data.nextPageCursor
        if not cursor then break end
    end

    if #pool > 0 then Main.srvJoin(pool[math.random(#pool)]) end
end

function Main.srvAuto(name, on)
    if Main.srvJobs[name] then
        task.cancel(Main.srvJobs[name])
        Main.srvJobs[name] = nil
    end

    if on then
        Main.srvJobs[name] = task.spawn(function()
            local start = tick()
            while tick() - start < Main.srvMinutes * 60 do task.wait(1) end
            Main["srv" .. name]()
        end)
    end
end

function Main.glidePick()
    for _, n in ipairs({ "Fly", "Swim" }) do
        if Main.mvGlide[n].Wanted then return n end
    end
end

function Main.glideHold(_, new)
    local hum, cfg = Main.mvHum, Main.mvGlide[Main.mvMode]
    if cfg and cfg.State and hum.Health > 0 and new ~= cfg.State and not Main.mvSkip[new] then
        task.defer(function()
            if Main.mvGlide[Main.mvMode] == cfg and hum.Parent then hum:ChangeState(cfg.State) end
        end)
    end
end

function Main.glideUpdate()
    local cam, hum, cfg = Main.cam(), Main.mvHum, Main.mvGlide[Main.mvMode]
    if not (cam and hum and cfg and Main.mvVel) then return end

    local dir, flat = Main.moveDir(hum, hum.Jump)

    if Main.mvAligner then
        if cfg.Tilt then
            Main.mvAligner.CFrame = cam.CFrame.Rotation
        elseif flat.Magnitude > 0.01 then
            Main.mvAligner.CFrame = CFrame.lookAt(Vector3.zero, flat)
        end
        for _, t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop(0) end
    end

    Main.mvVel.VectorVelocity = dir * cfg.Value
end

function Main.glideStop()
    local cfg = Main.mvGlide[Main.mvMode]
    Main.mvMode = nil

    Main.cut(Main.mvGlideConns)
    Main.kill(Main, { "mvVel", "mvAligner", "mvAttach" })

    if Main.mvAnimate then
        Main.mvAnimate.Disabled = false
        Main.mvAnimate = nil
    end

    local hum = Main.mvHum
    if hum and hum.Parent then
        if cfg.Freeze then hum.AutoRotate = true end
        for s, was in pairs(Main.mvSaved) do
            pcall(hum.SetStateEnabled, hum, s, was)
        end
        if cfg.State and hum.Health > 0 then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end

    table.clear(Main.mvSaved)
    Main.mvHum = nil
end

function Main.glideStart(name, hum, root)
    local cfg = Main.mvGlide[name]
    Main.mvMode, Main.mvHum = name, hum

    for _, s in ipairs(cfg.State and Enum.HumanoidStateType:GetEnumItems() or {}) do
        if s ~= cfg.State and not Main.mvSkip[s] then
            local ok, was = pcall(hum.GetStateEnabled, hum, s)
            if ok then
                Main.mvSaved[s] = was
                pcall(hum.SetStateEnabled, hum, s, false)
            end
        end
    end

    if cfg.State then
        hum:SetStateEnabled(cfg.State, true)
        hum:ChangeState(cfg.State)
    end

    Main.mvAttach = Main.new("Attachment", { Name = "NaNGlideAttachment" }, root)
    Main.mvVel = Main.new("LinearVelocity", {
        Name = "NaNGlideVelocity",
        Attachment0 = Main.mvAttach,
        RelativeTo = Enum.ActuatorRelativeTo.World,
        VelocityConstraintMode = Enum.VelocityConstraintMode.Vector,
        MaxForce = math.huge,
        VectorVelocity = Vector3.zero,
    }, root)

    if cfg.Freeze then
        Main.mvAligner = Main.new("AlignOrientation", {
            Name = "NaNGlideAligner",
            Mode = Enum.OrientationAlignmentMode.OneAttachment,
            Attachment0 = Main.mvAttach,
            RigidityEnabled = true,
            MaxTorque = math.huge,
        }, root)
        Main.mvAnimate = hum.Parent:FindFirstChild("Animate")
        if Main.mvAnimate then Main.mvAnimate.Disabled = true end
        hum.AutoRotate = false
    end

    local c = Main.mvGlideConns
    table.insert(c, hum.StateChanged:Connect(Main.glideHold))
    table.insert(c, RunService.Heartbeat:Connect(Main.glideUpdate))
    table.insert(c, hum.Died:Connect(Main.glideSync))
    table.insert(c, hum.AncestryChanged:Connect(Main.glideSync))
end

function Main.glideSync()
    local _, hum, root = Main.char()
    local want = hum ~= nil and root ~= nil and hum.Health > 0 and Main.glidePick()

    if Main.mvMode and (want ~= Main.mvMode or Main.mvHum ~= hum) then Main.glideStop() end
    if want and not Main.mvMode then Main.glideStart(want, hum, root) end
end

function Main.glideRespawn(char)
    Main.glideSync()

    if Main.glidePick() then
        char:WaitForChild("Humanoid")
        char:WaitForChild("HumanoidRootPart")
        task.wait(0.5)
        Main.glideSync()
    end
end

function Main.gravFmt(n)
    return tostring(math.round(n * 100) / 100)
end

function Main.gravStatus()
    if not Main.gravLabel then return end

    local text = "Gravity original: " .. Main.gravFmt(Main.gravOrig)
        .. "\nGravity custom: " .. (Main.gravCustom and Main.gravFmt(Main.gravCustom) or "None")

    if text ~= Main.gravShown then
        Main.gravShown = text
        Main.gravLabel:SetDesc(text)
    end
end

function Main.gravSet(n)
    Main.gravCustom = n
    Workspace.Gravity = n
    Main.gravStatus()
end

function Main.gravRestore()
    Main.gravCustom = nil
    Workspace.Gravity = Main.gravOrig
    Main.gravStatus()
end

function Main.mvStep()
    if Main.gravCustom ~= nil then
        if Workspace.Gravity ~= Main.gravCustom then Workspace.Gravity = Main.gravCustom end
    elseif Workspace.Gravity ~= Main.gravOrig then
        Main.gravOrig = Workspace.Gravity
        Main.gravStatus()
    end

    local char, hum = Main.char()
    if not hum then return end

    for _, p in pairs(Main.mvProps) do
        if p.Wanted then
            if p.Old == nil then p.Old = hum[p.Prop] end
            if p.Use and hum[p.Use] ~= true then hum[p.Use] = true end
            if hum[p.Prop] ~= p.Value then hum[p.Prop] = p.Value end
        elseif p.Old ~= nil then
            hum[p.Prop] = p.Old
            p.Old = nil
        end
    end

    if Main.mvNoclip then
        local now = os.clock()
        if Main.mvNcChar ~= char or now - Main.mvNcAt > 0.5 then
            Main.mvNcChar, Main.mvNcAt, Main.mvNcList = char, now, {}
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then table.insert(Main.mvNcList, p) end
            end
        end
        for _, p in ipairs(Main.mvNcList) do
            if Main.mvParts[p] == nil then Main.mvParts[p] = p.CanCollide end
            if p.CanCollide then p.CanCollide = false end
        end
    else
        for p, was in pairs(Main.mvParts) do
            if p.Parent then p.CanCollide = was end
            Main.mvParts[p] = nil
        end
    end
end

Main.listen("Movement", true, RunService.Stepped, Main.mvStep)

UserInputService.JumpRequest:Connect(function()
    local _, hum = Main.char()
    if Main.mvInfJump and not Main.mvMode and hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

function Main.espIsNPC(m)
    return typeof(m) == "Instance" and m:IsA("Model")
        and m:FindFirstChildOfClass("Humanoid") ~= nil
        and Players:GetPlayerFromCharacter(m) == nil
end

function Main.espIsStatic(m)
    if not (typeof(m) == "Instance" and m:IsA("Model")) or m:IsDescendantOf(Camera) then return false end

    local n = m
    while n and n ~= Workspace do
        if n:IsA("Model") and n:FindFirstChildOfClass("Humanoid") then return false end
        n = n.Parent
    end
    return true
end

function Main.espHook(container)
    if Main.espConns[container] then return end
    Main.espConns[container] = container.ChildAdded:Connect(function(child)
        Main.espNPC:Add(child)
    end)
end

function Main.espUnhook(container)
    local c = Main.espConns[container]
    if c then
        c:Disconnect()
        Main.espConns[container] = nil
    end
end

function Main.espLearn(model)
    local container = model.Parent
    if not container or container == Workspace or Main.espContainers[container] then return end

    Main.espContainers[container] = true
    container.Destroying:Once(function()
        Main.espContainers[container] = nil
        Main.espUnhook(container)
    end)

    if Main.espNPC.Active then Main.espHook(container) end
end

Main.espSrcPlayers = {
    Pool = function() return Players:GetPlayers() end,
    Signal = function() return Players.PlayerAdded end,
}

Main.espSrcWorld = {
    Pool = function(scoped)
        local res = {}
        local learned = scoped and next(Main.espContainers)
        for root in pairs(learned and Main.espContainers or { [Workspace] = true }) do
            for _, o in ipairs(learned and root:GetChildren() or root:GetDescendants()) do
                res[#res + 1] = o
            end
        end
        return res
    end,
    Signal = function() return Workspace.DescendantAdded end,
}

function Main.espNew(props)
    props.Forms = { "Highlight" }
    props.TextOptions = { "Name", "Distance" }
    props.Wanted = false
    props.Active = false
    return setmetatable(props, Main.espClass)
end

function Main.espClass:Settings()
    local s = { Color = self.Color, Group = self.Group }
    for _, m in ipairs({ { Main.espFormKeys, self.Forms }, { Main.espTextKeys, self.TextOptions } }) do
        for key, name in next, m[1] do
            s[key] = table.find(m[2], name) ~= nil
        end
    end
    return s
end

function Main.espClass:Each(fn)
    for id, d in next, ESP.Objects do
        if d.Settings.Group == self.Group then fn(id, d) end
    end
end

function Main.espClass:Add(obj)
    if not self.Active then return end

    local target = self.Resolve(self, obj)
    if not target then return end

    local cur = ESP.Objects[target]
    if cur and (cur.Settings.Group == self.Group or not self.Override) then return end

    ESP:DangKy(target, target, self:Settings())
end

function Main.espClass:Refresh()
    if not self.Active then return end
    self:Each(function(id, d)
        ESP:DangKy(id, d.Object, self:Settings())
    end)
end

function Main.espClass:Sync()
    if self.Wanted and not self.Active then
        self.Active = true
        if self.OnEnable then self.OnEnable() end

        for _, o in ipairs(self.Source.Pool(self.Scoped)) do self:Add(o) end
        self.Connection = self.Source.Signal():Connect(function(o) self:Add(o) end)

    elseif not self.Wanted and self.Active then
        self.Active = false
        if self.Connection then
            self.Connection:Disconnect()
            self.Connection = nil
        end
        if self.OnDisable then self.OnDisable() end

        self:Each(function(id) ESP:Huy(id) end)
    end
end

Main.espPlayer = Main.espNew({
    Group = "Player",
    Source = Main.espSrcPlayers,
    Color = Color3.fromRGB(203, 203, 203),
    Resolve = function(_, o) return o end,
})

Main.espNPC = Main.espNew({
    Group = "NPC",
    Source = Main.espSrcWorld,
    Scoped = true,
    Override = true,
    Color = Color3.fromRGB(0, 255, 0),
    Resolve = function(_, o)
        local m = o:IsA("Humanoid") and o.Parent or o
        if Main.espIsNPC(m) then
            Main.espLearn(m)
            return m
        end
    end,
    OnEnable = function()
        for c in pairs(Main.espContainers) do Main.espHook(c) end
    end,
    OnDisable = function()
        for c in pairs(Main.espConns) do Main.espUnhook(c) end
    end,
})

Main.espModel = Main.espNew({
    Group = "Model",
    Source = Main.espSrcWorld,
    Color = Color3.fromRGB(255, 140, 0),
    Resolve = function(self, o)
        if o:IsA("Humanoid") then
            local living = o.Parent
            self:Each(function(id, d)
                if d.Object ~= living and d.Object:IsDescendantOf(living)
                    or d.Object == living and not Main.espIsNPC(living) then
                    ESP:Huy(id)
                end
            end)
            return nil
        end
        if Main.espIsStatic(o) then return o end
    end,
})

function Main.tpZoom(min, max)
    localPlayer.CameraMaxZoomDistance = math.max(max, min)
    localPlayer.CameraMinZoomDistance = min
    localPlayer.CameraMaxZoomDistance = max
end

function Main.freeStop()
    if not Main.freeOn then return end
    Main.freeOn = false

    RunService:UnbindFromRenderStep("TeleportFreecam")

    local cam = Main.cam()
    local _, hum = Main.char()
    if cam and hum then
        cam.CameraSubject = hum
        cam.CameraType = Enum.CameraType.Custom
    end

    if Main.freeRoot and Main.freeRoot.Parent then Main.freeRoot.Anchored = Main.freeAnchored end

    local lim = Main.freeLimits
    if lim then
        local d = math.clamp(Main.freeDist, lim[1], lim[2])
        Main.tpZoom(d, d)
        task.delay(0.15, function() Main.tpZoom(lim[1], lim[2]) end)
    end

    Main.kill(Main, { "freePart", "freeMarker" })
    Main.freeRoot, Main.freeParams, Main.freeLimits, Main.freeHit = nil, nil, nil, nil
    Main.freeVel = Vector3.zero

    if Main.freeToggle then Main.freeToggle:Set(false) end
end

function Main.freeStep(dt)
    local cam = Main.cam()
    local _, hum = Main.char()

    if not (cam and hum and Main.freePart and hum.Health > 0) then
        Main.freeStop()
        return
    end

    local dir = Main.moveDir(hum, hum.Jump)
    hum.Jump = false

    Main.freeVel = Main.freeVel:Lerp(dir * Main.freeSpeed, Main.ease(dt, 10))
    Main.freePart.CFrame = CFrame.new(Main.freePart.Position + Main.freeVel * dt)

    local res = Workspace:Raycast(cam.CFrame.Position, cam.CFrame.LookVector * 1000, Main.freeParams)
    if res then
        Main.freeHit = res.Position
        Main.freeMarker.CFrame = CFrame.new(res.Position)
        Main.freeMarker.Transparency = 0.2
    else
        Main.freeHit = nil
        Main.freeMarker.Transparency = 1
    end
end

function Main.freeStart()
    if Main.freeOn then return end

    local char, hum, root = Main.char()
    local cam = Main.cam()

    if not (hum and root and cam) or hum.Health <= 0 then
        if Main.freeToggle then Main.freeToggle:Set(false) end
        return
    end

    Main.freeOn = true
    Main.freeVel = Vector3.zero
    Main.freeHit = nil
    Main.freeDist = math.max((cam.CFrame.Position - cam.Focus.Position).Magnitude, 0.5)
    Main.freeLimits = { localPlayer.CameraMinZoomDistance, localPlayer.CameraMaxZoomDistance }
    Main.freeRoot, Main.freeAnchored = root, root.Anchored
    root.Anchored = true

    Main.freePart = Main.new("Part", {
        Name = "TeleportFreecamPart", Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false,
        Transparency = 1, Size = Vector3.one, CFrame = CFrame.new(cam.CFrame.Position),
    }, Workspace)
    Main.freeMarker = Main.new("Part", {
        Name = "TeleportFreecamMarker", Shape = Enum.PartType.Ball, Material = Enum.Material.Neon,
        Color = Color3.fromRGB(0, 255, 100), Size = Vector3.one * 1.5,
        Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, Transparency = 1,
    }, Workspace)

    Main.freeParams = RaycastParams.new()
    Main.freeParams.FilterType = Enum.RaycastFilterType.Exclude
    Main.freeParams.FilterDescendantsInstances = { char, Main.freePart, Main.freeMarker }

    Main.tpZoom(0.5, 0.5)
    cam.CameraSubject = Main.freePart
    cam.CameraType = Enum.CameraType.Custom

    RunService:BindToRenderStep("TeleportFreecam", Enum.RenderPriority.Camera.Value - 1, Main.freeStep)
end

function Main.tpGo(pos)
    local char, _, root = Main.char()
    if not root then return end

    Main.freeStop()
    char:PivotTo(CFrame.new(pos) * root.CFrame.Rotation)
    root.AssemblyLinearVelocity = Vector3.zero
end

function Main.tpToPlayer()
    local p = Main.tpPlayer and Players:FindFirstChild(Main.tpPlayer)
    local root = p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    if root then Main.tpGo(root.CFrame:PointToWorldSpace(Vector3.new(0, 0, 4))) end
end

function Main.tpAddPoint(pos)
    Main.tpCount += 1

    local name = string.format("Point %d (%d, %d, %d)", Main.tpCount,
        math.round(pos.X), math.round(pos.Y), math.round(pos.Z))

    Main.tpPos[name] = pos
    table.insert(Main.tpNames, name)
    Main.tpPoint = name

    if Main.tpPointDrop then
        Main.tpPointDrop:Refresh(table.clone(Main.tpNames))
        Main.tpPointDrop:Select(name)
    end
end

function Main.tpPick()
    if Main.freeOn then
        if not Main.freeHit then return end
        Main.tpAddPoint(Main.freeHit + Vector3.new(0, 3, 0))
        Main.freeStop()
        return
    end

    local _, _, root = Main.char()
    if root then Main.tpAddPoint(root.Position) end
end

function Main.tpToPoint()
    local pos = Main.tpPoint and Main.tpPos[Main.tpPoint]
    if pos then Main.tpGo(pos) end
end

function Main.fxIs(inst, classes)
    for _, c in ipairs(classes) do
        if inst:IsA(c) then return true end
    end
    return false
end

function Main.fxPlayerOf(inst)
    while inst and inst ~= Workspace do
        local p = Players:GetPlayerFromCharacter(inst)
        if p then return p end
        inst = inst.Parent
    end
end

function Main.fxWorldPart(inst)
    return inst:IsA("BasePart") and not inst:IsA("Terrain") and not Main.fxPlayerOf(inst)
end

function Main.fxSetAll(targets)
    for _, t in ipairs(targets or {}) do
        if t.Obj.Parent then Main.set(t.Obj, t.Props) end
    end
end

function Main.fxSnapshot(targets)
    local saved = {}
    for _, t in ipairs(targets) do
        local vals = {}
        for k in pairs(t.Props) do vals[k] = t.Obj[k] end
        saved[#saved + 1] = { Obj = t.Obj, Props = vals }
    end
    return saved
end

function Main.fxOverride(key, on, getTargets)
    if on then
        Main.fxSaved[key] = Main.fxSnapshot(getTargets())
    else
        Main.fxSetAll(Main.fxSaved[key])
        Main.fxSaved[key] = nil
    end
    Main.listen(key, on, RunService.Heartbeat, function() Main.fxSetAll(getTargets()) end)
end

Main.fxTargets = {
    FullBright = function()
        return { {
            Obj = Lighting,
            Props = {
                Brightness = 2, ClockTime = 14, GlobalShadows = false,
                Ambient = Color3.new(1, 1, 1), OutdoorAmbient = Color3.new(1, 1, 1),
            },
        } }
    end,
    AntiVoid = function()
        return { { Obj = Workspace, Props = { FallenPartsDestroyHeight = 0 / 0 } } }
    end,
    NoFog = function()
        local t = { { Obj = Lighting, Props = { FogStart = 1e6, FogEnd = 1e9 } } }
        for _, c in ipairs(Lighting:GetChildren()) do
            if c:IsA("Atmosphere") then t[#t + 1] = { Obj = c, Props = { Density = 0, Haze = 0 } } end
        end
        return t
    end,
}

function Main.fxAntiAFK(on)
    Main.listen("AntiAFK", on, localPlayer.Idled, function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

function Main.fxAntiFling(on)
    Main.listen("AntiFling", on, RunService.RenderStepped, function()
        for _, p in ipairs(Players:GetPlayers()) do
            local c = p ~= localPlayer and p.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if r and (r.AssemblyLinearVelocity.Magnitude > 60 or r.AssemblyAngularVelocity.Magnitude > 30) then
                for _, part in ipairs(c:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.AssemblyLinearVelocity = Vector3.zero
                        part.AssemblyAngularVelocity = Vector3.zero
                    end
                end
            end
        end
    end)
end

Main.fxGlobal = {
    function()
        Lighting.GlobalShadows = false
        for _, c in ipairs(Lighting:GetChildren()) do
            if Main.fxIs(c, Main.fxClasses.PostFx) then c.Enabled = false end
        end
    end,
    function()
        Main.set(Main.fxTerrain, { WaterWaveSize = 0, WaterWaveSpeed = 0, WaterReflectance = 0 })
    end,
    function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        if sethiddenproperty then
            pcall(sethiddenproperty, Lighting, "Technology", Enum.Technology.Compatibility)
            pcall(sethiddenproperty, Main.fxTerrain, "Decoration", false)
        end
        for _, c in ipairs(Lighting:GetChildren()) do
            if c:IsA("Atmosphere") then c.Density = 0 end
        end
    end,
    function() end,
}

Main.fxEach = {
    function(i)
        if Main.fxIs(i, Main.fxClasses.Effect) then
            i.Enabled = false
        elseif i:IsA("Explosion") then
            i.Visible = false
        elseif i:IsA("BasePart") then
            i.CastShadow = false
        end
    end,
    function(i)
        if Main.fxWorldPart(i) then
            Main.set(i, { Material = Enum.Material.SmoothPlastic, Reflectance = 0 })
        elseif Main.fxIs(i, Main.fxClasses.Decal) and not Main.fxPlayerOf(i) then
            i.Transparency = 1
        end
    end,
    function(i)
        if i:IsA("MeshPart") and Main.fxWorldPart(i) then
            i.TextureID = ""
        elseif i:IsA("SurfaceAppearance") and not Main.fxPlayerOf(i) then
            i:Destroy()
        elseif Main.fxIs(i, Main.fxClasses.Clothes) then
            local owner = Main.fxPlayerOf(i)
            if owner and owner ~= localPlayer then i:Destroy() end
        end
    end,
    function(i)
        if Main.fxWorldPart(i) then i.Transparency = 1 end
    end,
}

function Main.fxRun(inst, level)
    pcall(function()
        for i = 1, level do Main.fxEach[i](inst) end
    end)
end

function Main.fxStart(level)
    Main.fxToken += 1
    local token = Main.fxToken
    for i = 1, level do pcall(Main.fxGlobal[i]) end

    local n = 0
    for _, root in ipairs({ Workspace, Lighting }) do
        for _, inst in ipairs(root:GetDescendants()) do
            if token ~= Main.fxToken then return end
            Main.fxRun(inst, level)
            n += 1
            if n % 400 == 0 then task.wait() end
        end
    end
    Main.notify("Fix Lag", "Fix Lag applied: " .. Main.fxNames[level])
end

function Main.fxLaunch()
    task.spawn(Main.fxStart, Main.fxLevel)
end

function Main.fxSetAuto(on)
    if on == Main.fxAuto then return end
    Main.fxAuto = on
    if on then
        Main.fxLaunch()
    else
        Main.fxToken += 1
    end
    Main.listen("AutoFix", on, Workspace.DescendantAdded, function(i) Main.fxRun(i, Main.fxLevel) end)
end

function Main.fxSetLevel(opt)
    local l = table.find(Main.fxNames, opt) or 1
    if l == Main.fxLevel then return end
    Main.fxLevel = l
    if Main.fxAuto then Main.fxLaunch() end
end

Main.bpRealChar = playerCharacter or localPlayer.Character or localPlayer.CharacterAdded:Wait()
Main.bpRealHRP = Main.bpRealChar:WaitForChild("HumanoidRootPart", 5) or Main.bpRealChar:FindFirstChild("Torso")
Main.bpRealHum = Main.bpRealChar:WaitForChild("Humanoid", 5)

Main.bpFakeChar = Main.new("Model", { Name = localPlayer.Name .. "_ZEROHUB_FAKE" })
Main.bpFakeHRP = Main.new("Part", {
    Name = "HumanoidRootPart", Size = Vector3.new(2, 2, 1), CanCollide = true, Transparency = 0.8,
    CFrame = Main.bpRealChar:GetPivot(),
}, Main.bpFakeChar)
Main.bpFakeHum = Main.new("Humanoid", {}, Main.bpFakeChar)
Main.bpFakeChar.PrimaryPart = Main.bpFakeHRP

function Main.bpGetReal()
    local ch = Main.bpRealChar
    if not ch or not ch.Parent or ch == Main.bpFakeChar then
        local found = Workspace:FindFirstChild(localPlayer.Name)
        if found and found ~= Main.bpFakeChar then
            Main.bpRealChar = found
            ch = found
        end
    end
    if ch then
        if not Main.bpRealHRP or Main.bpRealHRP.Parent ~= ch then Main.bpRealHRP = Main.root(ch) end
        if not Main.bpRealHum or Main.bpRealHum.Parent ~= ch then Main.bpRealHum = ch:FindFirstChildOfClass("Humanoid") end
    end
    return Main.bpRealChar, Main.bpRealHRP, Main.bpRealHum
end

function Main.bpAnimate(hum)
    local fh = Main.bpFakeHum
    local animate = hum.Parent:FindFirstChild("Animate")
    local state = fh:GetState()
    local moving = fh.MoveDirection.Magnitude > 0
    local name = Main.bpStateAnim[state]
        or (state == Enum.HumanoidStateType.Swimming and (moving and "swim" or "swimidle"))
        or (moving and (animate and animate:FindFirstChild("run") and "run" or "walk"))
        or "idle"

    local tracks = Main.bpTracks
    if Main.bpCur ~= name then
        if tracks[Main.bpCur] then tracks[Main.bpCur]:Stop(0.2) end
        if not tracks[name] then
            local folder = animate and animate:FindFirstChild(name)
            local anim = folder and folder:FindFirstChildOfClass("Animation")
            local animator = hum:FindFirstChildOfClass("Animator")
            tracks[name] = anim and animator and animator:LoadAnimation(anim) or nil
        end
        if tracks[name] then tracks[name]:Play(0.2) end
        Main.bpCur = name
    end

    if tracks[name] then
        tracks[name]:AdjustSpeed(
            (name == "walk" or name == "run") and fh.WalkSpeed / 16
            or (name == "climb" and (Main.bpFakeHRP.AssemblyLinearVelocity.Magnitude > 0.1 and 1 or 0))
            or 1
        )
    end
end

function Main.bpEnter(hrp, hum)
    local fake, fh = Main.bpFakeChar, Main.bpFakeHum
    local animate = hum.Parent:FindFirstChild("Animate")
    if animate and animate.Enabled then
        animate.Enabled = false
        for _, t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop(0) end
    end
    if not fake.Parent then
        Main.bpFakeHRP.CFrame = hrp.CFrame
        fake.Parent = Workspace
    end
    fh.WalkSpeed = hum.WalkSpeed
    fh.JumpPower = hum.JumpPower
    Main.bpFakeHRP.CanCollide = true
    hum.PlatformStand = true
    if localPlayer.Character ~= fake then localPlayer.Character = fake end
    if Camera then Camera.CameraSubject = fh end
end

function Main.bpRestore(char, hum)
    char:PivotTo(Main.bpFakeChar:GetPivot())
    localPlayer.Character = char
    if hum then hum.PlatformStand = false end
    if Camera and hum then Camera.CameraSubject = hum end
    Main.bpFakeChar.Parent = nil
    if char:FindFirstChild("Animate") then char.Animate.Enabled = true end
    for _, t in pairs(Main.bpTracks) do t:Stop(0) end
    Main.bpCur = nil
    if char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.CanCollide = true end
end

function Main.bpToggle(on)
    local was = Main.bpOn
    Main.bpOn = on
    Main.listen("BypassStep", false)

    local char, hrp, hum = Main.bpGetReal()
    if on then
        if char and hrp and hum then Main.bpEnter(hrp, hum) end
        Main.listen("BypassStep", true, RunService.RenderStepped, Main.bpStep)
    else
        if was then Workspace.FallenPartsDestroyHeight = -500 end
        if localPlayer.Character == Main.bpFakeChar and char then Main.bpRestore(char, hum) end
        Main.bpFakeChar.Parent = nil
    end
end

function Main.bpBind(char)
    if char == Main.bpFakeChar or char.Name:find("FAKE") then return end

    Main.bpRealChar = char
    Main.bpTracks, Main.bpCur = {}, nil
    Main.bpRealHRP = char:WaitForChild("HumanoidRootPart", 10) or char:FindFirstChild("Torso")
    Main.bpRealHum = char:WaitForChild("Humanoid", 10)
    Main.bpRespawning = true

    Main.listen("BypassDied", Main.bpRealHum ~= nil, Main.bpRealHum and Main.bpRealHum.Died, function()
        Main.bpRespawning = true
    end)

    task.wait(0.2)
    Main.bpRespawning = false
    Main.bpFakeChar:PivotTo(char:GetPivot())
end

function Main.bpUnload()
    Main.listen("BypassStep", false)
    Main.listen("BypassDied", false)
    pcall(function()
        if localPlayer.Character == Main.bpFakeChar then Main.bpRestore(Main.bpRealChar, Main.bpRealHum) end
        Workspace.FallenPartsDestroyHeight = -500
    end)
    pcall(Main.bpFakeChar.Destroy, Main.bpFakeChar)
end

function Main.bpStep()
    local char, hrp, hum = Main.bpGetReal()
    local fh, fhrp = Main.bpFakeHum, Main.bpFakeHRP

    Workspace.FallenPartsDestroyHeight = 0 / 0

    if char and hrp and hum and not Main.bpRespawning then
        Main.bpEnter(hrp, hum)
        Main.bpAnimate(hum)

        fh.HipHeight = hum.HipHeight
        fh.RigType = hum.RigType
        fh.Health = math.clamp(hum.Health, 1, 100)
        fhrp.Size = hrp.Size

        hum:MoveTo(fhrp.Position + fh.MoveDirection * 50)

        if fhrp.Position.Y <= -25 then
            local v = fhrp.AssemblyLinearVelocity
            fhrp.AssemblyLinearVelocity = Vector3.new(v.X, math.abs(v.Y) * 0.9 + 20, v.Z)
            Main.bpFakeChar:PivotTo(fhrp.CFrame + Vector3.new(0, 10, 0))
        end

        char:PivotTo(Main.bpFakeChar:GetPivot())

        for _, p in ipairs(char:GetChildren()) do
            if p:IsA("BasePart") then
                local v = p.AssemblyLinearVelocity
                p.CanCollide = false
                p.AssemblyLinearVelocity = Vector3.new(math.clamp(v.X, -1, 1), 3, math.clamp(v.Z, -1, 1))
            end
        end
    end
end

task.spawn(Main.bpBind, localPlayer.Character)

function Main.dcRequest()
    return WindUI.Creator.Request or request or (syn and syn.request) or (http and http.request)
end

function Main.dcGet(url)
    local req = Main.dcRequest()
    if not req then return Main.clone(HttpService):GetAsync(url) end

    local res = req({ Url = url, Method = "GET" })
    if not res then error("Empty HTTP response") end

    local status = res.StatusCode or res.Status or 200
    if status < 200 or status >= 300 then error("HTTP Error: " .. tostring(status)) end

    return res.Body or res.body or res.text or ""
end

function Main.dcExtract(text)
    if type(text) ~= "string" then return end

    text = (text:match("^%s*(.-)%s*$") or ""):gsub("^[\"'`]+", ""):gsub("[\"'`]+$", "")

    local code = text:match("discord%.gg/([%w%-_]+)")
        or text:match("discord%.com/invite/([%w%-_]+)")
        or text:match("discordapp%.com/invite/([%w%-_]+)")

    if not code and not text:find("://", 1, true) then code = text:match("^([%w%-_]+)$") end
    return code
end

function Main.dcCdn(kind, id, hash, size)
    return ("https://cdn.discordapp.com/%s/%s/%s.png?size=%d"):format(kind, id, hash, size)
end

function Main.dcBannerUrl(g)
    if g.banner then return Main.dcCdn("banners", g.id, g.banner, 512) end

    local c = Main.dcCustomBanner
    if type(c) == "string" and c:match("%S") then return c end
    return Main.dcCdn("banners", g.id, Main.dcDefBanner, 512)
end

function Main.dcFetch()
    local code = Main.dcExtract(Main.dcGet(Main.dcUrl))
    if not code then error("No invite code found on GitHub") end

    local api = ("https://discord.com/api/v10/invites/%s?with_counts=true&with_expiration=true"):format(code)
    local data = Main.clone(HttpService):JSONDecode(Main.dcGet(api))
    if not data or not data.guild then error(data and data.message or "Invalid Discord invite") end

    return code, data
end

function Main.dcInit(tab)
    Main.dcPara = tab:Paragraph({
        Title = "Loading Discord...",
        Desc = "",
        Image = Main.dcIcon,
        ImageSize = Main.dcIconSize,
        Buttons = { {
            Title = "Copy link",
            Icon = "link",
            Callback = function()
                if Main.dcCode then setclipboard("https://discord.gg/" .. tostring(Main.dcCode)) end
            end,
        } },
    })

    task.spawn(function()
        local ok, code, data = pcall(Main.dcFetch)
        local p = Main.dcPara

        if ok and data and data.guild then
            local g = data.guild
            Main.dcCode = code

            p:SetTitle(tostring(g.name))
            p:SetDesc(tostring(g.description or ""))
            p:SetImage(g.icon and Main.dcCdn("icons", g.id, g.icon, 1024) or Main.dcIcon, Main.dcIconSize)
            p:SetThumbnail(Main.dcBannerUrl(g))
        else
            p:SetTitle("Failed to fetch Discord server info (Network slow or invalid link).")
        end
    end)
end

function Main.cfgList()
    local list = Window.ConfigManager:AllConfigs()
    table.sort(list)
    return list
end

function Main.cfgTarget(kind)
    local name = tostring(kind == "Name" and Main.cfgName or Main.cfgSel or "")
    name = name:gsub('[\\/:*?"<>|]', ""):match("^%s*(.-)%s*$")
    return name ~= "" and name or nil
end

function Main.cfgOpen(name)
    local old = Window.CurrentConfig
    local cfg, why = Window.ConfigManager:CreateConfig(name)
    if cfg and old and old ~= cfg then
        for flag, el in next, old.Elements do cfg:Register(flag, el) end
    end
    return cfg, why
end

function Main.cfgSave(name)
    local cfg, why = Main.cfgOpen(name)
    if not cfg then return false, why end
    cfg:Save()
    return true
end

function Main.cfgLoad(name)
    local cfg, why = Main.cfgOpen(name)
    if not cfg then return false, why end
    local data, reason = cfg:Load()
    return data ~= false, reason
end

function Main.cfgDelete(name)
    return Window.ConfigManager:DeleteConfig(name)
end

function Main.cfgReload(want)
    local list = Main.cfgList()
    Main.cfgSel = table.find(list, want) and want or (table.find(list, Main.cfgSel) and Main.cfgSel) or list[1]
    Main.cfgDrop:Refresh(list)
    if Main.cfgSel then Main.cfgDrop:Select(Main.cfgSel) end
end

function Main.cfgRun(label, kind, fn)
    local name = Main.cfgTarget(kind)
    if not name then return Main.notify("Config", "Enter a name or select a config first", "x") end

    local ok, why = fn(name)
    Main.notify("Config", ok and (label .. ": " .. name) or why or "Something went wrong", ok and "check" or "x")
    if ok then Main.cfgReload(name) end
end

WindUI:AddTheme({
    Name = "Dark",
    Accent = "#18181b",
    Dialog = "#18181b",
    Outline = "#FFFFFF",
    Text = "#FFFFFF",
    Placeholder = "#999999",
    Background = "#0e0e10",
    Button = "#52525b",
    Icon = "#a1a1aa",
})

WindUI:AddTheme({
    Name = "Light",
    Accent = "#f4f4f5",
    Dialog = "#f4f4f5",
    Outline = "#000000",
    Text = "#000000",
    Placeholder = "#666666",
    Background = "#ffffff",
    Button = "#e4e4e7",
    Icon = "#52525b",
})

WindUI:AddTheme({
    Name = "Gray",
    Accent = "#374151",
    Dialog = "#374151",
    Outline = "#d1d5db",
    Text = "#f9fafb",
    Placeholder = "#9ca3af",
    Background = "#1f2937",
    Button = "#4b5563",
    Icon = "#d1d5db",
})

WindUI:AddTheme({
    Name = "Blue",
    Accent = "#1e40af",
    Dialog = "#1e3a8a",
    Outline = "#93c5fd",
    Text = "#f0f9ff",
    Placeholder = "#60a5fa",
    Background = "#1e293b",
    Button = "#3b82f6",
    Icon = "#93c5fd",
})

WindUI:AddTheme({
    Name = "Green",
    Accent = "#059669",
    Dialog = "#047857",
    Outline = "#6ee7b7",
    Text = "#ecfdf5",
    Placeholder = "#34d399",
    Background = "#064e3b",
    Button = "#10b981",
    Icon = "#6ee7b7",
})

WindUI:AddTheme({
    Name = "Purple",
    Accent = "#7c3aed",
    Dialog = "#6d28d9",
    Outline = "#c4b5fd",
    Text = "#faf5ff",
    Placeholder = "#a78bfa",
    Background = "#581c87",
    Button = "#8b5cf6",
    Icon = "#c4b5fd",
})

WindUI:SetNotificationLower(true)

WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "en",
    SourceLanguage = "en",
    AutoTranslate = true,
    Notifications = true,
    NoTranslations = { "NaN Hub", "72ms", "Main UI" },

    Translations = {
        en = {
            HubTitle = "NaN Hub",
            GameTitle = "Univereal Script - By 72ms",
            ThemeChanged = "Theme Changed",
            TransparencyTitle = "Transparency",
            TransparencyDisabled = "Transparency disabled",
            TransparencyEnabled = "Transparency enabled",
            About = "About",
            Features = "Features",
            GamePlay = "Gameplay",
            System = "System",
            Update = "Update",
            Information = "Information",
            Main = "Main",
            Server = "Server",
            Status = "Status",
            Player = "Player",
            Visual = "Visual",
            Teleport = "Teleport",
            Troll = "Troll",
            Misc = "Misc",
            Settings = "Settings",
            UpdateDesc = "- Fix auto fling \n- Fix teleport tool \n- New auto wall hop",
            InformationDesc = "About the hub",
            MainDesc = "Main features",
            StaminaDesc = "Stamina options",
            SurvivorsDesc = "Survivor tools",
            KillersDesc = "Killer tools",
            ServerDesc = "Server tools",
            StatusDesc = "Stats",
            PlayerDesc = "Player options",
            VisualDesc = "Visual options",
            TeleportDesc = "Teleport options",
            TrollDesc = "Fun stuff",
            MiscDesc = "Miscellaneous",
            SettingsDesc = "Configuration",
            Language = "Language",
            LanguageDesc = "Choose your preferred language.",
        },
    },
})

local themes = { "Dark", "Light", "Gray", "Blue", "Green", "Purple" }
local currentThemeIndex = 1

if not getgenv().TransparencyEnabled then
    getgenv().TransparencyEnabled = true
end

local Window = WindUI:CreateWindow({
    Title = "loc:HubTitle",
    Icon = "rbxassetid://105519970633948",
    Background = "rbxassetid://0",
    Author = "loc:GameTitle",
    Folder = "NaN Hub - Univereal Script",
    Size = UDim2.fromOffset(620, 480),
    MinSize = Vector2.new(620, 480),
    Transparent = getgenv().TransparencyEnabled,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 150,
    BackgroundImageTransparency = 0.8,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            currentThemeIndex = currentThemeIndex + 1
            if currentThemeIndex > #themes then
                currentThemeIndex = 1
            end

            local newTheme = themes[currentThemeIndex]
            WindUI:SetTheme(newTheme)

            WindUI:Notify({
                Title = "loc:ThemeChanged",
                Content = newTheme,
                Duration = 2,
                Icon = "palette"
            })
        end,
    },
})

Window:SetToggleKey(Enum.KeyCode.V)

pcall(function()
    Window:CreateTopbarButton("TransparencyToggle", "eye", function()
        if getgenv().TransparencyEnabled then
            getgenv().TransparencyEnabled = false
            pcall(function() Window:ToggleTransparency(false) end)

            WindUI:Notify({
                Title = "loc:TransparencyTitle",
                Content = "loc:TransparencyDisabled",
                Duration = 3,
                Icon = "eye"
            })
        else
            getgenv().TransparencyEnabled = true
            pcall(function() Window:ToggleTransparency(true) end)

            WindUI:Notify({
                Title = "loc:TransparencyTitle",
                Content = "loc:TransparencyEnabled",
                Duration = 3,
                Icon = "eye-off"
            })
        end
    end, 990)
end)

local OpenButtonConfig = {
    Title = "Main UI",
    Icon = "rbxassetid://105519970633948",
    CornerRadius = UDim.new(0, 12),
    StrokeThickness = 2,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 10)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 235, 235)),
    }),
    Draggable = true,
    Scale = 0.9,
    OnlyIcon = false,
}

Window:EditOpenButton(OpenButtonConfig)

Window:Tag({
    Title = "v0.2.1",
    Icon = "cog",
    Color = WindUI:Gradient({
        ["0"] = {
            Color = "#8B5CF6",
            Transparency = 0
        },
        ["50"] = {
            Color = "#6366F1",
            Transparency = 0
        },
        ["100"] = {
            Color = "#06B6D4",
            Transparency = 0
        },
    }, {
        Rotation = 45
    }),
})

local Tabs = {
    About    = Window:Section({ Title = "loc:About", Opened = true }),
    Features = Window:Section({ Title = "loc:Features", Opened = true }),
    System   = Window:Section({ Title = "loc:System", Opened = true }),
}

local TabHandles = {
    Update = Tabs.About:Tab({
        Title = "loc:Update", Icon = "history", Desc = "loc:UpdateDesc", IconThemed = true,
        Locked = false, ShowTabTitle = true, Border = true, LayoutOrder = 1
    }),

    Info = Tabs.About:Tab({
        Title = "loc:Information", Icon = "badge-info", Desc = "loc:InformationDesc", IconThemed = true,
        Locked = false, ShowTabTitle = true, Border = true, LayoutOrder = 1
    }),

    Main = Tabs.Features:Tab({
        Title = "loc:Main", Icon = "house", Desc = "loc:MainDesc", IconThemed = true,
        Locked = false, ShowTabTitle = true, Border = true, LayoutOrder = 1
    }),

    Server = Tabs.Features:Tab({
        Title = "loc:Server", Icon = "server", Desc = "loc:ServerDesc", IconThemed = true,
        Locked = false, ShowTabTitle = true, Border = true, LayoutOrder = 1
    }),

    Player = Tabs.Features:Tab({
        Title = "loc:Player", Icon = "user", Desc = "loc:PlayerDesc", IconThemed = true,
        Locked = false, ShowTabTitle = true, Border = true, LayoutOrder = 1
    }),

    Visual = Tabs.Features:Tab({
        Title = "loc:Visual", Icon = "eye", Desc = "loc:VisualDesc", IconThemed = true,
        Locked = false, ShowTabTitle = true, Border = true, LayoutOrder = 1
    }),

    Teleport = Tabs.Features:Tab({
        Title = "loc:Teleport", Icon = "map", Desc = "loc:TeleportDesc", IconThemed = true,
        Locked = false, ShowTabTitle = true, Border = true, LayoutOrder = 1
    }),

    Misc = Tabs.System:Tab({
        Title = "loc:Misc", Icon = "menu", Desc = "loc:MiscDesc", IconThemed = true,
        Locked = false, ShowTabTitle = true, Border = true, LayoutOrder = 1
    }),

    Settings = Tabs.System:Tab({
        Title = "loc:Settings", Icon = "settings", Desc = "loc:SettingsDesc", IconThemed = true,
        Locked = false, ShowTabTitle = true, Border = true, LayoutOrder = 1
    }),
}

local Sections = {
    AdminPanel = TabHandles.Main:Section({
        Title = "Admin Panel", Desc = "Show Admin Panel Plus.", Icon = "code", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Fling = TabHandles.Main:Section({
        Title = "Fling", Desc = "Launch targets using physics.", Icon = "zap", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Camlock = TabHandles.Main:Section({
        Title = "Camlock", Desc = "Configure target detection and camera locking settings.", Icon = "crosshair", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    GodMode = TabHandles.Main:Section({
        Title = "God Mode", Desc = "Configure god mode settings and protection options.", Icon = "infinity", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    GetTool = TabHandles.Main:Section({
        Title = "Get Tool", Desc = "Claim special tools provided by the script.", Icon = "wrench", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    WallHop = TabHandles.Main:Section({
        Title = "Wall Hop", Desc = "Configure wall hop settings and movement options.", Icon = "brick-wall", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Server = TabHandles.Server:Section({
        Title = "Server", Desc = "Explore server options and manage your connection.", Icon = "server", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold, TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Character = TabHandles.Player:Section({
        Title = "Character", Desc = "Enhance your character with unrestricted movement abilities.", Icon = "user-round", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    WalkSpeed = TabHandles.Player:Section({
        Title = "Walk Speed", Desc = "Move faster with enhanced walking speed.", Icon = "footprints", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    JumpPower = TabHandles.Player:Section({
        Title = "Jump Power", Desc = "Reach greater heights with enhanced jumping power.", Icon = "arrow-up-from-line", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Swim = TabHandles.Player:Section({
        Title = "Swim", Desc = "Swim freely through the water.", Icon = "waves", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Fly = TabHandles.Player:Section({
        Title = "Fly", Desc = "Take flight and explore the world freely.", Icon = "wind", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Gravity = TabHandles.Player:Section({
        Title = "Gravity", Desc = "Adjust gravity settings and control fall speed.", Icon = "replace", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Tracer = TabHandles.Visual:Section({
        Title = "Tracer Settingsr", Desc = "Customize tracer lines and their visual behavior.", Icon = "crosshair", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    EspPlayer = TabHandles.Visual:Section({
        Title = "Esp Player", Desc = "Track players and reveal their presence across the map.", Icon = "users", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    EspModel = TabHandles.Visual:Section({
        Title = "Esp Model", Desc = "Detect and highlight objects throughout the environment.", Icon = "box", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    EspNPC = TabHandles.Visual:Section({
        Title = "Esp NPC", Desc = "Locate and highlight NPCs around the world.", Icon = "bot", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Camera = TabHandles.Misc:Section({
        Title = "Camera", Desc = "Customize your camera settings.", Icon = "camera", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Bypass = TabHandles.Misc:Section({
        Title = "Bypass", Desc = "Manage bypass options.", Icon = "shield-check", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    FixLag = TabHandles.Misc:Section({
        Title = "Fix Lag", Desc = "Improve performance and reduce lag.", Icon = "cog", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Teleport = TabHandles.Teleport:Section({
        Title = "Teleport", Desc = "Manage teleport options and location settings.", Icon = "map-pinned", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Language = TabHandles.Settings:Section({
        Title = "loc:Language", Desc = "Switch between different languages.", Icon = "settings", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
    Config = TabHandles.Settings:Section({
        Title = "Config", Desc = "Manage your configurations.", Icon = "folder-cog", Box = true, BoxBorder = true,
        FontWeight = Enum.FontWeight.SemiBold,TextTransparency = 0.05, TextXAlignment = "Left", TextSize = 17, Opened = false
    }),
}

Window:SelectTab(1)

TabHandles.Update:Paragraph({
    Title = "loc:Update",
    Desc = "loc:UpdateDesc",
})
Main.dcInit(TabHandles.Info)

Sections.AdminPanel:Toggle({
    Title = "Admin Panel FX",
    Desc = "Small, thin admin panels floating in front of you.",
    Icon = "terminal",
    Flag = "AdminPanelFX",
    Value = false,
    Callback = Main.adToggle,
})

Sections.AdminPanel:Slider({
    Title = "Admin Panel Count",
    Desc = "How many panels to show.",
    Flag = "AdminPanelCount",
    Step = 1,
    Value = { Min = 1, Max = 8, Default = Main.adCount },
    Callback = function(v)
        Main.adCount = math.floor(v)
        Main.adRebuild()
    end,
})

Sections.AdminPanel:Colorpicker({
    Title = "Admin Panel Color",
    Desc = "Change the panel glass color.",
    Flag = "AdminPanelColor",
    Default = Main.adColor,
    Transparency = 0,
    Locked = false,
    Callback = function(c)
        Main.adColor = c
        Main.adRebuild()
    end,
})

Sections.Fling:Toggle({
    Title = "Fling Plus",
    Desc = "Unleash an invisible, powerful fling aura.",
    Flag = "FlingPlus",
    Icon = "zap",
    Value = false,
    Callback = function(on)
        Main.flOn = on
        if not on and not Main.flAuto then Main.flEnd(true) end
        Main.flSync()
    end,
})

Sections.Fling:Slider({
    Title = "Fling Power",
    Desc = "Adjust the strength of the fling effect.",
    Flag = "FlingPower",
    Step = 1,
    Value = { Min = 1, Max = 1000000000, Default = 10000 },
    Callback = function(v) Main.flForce = v end,
})

Main.flDrop = Sections.Fling:Dropdown({
    Title = "Select Target",
    Desc = "Choose a target from the player list.",
    Flag = "SelectTarget",
    Values = Main.names(),
    Multi = false,
    AllowNone = true,
    Callback = function(o) Main.flName = type(o) == "table" and o[1] or o end,
})

Sections.Fling:Button({
    Title = "Fling Target",
    Desc = "Start flinging the selected target.",
    Locked = false,
    Callback = function() Main.flFollow(Main.flTime) end,
})

Sections.Fling:Slider({
    Title = "Hold Duration",
    Desc = "Set how long to maintain the target follow.",
    Flag = "HoldDuration",
    Step = 0.1,
    Value = { Min = 1, Max = 10, Default = 1.5 },
    Callback = function(v) Main.flTime = v end,
})

Sections.Fling:Toggle({
    Title = "Auto Fling Target",
    Desc = "Automatically follow and fling targets.",
    Flag = "AutoFlingTarget",
    Icon = "crosshair",
    Value = false,
    Callback = function(on)
        Main.flAuto = on
        Main.flWatch(on)
        if not on then Main.flEnd(true) end
    end,
})

Sections.Camlock:Button({
    Title = "Switch Target",
    Desc = "Switch to the next available target.",
    Callback = function()
        if Main.camOn then Main.camTarget = Main.camNext() end
    end,
})

Sections.Camlock:Toggle({
    Title = "Camlock",
    Desc = "Automatically detect and lock onto suitable targets.",
    Flag = "Camlock",
    Value = false,
    Callback = Main.camToggle,
})

Sections.Camlock:Toggle({
    Title = "FOV Check",
    Desc = "Only lock onto targets within the FOV circle.",
    Flag = "CamlockFov",
    Value = false,
    Callback = function(on)
        Main.camFov = on
        Main.camUpdateFov()
    end,
})

Sections.Camlock:Slider({
    Title = "FOV Radius",
    Desc = "Adjust the FOV circle size in pixels.",
    Flag = "CamlockFovSize",
    Step = 5,
    Value = { Min = 30, Max = 500, Default = 150 },
    Callback = function(v)
        Main.camRadius = tonumber(v) or 150
        Main.camUpdateFov()
    end,
})

Sections.Camlock:Toggle({
    Title = "Quick Toggle Button",
    Desc = "Show a quick toggle button on screen.",
    Flag = "CamlockQuickBtn",
    Value = false,
    Callback = function(on)
        Main.camQuick = on
        Main.camShow(Main.camFrame, on)
    end,
})

Sections.Camlock:Toggle({
    Title = "Switch Target Button",
    Desc = "Show an on-screen button to switch targets.",
    Flag = "CamlockSwitchBtn",
    Value = false,
    Callback = function(on)
        Main.camSwitch = on
        Main.camShow(Main.camSFrame, on)
    end,
})

Sections.Camlock:Input({
    Title = "Button Scale",
    Desc = "Set the size of the on-screen buttons.",
    Flag = "CamUIScale",
    Placeholder = "1",
    Value = "1",
    Callback = function(v)
        Main.camScale = tonumber(v) or 1
        Main.camResize()
    end,
})

Sections.Camlock:Input({
    Title = "Lock Smoothness",
    Desc = "Adjust how smoothly the camera tracks its target.",
    Flag = "CamSmooth",
    Placeholder = "1",
    Value = "1",
    Callback = function(v) Main.camSmooth = math.clamp(tonumber(v) or 1, 0.1, 1) end,
})

Sections.Camlock:Input({
    Title = "Camera Height",
    Desc = "Set the camera's vertical offset.",
    Flag = "CamHeight",
    Placeholder = "e.g. 1.5",
    Value = "1.5",
    Callback = function(v) Main.camHeight = tonumber(v) or 1.5 end,
})

Sections.Camlock:Dropdown({
    Title = "Aim Part",
    Desc = "Choose which body part to target.",
    Flag = "KillerAimPart",
    Values = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" },
    Value = "Head",
    Callback = function(v) Main.camPart = v end,
})

Sections.GodMode:Dropdown({
    Title = "God Mode Type",
    Desc = "Choose your preferred god mode method.",
    Flag = "GodModeType",
    Values = { "Undead", "Inf Health" },
    Value = { "Undead" },
    Multi = true,
    AllowNone = false,
    Callback = function(o)
        table.clear(Main.godSel)
        for _, n in ipairs(type(o) == "table" and o or { o }) do Main.godSel[n] = true end
        if Main.godOn then Main.godSet(true) end
    end,
})

Sections.GodMode:Toggle({
    Title = "God Mode",
    Desc = "Enable or disable god mode.",
    Flag = "GodMode",
    Icon = "shield",
    Value = false,
    Callback = Main.godSet,
})

Sections.GetTool:Toggle({
    Title = "Auto Get Tool",
    Desc = "Automatically get back the tools you picked up after you die.",
    Icon = "refresh-cw",
    Flag = "AutoGetTool",
    Value = false,
    Callback = function(on) Main.toolAuto = on end,
})

Sections.GetTool:Button({
    Title = "Get Teleport Tool",
    Desc = "Get a tool for quick teleportation.",
    Icon = "map-pin",
    Callback = function() Main.toolTeleport:Give() end,
})

Sections.GetTool:Button({
    Title = "Get Animation Tool",
    Desc = "Get a tool to play animations.",
    Icon = "sparkles",
    Callback = function() Main.toolAnim:Give() end,
})

Sections.WallHop:Input({
    Title = "Wall Hop Distance",
    Desc = "Set how close you must be to a wall to wall hop.",
    Flag = "WallHopDistance",
    Value = "0.5",
    Placeholder = "Enter distance...",
    Callback = function(v) Main.hopMargin = math.max(tonumber(v) or Main.hopMargin, 0) end,
})

Sections.WallHop:Toggle({
    Title = "Auto Wall Hop",
    Desc = "Enable or disable auto wall hop.",
    Flag = "AutoWallHop",
    Icon = "arrow-up",
    Value = false,
    Callback = function(on)
        Main.hopOn = on
        Main.listen("WallHop", on, RunService.Heartbeat, Main.hopStep)
    end,
})

Main.srvStatus = Sections.Server:Paragraph({
    Title = "Server Status",
    Desc = Main.srvText(),
})

Sections.Server:Input({
    Title = "Server ID",
    Desc = "Enter the server ID (JobId) you want to join.",
    Flag = "ServerId",
    Value = "",
    InputIcon = "hash",
    Type = "Input",
    Placeholder = "Nhập ID server...",
    Callback = function(v) Main.srvId = (v:gsub("%s", "")) end,
})

Sections.Server:Button({
    Title = "Copy Server ID",
    Desc = "Copy the current server ID to your clipboard.",
    Locked = false,
    Callback = function() setclipboard(game.JobId) end,
})

Sections.Server:Button({
    Title = "Join Server",
    Desc = "Join the server with the entered ID.",
    Locked = false,
    Callback = function() Main.srvJoin(Main.srvId) end,
})

Sections.Server:Button({
    Title = "Server Hop",
    Desc = "Jump to another public server.",
    Locked = false,
    Callback = Main.srvHop,
})

Sections.Server:Button({
    Title = "Rejoin",
    Desc = "Rejoin the current server.",
    Locked = false,
    Callback = Main.srvRejoin,
})

Sections.Server:Input({
    Title = "Auto Wait Time",
    Desc = "Minutes to wait before auto hop / auto rejoin.",
    Flag = "AutoWaitMinutes",
    Value = tostring(Main.srvMinutes),
    InputIcon = "timer",
    Type = "Input",
    Placeholder = "Nhập số phút...",
    Callback = function(v) Main.srvMinutes = Main.num(v) or Main.srvMinutes end,
})

Sections.Server:Toggle({
    Title = "Auto Hop",
    Desc = "Automatically server hop after the wait time.",
    Flag = "AutoHop",
    Icon = "shuffle",
    Value = false,
    Callback = function(on) Main.srvAuto("Hop", on) end,
})

Sections.Server:Toggle({
    Title = "Auto Rejoin",
    Desc = "Automatically rejoin after the wait time.",
    Flag = "AutoRejoin",
    Icon = "refresh-cw",
    Value = false,
    Callback = function(on) Main.srvAuto("Rejoin", on) end,
})

Sections.Character:Toggle({
    Title = "Noclip",
    Desc = "Walk through walls and objects.",
    Flag = "Noclip",
    Icon = "ghost",
    Value = false,
    Callback = function(on) Main.mvNoclip = on end,
})

Sections.Character:Toggle({
    Title = "Inf Jump",
    Desc = "Jump again and again in mid-air.",
    Flag = "InfJump",
    Icon = "chevrons-up",
    Value = false,
    Callback = function(on) Main.mvInfJump = on end,
})

for _, r in ipairs({
    { sec = Sections.WalkSpeed, rec = Main.mvProps.Walk, flag = "WalkSpeed", ph = "Nhập tốc độ...",
      inTitle = "Walk Speed Value", inDesc = "Set your walking speed.", inFlag = "WalkSpeedValue",
      title = "Walk Speed", desc = "Enable custom walking speed.", icon = "footprints" },
    { sec = Sections.JumpPower, rec = Main.mvProps.Jump, flag = "JumpPower", ph = "Nhập lực nhảy...",
      inTitle = "Jump Power Value", inDesc = "Set your jump power.", inFlag = "JumpPowerValue",
      title = "Jump Power", desc = "Enable custom jump power.", icon = "arrow-up" },
    { sec = Sections.Swim, rec = Main.mvGlide.Swim, flag = "Swim", ph = "Nhập tốc độ...", glide = true,
      inTitle = "Swim Speed", inDesc = "Adjust your swimming movement speed.", inFlag = "SwimSpeed",
      title = "Swim", desc = "Swim freely anywhere, even outside water.", icon = "waves" },
    { sec = Sections.Fly, rec = Main.mvGlide.Fly, flag = "Fly", ph = "Nhập tốc độ bay...", glide = true,
      inTitle = "Fly Speed", inDesc = "Adjust your flying speed.", inFlag = "FlySpeed",
      title = "Fly", desc = "Fly toward where your camera looks.", icon = "plane" },
}) do
    r.sec:Input({
        Title = r.inTitle,
        Desc = r.inDesc,
        Flag = r.inFlag,
        Value = tostring(r.rec.Value),
        InputIcon = "gauge",
        Type = "Input",
        Placeholder = r.ph,
        Callback = function(v) r.rec.Value = Main.num(v) or r.rec.Value end,
    })

    r.sec:Toggle({
        Title = r.title,
        Desc = r.desc,
        Flag = r.flag,
        Icon = r.icon,
        Value = false,
        Callback = function(on)
            r.rec.Wanted = on
            if r.glide then Main.glideSync() end
        end,
    })
end

Main.gravLabel = Sections.Gravity:Paragraph({
    Title = "Gravity Status",
    Desc = "Loading...",
})
Main.gravStatus()

Sections.Gravity:Input({
    Title = "Custom Gravity",
    Desc = "Set your own gravity value.",
    Flag = "GravityValue",
    Value = "",
    InputIcon = "arrow-down-to-line",
    Type = "Input",
    Placeholder = "Enter gravity...",
    Callback = function(v)
        local n = tonumber(v)
        if n then Main.gravSet(n) end
    end,
})

Sections.Gravity:Button({
    Title = "Restore Gravity",
    Desc = "Return gravity to the game's original value.",
    Icon = "rotate-ccw",
    Callback = Main.gravRestore,
})

Sections.Tracer:Dropdown({
    Title = "Tracer Mode",
    Desc = "Customize where your tracer lines originate.",
    Flag = "Tracer_Mode",
    Values = { "Bottom", "Center", "Top", "Mouse" },
    Value = "Bottom",
    Multi = false,
    AllowNone = false,
    Callback = function(o) ESP.TracerOrigin = type(o) == "table" and o[1] or o end,
})

for _, e in ipairs({
    { name = "Player", sec = Sections.EspPlayer, icon = "users",
      type = "Choose how players are highlighted across the world.",
      text = "Customize the information displayed above players.",
      color = "Personalize the visual appearance of player ESP.",
      toggle = "Reveal players throughout the entire server." },
    { name = "Model", sec = Sections.EspModel, icon = "box",
      type = "Choose your preferred visualization for world models.",
      text = "Select which model information appears on screen.",
      color = "Customize the highlight color of detected models.",
      toggle = "Reveal non-living models throughout the environment." },
    { name = "NPC", sec = Sections.EspNPC, icon = "eye",
      type = "Choose how NPCs are visually highlighted.",
      text = "Customize the information displayed for NPCs.",
      color = "Personalize the visual appearance of NPC ESP.",
      toggle = "Reveal NPCs and track their presence in the environment." },
}) do
    local obj = Main["esp" .. e.name]
    local flag = e.name .. "_ESP"

    e.sec:Dropdown({
        Title = e.name .. " ESP Type",
        Desc = e.type,
        Flag = flag .. "_Type",
        Values = { "Highlight", "Text", "Box", "Tracer" },
        Value = { "Highlight" },
        Multi = true,
        AllowNone = true,
        Callback = function(o)
            obj.Forms = o
            obj:Refresh()
        end,
    })

    e.sec:Dropdown({
        Title = e.name .. " ESP Text",
        Desc = e.text,
        Flag = flag .. "_Text",
        Values = { "Name", "HP", "Distance" },
        Value = { "Name", "Distance" },
        Multi = true,
        AllowNone = true,
        Callback = function(o)
            obj.TextOptions = o
            obj:Refresh()
        end,
    })

    e.sec:Colorpicker({
        Title = e.name .. " ESP Color",
        Desc = e.color,
        Flag = flag .. "_Color",
        Default = obj.Color,
        Transparency = 0,
        Locked = false,
        Callback = function(c)
            obj.Color = c
            obj:Refresh()
        end,
    })

    e.sec:Toggle({
        Title = e.name .. " ESP",
        Desc = e.toggle,
        Flag = flag,
        Icon = e.icon,
        Value = false,
        Callback = function(on)
            obj.Wanted = on
            obj:Sync()
        end,
    })
end

Main.tpDrop = Sections.Teleport:Dropdown({
    Title = "Select Player",
    Desc = "Choose a player to teleport to.",
    Values = Main.names(),
    AllowNone = true,
    Callback = function(o) Main.tpPlayer = o end,
})

Sections.Teleport:Button({
    Title = "Teleport to Player",
    Desc = "Teleport to the selected player.",
    Icon = "user-round",
    Callback = Main.tpToPlayer,
})

Main.tpPointDrop = Sections.Teleport:Dropdown({
    Title = "Saved Points",
    Desc = "Choose one of your saved points.",
    Values = {},
    AllowNone = true,
    Callback = function(o) Main.tpPoint = o end,
})

Main.freeToggle = Sections.Teleport:Toggle({
    Title = "Set Point Mode",
    Desc = "Free cam: aim the center of the screen to choose a point.",
    Icon = "crosshair",
    Value = false,
    Callback = function(on)
        if on then Main.freeStart() else Main.freeStop() end
    end,
})

Sections.Teleport:Button({
    Title = "Set Point",
    Desc = "Save the aimed point in free cam, or your current position if free cam is off.",
    Icon = "map-pin",
    Callback = Main.tpPick,
})

Sections.Teleport:Button({
    Title = "Teleport to Point",
    Desc = "Teleport to the point selected in Saved Points.",
    Icon = "navigation",
    Callback = Main.tpToPoint,
})

Sections.Camera:Toggle({
    Title = "Full Bright",
    Desc = "Illuminate the entire environment for better visibility.",
    Icon = "sun",
    Flag = "FullBright",
    Value = false,
    Callback = function(on) Main.fxOverride("FullBright", on, Main.fxTargets.FullBright) end,
})

Sections.Camera:Toggle({
    Title = "No Fog",
    Desc = "Remove environmental fog for clearer visibility.",
    Icon = "cloud-fog",
    Flag = "NoFog",
    Value = false,
    Callback = function(on) Main.fxOverride("NoFog", on, Main.fxTargets.NoFog) end,
})

Sections.Bypass:Toggle({
    Title = "Anti AFK",
    Desc = "Prevent automatic idle disconnection.",
    Icon = "mouse-pointer-click",
    Flag = "AntiAFK",
    Value = true,
    Callback = Main.fxAntiAFK,
})
Main.fxAntiAFK(true)

Sections.Bypass:Toggle({
    Title = "Anti Fling",
    Desc = "Protect your character from unwanted flinging.",
    Icon = "shield-check",
    Flag = "AntiFling",
    Value = false,
    Callback = Main.fxAntiFling,
})

Sections.Bypass:Toggle({
    Title = "Anti Void",
    Desc = "Prevent falling into the void.",
    Icon = "atom",
    Flag = "AntiVoid",
    Value = false,
    Callback = function(on) Main.fxOverride("AntiVoid", on, Main.fxTargets.AntiVoid) end,
})

Sections.Bypass:Toggle({
    Title = "Anti Fall Damage",
    Desc = "Dual-character controller bypassing fall damage",
    Flag = "AntiFallDamage",
    Icon = "shield",
    Value = false,
    Callback = Main.bpToggle,
})

Sections.FixLag:Dropdown({
    Title = "Fix Lag Mode",
    Desc = "Select optimization mode.",
    Values = Main.fxNames,
    Value = Main.fxNames[1],
    Multi = false,
    AllowNone = false,
    Flag = "FixLagMode",
    Callback = Main.fxSetLevel,
})

Sections.FixLag:Button({
    Title = "Apply Fix Lag",
    Desc = "Apply performance optimizations.",
    Locked = false,
    Callback = function()
        Main.notify("Fix Lag", "Working on it...")
        Main.fxLaunch()
    end,
})

Sections.FixLag:Toggle({
    Title = "Auto Fix Lag",
    Desc = "Automatically apply optimizations.",
    Icon = "zap",
    Flag = "AutoFixLag",
    Value = false,
    Callback = Main.fxSetAuto,
})

LangController:AddDropdown(Sections.Language, {
    Title = "loc:Language",
    Desc = "loc:LanguageDesc",
    Flag = "Language",
})

Sections.Config:Input({
    Title = "Config Name",
    Desc = "Set a name for your configuration.",
    Flag = "ConfigName",
    Placeholder = "Enter config name...",
    Callback = function(v) Main.cfgName = v end,
})

Main.cfgDrop = Sections.Config:Dropdown({
    Title = "Config List",
    Desc = "View and manage saved configurations.",
    Flag = "ConfigList",
    Values = Main.cfgList(),
    Callback = function(v) Main.cfgSel = v end,
})

Sections.Config:Button({
    Title = "Create Config",
    Desc = "Saves your current settings as a new config using the name you typed above.",
    Icon = "file-plus",
    Callback = function() Main.cfgRun("Created", "Name", Main.cfgSave) end,
})

Sections.Config:Button({
    Title = "Load Config",
    Desc = "Applies the settings saved in the selected config.",
    Icon = "folder-open",
    Callback = function() Main.cfgRun("Loaded", "Selected", Main.cfgLoad) end,
})

Sections.Config:Button({
    Title = "Overwrite Config",
    Desc = "Replaces the selected config with your current settings.",
    Icon = "save",
    Callback = function()
        local name = Main.cfgTarget("Selected")
        if not name then return Main.notify("Config", "Select a config first", "x") end

        Window:Dialog({
            Title = "Overwrite Config",
            Content = 'Replace "' .. name .. '" with your current settings?',
            Icon = "save",
            Buttons = {
                { Title = "Cancel", Variant = "Secondary", Callback = function() end },
                { Title = "Overwrite", Variant = "Primary", Callback = function()
                    Main.cfgRun("Overwritten", "Selected", Main.cfgSave)
                end },
            },
        })
    end,
})

Sections.Config:Button({
    Title = "Delete Config",
    Desc = "Permanently deletes the selected config. This can't be undone.",
    Icon = "trash-2",
    Callback = function()
        local name = Main.cfgTarget("Selected")
        if not name then return Main.notify("Config", "Select a config first", "x") end

        Window:Dialog({
            Title = "Delete Config",
            Content = 'Delete "' .. name .. '"? This can\'t be undone.',
            Icon = "trash-2",
            Buttons = {
                { Title = "Cancel", Variant = "Secondary", Callback = function() end },
                { Title = "Delete", Variant = "Primary", Callback = function()
                    Main.cfgRun("Deleted", "Selected", Main.cfgDelete)
                end },
            },
        })
    end,
})

Main.cfgReload()

WindUI:Notify({
    Title = "NaN Hub",
    Content = "Script loaded successfully!",
    Duration = 4,
    Icon = "rocket",
})

WindUI:Notify({
    Title = "NaN Hub",
    Content = "Join our Discord for updates, new features and support!",
    Duration = 4,
    Icon = "NaN:Discord",
})
