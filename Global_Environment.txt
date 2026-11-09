-- [[ Welcome to Flames Hub's global environment initialization system. ]] --
-- [[ It is literally like one of the safest things I think I have ever created, everything is concrete and has been properly and thoroughly reviewed. ]] --
-- [[ This works for all executors, including low level executors such as: Solara, Xeno, JJSploit, etc. ]] --
if not game:IsLoaded() then game.Loaded:Wait() end
if getgenv().GlobalEnvironmentFramework_Initialized then return end
getgenv().GlobalEnvironmentFramework_Initialized = true
local g = getgenv()
local game_ref = game
local function easy_wrapper(s)
    local service_map = {
        ["runservice"]           = "RunService",
        ["players"]              = "Players",
        ["userinputservice"]     = "UserInputService",
        ["tweenservice"]         = "TweenService",
        ["httpservice"]          = "HttpService",
        ["marketplaceservice"]   = "MarketplaceService",
        ["coregui"]              = "CoreGui",
        ["starterplayer"]        = "StarterPlayer",
        ["startergui"]           = "StarterGui",
        ["starterpack"]          = "StarterPack",
        ["workspace"]            = "Workspace",
        ["replicatedstorage"]    = "ReplicatedStorage",
        ["chat"]                 = "Chat",
        ["teams"]                = "Teams",
        ["soundservice"]         = "SoundService",
        ["pathfindingservice"]   = "PathfindingService",
        ["physicsservice"]       = "PhysicsService",
        ["textservice"]          = "TextService",
        ["textchatservice"]      = "TextChatService",
        ["virtualuser"]          = "VirtualUser",
        ["guiservice"]           = "GuiService",
        ["contextactionservice"] = "ContextActionService",
        ["contentprovider"]      = "ContentProvider",
        ["badgeservice"]         = "BadgeService",
        ["datastoreservice"]     = "DataStoreService",
        ["groupservice"]         = "GroupService",
        ["insertservice"]        = "InsertService",
        ["localizationservice"]  = "LocalizationService",
        ["logservice"]           = "LogService",
        ["memorystoreservice"]   = "MemoryStoreService",
        ["messagingservice"]     = "MessagingService",
        ["notificationservice"]  = "NotificationService",
        ["policyservice"]        = "PolicyService",
        ["socialservice"]        = "SocialService",
        ["stats"]                = "Stats",
        ["teleportservice"]      = "TeleportService",
        ["vrservice"]            = "VRService",
        ["scriptcontext"]        = "ScriptContext",
        ["rendersettings"]       = "RenderSettings",
        ["selection"]            = "Selection",
        ["testservice"]          = "TestService",
        ["lighting"]             = "Lighting",
        ["collectionservice"]    = "CollectionService",
        ["debris"]               = "Debris",
        ["geometryservice"]      = "GeometryService",
        ["replicatedfirst"]      = "ReplicatedFirst",
        ["assetservice"]         = "AssetService",
        ["hapticservice"]        = "HapticService",
        ["userservice"]          = "UserService",
        ["proximatepromptservice"] = "ProximityPromptService",
        ["avatareditservice"]    = "AvatarEditorService",
        ["analyticsservice"]     = "AnalyticsService",
    }

    local instance
    local service_name

    if typeof(s) == "Instance" then
        instance = s
    elseif type(s) == "string" then
        local normalized = s:lower():gsub("%s+", "")
        service_name = service_map[normalized]
        if not service_name then
            warn("[easy_wrapper]: unknown service -> " .. tostring(s))
            return nil
        end
        if getgenv()[service_name] then return getgenv()[service_name] end
        local ok, result = pcall(function() return game:GetService(service_name) end)
        if not ok or not result then
            warn("[easy_wrapper]: GetService failed -> " .. tostring(service_name))
            return nil
        end
        instance = result
    else
        warn("[easy_wrapper]: invalid argument type -> " .. tostring(typeof(s)))
        return nil
    end

    if cloneref and typeof(cloneref) == "function" then
        local ok, cloned = pcall(cloneref, instance)
        if ok and cloned then instance = cloned end
    end

    if service_name and not getgenv()[service_name] then getgenv()[service_name] = instance end
    return instance
end
wait(0.1)
easy_wrapper("Players")
easy_wrapper("Workspace")
easy_wrapper("HttpService")
easy_wrapper("CoreGui")
easy_wrapper("RunService")
easy_wrapper("UserInputService")
easy_wrapper("TweenService")
easy_wrapper("MarketplaceService")
easy_wrapper("TeleportService")
easy_wrapper("ReplicatedStorage")
easy_wrapper("StarterPlayer")
easy_wrapper("StarterGui")
easy_wrapper("Lighting")
easy_wrapper("CollectionService")
easy_wrapper("TextChatService")
easy_wrapper("SoundService")
easy_wrapper("PathfindingService")
easy_wrapper("GuiService")
easy_wrapper("ContextActionService")
easy_wrapper("Debris")
easy_wrapper("Chat")
easy_wrapper("VRService")
wait(0.25)
local Players              = getgenv().Players
local Workspace            = getgenv().Workspace
local CoreGui              = getgenv().CoreGui
local RunService           = getgenv().RunService
local UserInputService     = getgenv().UserInputService
local TweenService         = getgenv().TweenService
local MarketplaceService   = getgenv().MarketplaceService
local TextChatService      = getgenv().TextChatService
local Chat                 = getgenv().Chat
local LocalPlayer          = g.LocalPlayer or Players.LocalPlayer
local TextService          = getgenv().TextService
local UIS                  = getgenv().UserInputService
g.wait_until = function(condition, interval, max_tries)
    interval = tonumber(interval) or 0.05
    if typeof(max_tries) == "string" then
        local lower = max_tries:lower()
        -- [[ cannot be more obvious lol ]] --
        if lower == "inf" or lower == "infinite" or lower == "infinity" or lower == "∞" then
            max_tries = 999999999999
        else
            max_tries = tonumber(max_tries)
        end
    end

    max_tries = max_tries or 500
    if interval < 0.03 then interval = 0.05 end
    if typeof(condition) ~= "function" then
        local target = condition
        condition = function() return (typeof(target) == "Instance" and target.Parent ~= nil) or target end
    end

    local tries = 0
    repeat
        task.wait(interval)
        tries += 1
    until condition() or tries >= max_tries
    return condition() and true or false
end

local http_game = (getgenv()["game"] or game)["HttpGet"]
getgenv().http_get = function(url) return http_game(game, url) end
getgenv().Encode_To_Lua_Escapes = function(Text)
	local Result = {}
	for i = 1, #Text do table.insert(Result, "\\" .. string.byte(Text, i)) end
	return table.concat(Result)
end

getgenv().Decode_Lua_Escapes = function(Escaped_String)
	local Bytes = {}
	for Byte_Str in Escaped_String:gmatch("\\(%d+)") do table.insert(Bytes, tonumber(Byte_Str)) end
	local Chars = {}
	for _, Byte in ipairs(Bytes) do table.insert(Chars, string.char(Byte)) end
	return table.concat(Chars)
end

local has_gethui = (typeof(gethui) == "function") or (typeof(g.gethui) == "function")
local has_gethidden = (typeof(get_hidden_gui) == "function") or (typeof(g.get_hidden_gui) == "function")
if not has_gethui and not has_gethidden and not g.roblox_hidden_gui_location then
	g.roblox_hidden_gui_location = g.roblox_hidden_gui_location or nil
	if not g.roblox_hidden_gui_location then
		for _, v in ipairs(CoreGui:GetChildren()) do
			if v:IsA("ScreenGui") and v.Name == "RobloxGui" then
				g.roblox_hidden_gui_location = v
			end
		end
	end

	g.gethui = function()
		if g.roblox_hidden_gui_location and g.roblox_hidden_gui_location:IsA("ScreenGui") then
			return g.roblox_hidden_gui_location
		else
			return CoreGui
		end
	end

	g.get_hidden_gui = function()
		if g.roblox_hidden_gui_location and g.roblox_hidden_gui_location:IsA("ScreenGui") then
			return g.roblox_hidden_gui_location
		else
			return CoreGui
		end
	end
end

g.words_tbl = {
    "root_access","packet_inject","xor_key","decrypting",
    "init_stealth","spoof_id","kernel_hook","bruteforce",
    "sys_reboot","net_breach","ghost_mode","backdoor_init"
}

g.get_game_name = function(place_id)
    if not place_id then return end
    local conv_str = MarketplaceService:GetProductInfo(place_id)
    if conv_str and conv_str.Name then
        return conv_str.Name
    else
        if g.notify and typeof(g.notify) == "function" then
            return g.notify("Error", "The game either does not exist anymore or did not return anything from Roblox's API!", 5)
        else
            return warn("Game Name is not a string or was returned as nil!")
        end
    end
end

g.FuzzyFindChild = function(parent, query, timeout)
    if not parent or typeof(parent) ~= "Instance" then return nil end
    if not query or query == "" then return nil end
    timeout = timeout or 3
    local Lowered_Query = query:lower()
    local Start_Time = os.clock()

    repeat
        for _, Child in ipairs(parent:GetChildren()) do if Child.Name:lower():find(Lowered_Query, 1, true) then return Child end end
        task.wait(0.1)
    until os.clock() - Start_Time >= timeout
    return nil
end

g.FuzzyFindChildWithClass = function(parent, query, class_name, timeout)
    if not parent or typeof(parent) ~= "Instance" then return nil end
    if not query or query == "" then return nil end
    timeout = timeout or 3
    local Lowered_Query = query:lower()
    local Lowered_Class = class_name and class_name:lower() or nil
    local Start_Time = os.clock()

    repeat
        for _, Child in ipairs(parent:GetChildren()) do
            local Name_Match = Child.Name:lower():find(Lowered_Query, 1, true)
            local Class_Match = not Lowered_Class or Child.ClassName:lower() == Lowered_Class
            if Name_Match and Class_Match then return Child end
        end
        task.wait(0.1)
    until os.clock() - Start_Time >= timeout
    return nil
end

g.FuzzyFindDescendantWithClass = function(parent, query, class_name, timeout)
    if not parent or typeof(parent) ~= "Instance" then return nil end
    if not query or query == "" then return nil end
    timeout = timeout or 3
    local Lowered_Query = query:lower()
    local Lowered_Class = class_name and class_name:lower() or nil
    local Start_Time = os.clock()

    repeat
        for _, Child in ipairs(parent:GetDescendants()) do
            local Name_Match = Child.Name:lower():find(Lowered_Query, 1, true)
            local Class_Match = not Lowered_Class or Child.ClassName:lower() == Lowered_Class
            if Name_Match and Class_Match then return Child end
        end
        task.wait(0.1)
    until os.clock() - Start_Time >= timeout
    return nil
end

g.get_or_set = g.get_or_set or function(name, value)
    if rawget and rawset and typeof(rawget) == "function" and typeof(rawset) == "function" then
        local existing = rawget(g, name)
        if existing == nil then
            rawset(g, name, value)
            return value
        end
        return existing
    end

    local existing = g[name]
    if existing == nil then
        g[name] = value
        return value
    end

    return existing
end

g.all_current_asset_types = {
	[8]  = "Hat",
	[11] = "Shirt",
	[12] = "Pants",
	[17] = "Head",
	[18] = "Face",
	[19] = "Gear",
	[24] = "Animation",
	[32] = "Package",
	[41] = "HairAccessory",
	[42] = "FaceAccessory",
	[43] = "NeckAccessory",
	[44] = "ShoulderAccessory",
	[45] = "FrontAccessory",
	[46] = "BackAccessory",
	[47] = "WaistAccessory",
	[64] = "TShirtAccessory",
	[65] = "ShirtAccessory",
	[66] = "PantsAccessory",
	[67] = "JacketAccessory",
	[68] = "SweaterAccessory",
	[69] = "ShortsAccessory",
	[70] = "LeftShoeAccessory",
	[71] = "RightShoeAccessory",
	[72] = "DressSkirtAccessory",
	[74] = "EyebrowAccessory",
	[75] = "EyelashAccessory",
	[77] = "DynamicHead",
}

g.ASSET_TYPE_ID_TO_ENUM = {
	[8]  = Enum.AvatarAssetType.Hat,
	[41] = Enum.AvatarAssetType.HairAccessory,
	[42] = Enum.AvatarAssetType.FaceAccessory,
	[43] = Enum.AvatarAssetType.NeckAccessory,
	[44] = Enum.AvatarAssetType.ShoulderAccessory,
	[45] = Enum.AvatarAssetType.FrontAccessory,
	[46] = Enum.AvatarAssetType.BackAccessory,
	[47] = Enum.AvatarAssetType.WaistAccessory,
	[11] = Enum.AvatarAssetType.Shirt,
	[12] = Enum.AvatarAssetType.Pants,
}

g.ASSET_TYPE_ID_TO_NAME = {
	[8]  = "Hat",
	[41] = "HairAccessory",
	[42] = "FaceAccessory",
	[43] = "NeckAccessory",
	[44] = "ShoulderAccessory",
	[45] = "FrontAccessory",
	[46] = "BackAccessory",
	[47] = "WaistAccessory",
	[11] = "Shirt",
	[12] = "Pants",
}

g.colors = {
	Color3.fromRGB(255,255,255),
	Color3.fromRGB(128,128,128),
	Color3.fromRGB(0,0,0),
	Color3.fromRGB(0,0,255),
	Color3.fromRGB(0,255,0),
	Color3.fromRGB(0,255,255),
	Color3.fromRGB(255,165,0),
	Color3.fromRGB(139,69,19),
	Color3.fromRGB(255,255,0),
	Color3.fromRGB(50,205,50),
	Color3.fromRGB(255,0,0),
	Color3.fromRGB(255,155,172),
	Color3.fromRGB(128,0,128),
}

g.colors_color_three = {
	Color3.new(1, 1, 1),
	Color3.new(0.5019607843137255, 0.5019607843137255, 0.5019607843137255),
	Color3.new(0, 0, 0),
	Color3.new(0, 0, 1),
	Color3.new(0, 1, 0),
	Color3.new(0, 1, 1),
	Color3.new(1, 0.6470588235294118, 0),
	Color3.new(0.5450980392156862, 0.27058823529411763, 0.07450980392156863),
	Color3.new(1, 1, 0),
	Color3.new(0.19607843137254902, 0.803921568627451, 0.19607843137254902),
	Color3.new(1, 0, 0),
	Color3.new(1, 0.6078431372549019, 0.6745098039215686),
	Color3.new(0.5019607843137255, 0, 0.5019607843137255),
}

g._rgb_conns = g._rgb_conns or {}
g._rgb_global_conn = g._rgb_global_conn or nil
g.rgb_color_map = g.rgb_color_map or {
    red = Color3.fromRGB(255,0,0),
    darkred = Color3.fromRGB(139,0,0),
    green = Color3.fromRGB(0,255,0),
    darkgreen = Color3.fromRGB(0,100,0),
    lime = Color3.fromRGB(50,205,50),
    blue = Color3.fromRGB(0,0,255),
    darkblue = Color3.fromRGB(0,0,139),
    lightblue = Color3.fromRGB(173,216,230),
    skyblue = Color3.fromRGB(135,206,235),
    white = Color3.fromRGB(255,255,255),
    black = Color3.fromRGB(0,0,0),
    gray = Color3.fromRGB(128,128,128),
    lightgray = Color3.fromRGB(211,211,211),
    darkgray = Color3.fromRGB(64,64,64),
    yellow = Color3.fromRGB(255,255,0),
    gold = Color3.fromRGB(255,215,0),
    orange = Color3.fromRGB(255,165,0),
    darkorange = Color3.fromRGB(255,140,0),
    purple = Color3.fromRGB(128,0,128),
    violet = Color3.fromRGB(238,130,238),
    indigo = Color3.fromRGB(75,0,130),
    pink = Color3.fromRGB(255,105,180),
    hotpink = Color3.fromRGB(255,20,147),
    cyan = Color3.fromRGB(0,255,255),
    teal = Color3.fromRGB(0,128,128),
    brown = Color3.fromRGB(139,69,19),
    tan = Color3.fromRGB(210,180,140),
    magenta = Color3.fromRGB(255,0,255),
    coral = Color3.fromRGB(255,127,80),
    salmon = Color3.fromRGB(250,128,114)
}

g.rgb_color_index = {}
do
    local i = 1
    for name in pairs(g.rgb_color_map) do
        g.rgb_color_index[i] = name
        i = i + 1
    end
end

local function ensure_global_loop()
    if g._rgb_global_conn then return end
    local conn = RunService.RenderStepped:Connect(function(dt)
        local conns = g._rgb_conns
        local any = false
        for _, data in pairs(conns) do
            if data and data.obj then
                any = true
                if not data.paused then
                    data.hue = (data.hue + (dt * data.speed)) % 1
                    data.obj.BackgroundColor3 = Color3.fromHSV(data.hue, 1, 1)
                end
            end
        end

        if not any then
            g._rgb_global_conn:Disconnect()
            g._rgb_global_conn = nil
        end
    end)

    g._rgb_global_conn = conn
end

g.flowrgb = g.flowrgb or function(name, speed, obj, toggle)
    local conns = g._rgb_conns
    if toggle == false then
        conns[name] = nil
        return
    end

    conns[name] = {
        obj = obj,
        speed = speed,
        hue = 0,
        paused = false
    }

    ensure_global_loop()
end

g.toggle_rgb = g.toggle_rgb or function(name, state) -- toggle a certain connection.
    local data = g._rgb_conns[name]
    if data then data.paused = state end
end

g.toggle_all_rgb = g.toggle_all_rgb or function(state) -- toggle all
    for _, data in pairs(g._rgb_conns) do if data then data.paused = state end end
end

g.set_rgb_color_smart = g.set_rgb_color_smart or function(name, input)
    local data = g._rgb_conns[name]
    if not data or not data.obj then return end
    local color
    if typeof(input) == "string" then
        color = g.rgb_color_map[input:lower()]
    elseif typeof(input) == "number" then
        local cname = g.rgb_color_index[input]
        if cname then color = g.rgb_color_map[cname] end
    elseif typeof(input) == "Color3" then
        color = input
    end

    if not color then
        local keys = {}
        for k in pairs(g.rgb_color_map) do keys[#keys+1] = k end
        color = g.rgb_color_map[keys[math.random(1, #keys)]]
    end

    data.obj.BackgroundColor3 = color
end

g.set_all_rgb_color_smart = g.set_all_rgb_color_smart or function(input)
    local color

    if typeof(input) == "string" then
        color = g.rgb_color_map[input:lower()]
    elseif typeof(input) == "number" then
        local cname = g.rgb_color_index[input]
        if cname then color = g.rgb_color_map[cname] end
    elseif typeof(input) == "Color3" then
        color = input
    end

    if not color then
        local keys = {}
        for k in pairs(g.rgb_color_map) do keys[#keys+1] = k end
        color = g.rgb_color_map[keys[math.random(1, #keys)]]
    end

    for _, data in pairs(g._rgb_conns) do
        if data and data.obj then
            data.obj.BackgroundColor3 = color
        end
    end
end

g.set_all_rgb_color = g.set_all_rgb_color or function(color)
    for _, data in pairs(g._rgb_conns) do
        if data and data.obj then
            data.obj.BackgroundColor3 = color
        end
    end
end

getgenv().type_chooser = function(value)
    local ok, result = pcall(function() return typeof(value) end)
    if ok and result then return result end
    local ok2, result2 = pcall(function() return type(value) end)
    if ok2 and result2 then return result2 end
    return nil
end
wait(0.1)
getgenv().service_cache = getgenv().service_cache or {}
local aliases = {
    rs = "ReplicatedStorage",
    rf = "ReplicatedFirst",
    ws = "Workspace",
    works = "Workspace",
    player = "Players",
    plr = "Players",
    plrs = "Players",
    ts = "TweenService",
    uis = "UserInputService",
    aes = "AvatarEditorService"
}

local virtuals = {lp = true, localplayer = true, localplr = true}
local function levenshtein(a, b)
    a = a:lower()
    b = b:lower()
    local len_a, len_b = #a, #b
    if len_a == 0 then return len_b end
    if len_b == 0 then return len_a end
    local matrix = {}
    for i = 0, len_a do matrix[i] = {[0] = i} end
    for j = 0, len_b do matrix[0][j] = j end
    for i = 1, len_a do
        for j = 1, len_b do
        local cost = (a:sub(i,i) == b:sub(j,j)) and 0 or 1
        matrix[i][j] = math.min(
            matrix[i-1][j] + 1,
            matrix[i][j-1] + 1,
            matrix[i-1][j-1] + cost
        )
        end
    end

    return matrix[len_a][len_b]
end

local function resolve_service(input)
    if not input then return nil end
    local lowered = tostring(input):lower()
    if aliases[lowered] then return aliases[lowered] end
    local children = game:GetChildren()
    for _, svc in ipairs(children) do
        if svc.Name:lower() == lowered then
            return svc.Name
        end
    end

    for _, svc in ipairs(children) do
        if svc.Name:lower():find(lowered, 1, true) then
            return svc.Name
        end
    end

    local best_name
    local best_score = math.huge

    for _, svc in ipairs(children) do
        local score = levenshtein(lowered, svc.Name:lower())
        if score < best_score then
            best_score = score
            best_name = svc.Name
        end
    end

    if best_score <= 4 then return best_name end
    return nil
end

local function fetch_value(name)
    if not name then return nil end
    local lowered = tostring(name):lower()

    if virtuals[lowered] then
        local ok, players = pcall(function() return getgenv().service_cache["Players"].LocalPlayer end)
        if not ok or not players then return nil end
        local lp = players.LocalPlayer
        if lp then return lowered, lp end
        return nil
    end

    local resolved = resolve_service(name)
    if not resolved then return nil end
    local ok, svc = pcall(function() return game:GetService(resolved) end)
    if not ok or not svc then return nil end
    if cloneref then local success, cloned = pcall(function() return cloneref(svc) end); if success and cloned then svc = cloned end end
    return resolved, svc
end

if setmetatable and getmetatable and rawget and rawset then
    if not getmetatable(getgenv().service_cache) then
        setmetatable(getgenv().service_cache, {
        __index = function(self, key)
            local existing = rawget(self, key)
            if existing then return existing end
            local resolved_key, value = fetch_value(key)
            if not value then return nil end
            rawset(self, key, value)
            if resolved_key and resolved_key ~= key then rawset(self, resolved_key, value) end
            return value
        end})
    end

    getgenv().safe_wrapper = function(name)
        if not name then return nil end
        return getgenv().service_cache[name]
    end
else
    getgenv().safe_wrapper = function(name)
        if not name then return nil end
        if getgenv().service_cache[name] then return getgenv().service_cache[name] end
        local resolved_key, value = fetch_value(name)
        if not value then return nil end
        getgenv().service_cache[name] = value
        if resolved_key and resolved_key ~= name then getgenv().service_cache[resolved_key] = value end
        return value
    end
end

local function resolve_property(map, search)
    local search_lower = search:lower()
    local matches = {}

    for _, prop_name in ipairs(map) do
        if prop_name:lower():find(search_lower) then
            table.insert(matches, prop_name)
        end
    end

    return matches
end

getgenv().FlamesLibrary = getgenv().FlamesLibrary or {}
getgenv().FlamesLibrary._connections = getgenv().FlamesLibrary._connections or {}
getgenv().FlamesLibrary.modules = getgenv().FlamesLibrary.modules or {}
getgenv().FlamesLibrary.module_utils = getgenv().FlamesLibrary.module_utils or {}
getgenv().FlamesLibrary.table_lib = getgenv().FlamesLibrary.table_lib or {} -- new 'table' methods and usage, making us only more efficient.
getgenv().FlamesLibrary.connect = function(name, connection)
    local FL = getgenv().FlamesLibrary
    if type(name) ~= "string" then return end
    if typeof(connection) ~= "RBXScriptConnection" then return end
    if type(FL._connections) ~= "table" then FL._connections = {} end
    FL.disconnect(name)
    FL._connections[name] = {connection}
    return connection
end

getgenv().FlamesLibrary.disconnect = function(name)
    local FL = getgenv().FlamesLibrary
    if type(name) ~= "string" then return end
    if type(FL._connections) ~= "table" then return end
    local list = FL._connections[name]
    FL._connections[name] = nil
    if type(list) ~= "table" then return end
    local current = coroutine.running()
    for _, item in ipairs(list) do
        if typeof(item) == "RBXScriptConnection" then
            if item.Connected then pcall(item.Disconnect, item) end
        elseif type(item) == "thread" then
            if item ~= current and coroutine.status(item) ~= "dead" then pcall(task.cancel, item) end
        end
    end
end

getgenv().FlamesLibrary.spawn = function(name, mode, ...)
    local FL = getgenv().FlamesLibrary
    if type(name) ~= "string" or type(mode) ~= "string" then return end
    if type(FL._connections) ~= "table" then FL._connections = {} end
    if FL._connections[name] and type(FL.disconnect) == "function" then FL.disconnect(name) end
    local args = table.pack(...)
    local thread
    if mode == "spawn" or mode == "defer" or mode == "wrap" then
        local func = args[1]
        if type(func) ~= "function" then return end
        if mode == "spawn" then
            thread = task.spawn(func, table.unpack(args, 2, args.n))
        elseif mode == "defer" then
            thread = task.defer(func, table.unpack(args, 2, args.n))
        else
            thread = coroutine.create(func)
            coroutine.resume(thread, table.unpack(args, 2, args.n))
        end
    elseif mode == "delay" then
        local delay_time, func = args[1], args[2]
        if type(delay_time) ~= "number" or type(func) ~= "function" then return end
        thread = task.delay(delay_time, func, table.unpack(args, 3, args.n))
    else
        return
    end

    if type(FL._connections) ~= "table" then FL._connections = {} end
    local bucket = FL._connections[name]
    if type(bucket) ~= "table" then bucket = {}; FL._connections[name] = bucket end
    table.insert(bucket, thread)
    return thread
end

getgenv().FlamesLibrary.is_thread_alive = function(input)
    local lib = getgenv().FlamesLibrary
    if type(input) == "thread" then
        local ok, status = pcall(coroutine.status, input)
        if not ok then return false end
        return status ~= "dead"
    end

    if type(input) == "string" then
        local list = lib._connections[input]
        if not list then return false end
        for _, item in ipairs(list) do
            if type(item) == "thread" then
                local ok, status = pcall(coroutine.status, item)
                if ok and status ~= "dead" then return true end
            end
        end
        return false
    end

    return false
end

getgenv().FlamesLibrary.is_alive = function(name)
    local lib = getgenv().FlamesLibrary
    local list = lib._connections[name]
    if not list then return false end
    for _, item in ipairs(list) do
        if typeof(item) == "RBXScriptConnection" then
            if item.Connected then
                return true
            end
        elseif type(item) == "thread" then
            if lib.is_thread_alive(item) then
                return true
            end
        end
    end

    return false
end

getgenv().FlamesLibrary.safe_func = function(...)
    for i = 1, select("#", ...) do
        local f = select(i, ...)
        local ok, t = pcall(typeof, f)
        if ok and t == "function" then return f end
    end
    return function() end
end

-- [[ safer wait functionality. ]] --
getgenv().FlamesLibrary.wait = function(t)
    if not t or t <= 0 then RunService.Heartbeat:Wait(); return end
    local ok = pcall(task.wait, t)
    if not ok then RunService.Heartbeat:Wait() end
end

getgenv().FlamesLibrary.cleanup_all = function() for name in pairs(getgenv().FlamesLibrary._connections) do getgenv().FlamesLibrary.disconnect(name) end end
getgenv().FlamesLibrary.modules.chat_filter_override = {
    enabled = false,
    -- [[ All encoded to bypass any filters (even in games). ]] --
    _encoded_patterns = {
        "c2hpdA==", "ZnVjaw==", "YXNz", "YmlhdGNo", "ZGFtbg==",
        "Y3JhcA==", "aGVsbA==", "YmFzdGFyZA==", "ZGljaw==", "cGlzcw==",
        "Y3VudA==", "Y29jaw==", "ZmFn", "c2x1dA==", "d2hvcmU=",
        "bmln", "cmV0YXJk", "cmFwZQ==", "a2lsbCB5b3Vyc2VsZg==",
        "a3lz", "ZmFnZ290", "dHdhdA=="
    },

    _bad_patterns = nil,
    _decode_patterns = function(self)
        if self._bad_patterns then return end
        self._bad_patterns = {}
        local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        for _, enc in ipairs(self._encoded_patterns) do
            local decoded = enc:gsub("[^"..b.."=]", "")
            local result = ""
            local padding = decoded:sub(-2) == "==" and 2 or decoded:sub(-1) == "=" and 1 or 0
            decoded = decoded:gsub("=", "A")
            for i = 1, #decoded, 4 do
                local c1, c2, c3, c4 = decoded:sub(i,i), decoded:sub(i+1,i+1), decoded:sub(i+2,i+2), decoded:sub(i+3,i+3)
                local n1 = b:find(c1) - 1
                local n2 = b:find(c2) - 1
                local n3 = b:find(c3) - 1
                local n4 = b:find(c4) - 1
                local combined = n1 * 262144 + n2 * 4096 + n3 * 64 + n4
                result = result .. string.char(
                    math.floor(combined / 65536) % 256,
                    math.floor(combined / 256) % 256,
                    combined % 256
                )
            end
            table.insert(self._bad_patterns, result:sub(1, #result - padding))
        end
    end,

    _cache = {},
    _cache_limit = 100,
    _will_tag_sync = function(self, text)
        self:_decode_patterns()
        local lower = text:lower():gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
        if self._cache[lower] ~= nil then return self._cache[lower] end
        local result = false
        for _, pattern in ipairs(self._bad_patterns) do if lower:find(pattern, 1, true) then result = true; break end end
        if not result then
            local spaced = lower:gsub("%s+", "")
            for _, pattern in ipairs(self._bad_patterns) do if spaced:find(pattern:gsub("%s+", ""), 1, true) then result = true; break end end
        end

        if not result then
            local leet_map = {
                ["@"]="a",["4"]="a",["3"]="e",["1"]="i",
                ["!"]="i",["0"]="o",["5"]="s",["$"]="s",
                ["7"]="t",["+"]="t",
            }
            local decoded_text = lower:gsub(".", function(c) return leet_map[c] or c end)
            for _, pattern in ipairs(self._bad_patterns) do if decoded_text:find(pattern, 1, true) then result = true; break end end
        end
        if #self._cache >= self._cache_limit then
            local keys = {}
            for k in pairs(self._cache) do table.insert(keys, k) end
            for i = 1, math.floor(self._cache_limit / 2) do self._cache[keys[i]] = nil end
        end

        self._cache[lower] = result
        return result
    end,

    _async_verify = function(self, text, on_result)
        g.FlamesLibrary.spawn("chat_filter_async_verify", "spawn", function()
            local filtered = nil
            local ok = pcall(function() filtered = Chat:FilterStringForBroadcast(text, Players.LocalPlayer) end)
            local flagged = false
            if ok and filtered ~= nil then
                if #filtered ~= #text then
                    flagged = true
                else
                    for i = 1, #text do if filtered:sub(i, i) == "#" and text:sub(i, i) ~= "#" then flagged = true; break end end
                end
            end
            if on_result then on_result(flagged) end
        end)
    end,

    start = function(self)
        if self.enabled then return end
        self.enabled = true
        TextChatService.OnIncomingMessage = function(msg)
            local prop = Instance.new("TextChatMessageProperties")
            if not msg.TextSource then return prop end
            if msg.TextSource.UserId ~= LocalPlayer.UserId then return prop end
            local raw_text = msg.Text or ""
            if self:_will_tag_sync(raw_text) then
                prop.Text = ""
                prop.PrefixText = ""
                if g.notify and typeof(g.notify) == "function" then g.notify("Warning", "Blocked a message that would've been filtered.", 3) end
                return prop
            end
            self:_async_verify(raw_text, function(async_flagged)
                if async_flagged then
                    self._cache[raw_text:lower():gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")] = true
                    if g.notify and typeof(g.notify) == "function" then g.notify("Success", "Async filter caught it — cache updated.", 3) end
                end
            end)
            return prop
        end
    end,

    stop = function(self)
        if not self.enabled then return end
        self.enabled = false
        pcall(function() TextChatService.OnIncomingMessage = nil end)
        g.FlamesLibrary.disconnect("chat_filter_async_verify")
    end,

    toggle = function(self, state)
        if state == nil then state = not self.enabled end
        if state then self:start() else self:stop() end
    end
}

getgenv().FlamesLibrary.modules.disable_all = function()
    for name, mod in pairs(getgenv().FlamesLibrary.modules) do
        if type(mod) == "table" and mod.stop then
            mod:stop()
        end
    end
end

getgenv().FlamesLibrary.modules.list_enabled = function()
    local active = {}
    for name, mod in pairs(getgenv().FlamesLibrary.modules) do
        if type(mod) == "table" and mod.enabled then
            table.insert(active, name)
        end
    end
    return active
end

getgenv().FlamesLibrary.modules.list_disabled = function()
    local inactive = {}
    for name, mod in pairs(getgenv().FlamesLibrary.modules) do
        if type(mod) == "table" and not mod.enabled then
            table.insert(inactive, name)
        end
    end
    return inactive
end

getgenv().FlamesLibrary.property_maps = getgenv().FlamesLibrary.property_maps or {}
getgenv().FlamesLibrary.property_maps.humanoid = {
    "AutoJumpEnabled",
    "AutoRotate",
    "AutomaticScalingEnabled",
    "BreakJointsOnDeath",
    "CameraOffset",
    "CollisionType",
    "DisplayDistanceType",
    "DisplayName",
    "EvaluateStateMachine",
    "FloorMaterial",
    "HealthDisplayDistance",
    "HealthDisplayType",
    "HipHeight",
    "Jump",
    "JumpHeight",
    "JumpPower",
    "LeftLeg",
    "MaxSlopeAngle",
    "MoveDirection",
    "NameDisplayDistance",
    "NameOcclusion",
    "PlatformStand",
    "RequiresNeck",
    "RigType",
    "RightLeg",
    "RootPart",
    "SeatPart",
    "Sit",
    "TargetPoint",
    "Torso",
    "UseJumpPower",
    "WalkSpeed",
    "WalkToPart",
    "WalkToPoint",
}

getgenv().FlamesLibrary.property_maps.starter_player = {
    "AllowCustomAnimations",
    "AutoJumpEnabled",
    "AvatarJointUpgrade",
    "CameraMaxZoomDistance",
    "CameraMinZoomDistance",
    "CameraMode",
    "CharacterBreakJointsOnDeath",
    "CharacterJumpHeight",
    "CharacterJumpPower",
    "CharacterMaxSlopeAngle",
    "CharacterUseJumpPower",
    "CharacterWalkSpeed",
    "ClassicDeath",
    "CreateDefaultPlayerModule",
    "DevCameraOcclusionMode",
    "DevComputerCameraMovementMode",
    "DevComputerMovementMode",
    "DevTouchCameraMovementMode",
    "DevTouchMovementMode",
    "EnableDynamicHeads",
    "EnableMouseLockOption",
    "GameSettingsAssetIDFace",
    "GameSettingsAssetIDHead",
    "GameSettingsAssetIDLeftArm",
    "GameSettingsAssetIDLeftLeg",
    "GameSettingsAssetIDPants",
    "GameSettingsAssetIDRightArm",
    "GameSettingsAssetIDRightLeg",
    "GameSettingsAssetIDShirt",
    "GameSettingsAssetIDTeeShirt",
    "GameSettingsAssetIDTorso",
    "GameSettingsAvatar",
    "GameSettingsR15Collision",
    "GameSettingsScaleRangeBodyType",
    "GameSettingsScaleRangeHead",
    "GameSettingsScaleRangeHeight",
    "GameSettingsScaleRangeProportion",
    "GameSettingsScaleRangeWidth",
    "HealthDisplayDistance",
    "LoadCharacterAppearance",
    "LoadCharacterLayeredClothing",
    "LuaCharacterController",
    "NameDisplayDistance",
    "UserEmotesEnabled",
}

getgenv().FlamesLibrary.set_humanoid_property = function(humanoid, property, value)
    if not humanoid or typeof(humanoid) ~= "Instance" or not humanoid:IsA("Humanoid") then return false, "invalid humanoid" end
    local matches = resolve_property(getgenv().FlamesLibrary.property_maps.humanoid, property)
    if #matches == 0 then return false, "no matching humanoid property for: " .. tostring(property) end
    if #matches > 1 then return false, "ambiguous property search: " .. tostring(property) .. " matched " .. table.concat(matches, ", ") end
    local resolved = matches[1]
    local success, err = pcall(function() humanoid[resolved] = value end)
    if not success then return false, "failed to set " .. resolved .. ": " .. tostring(err) end
    return true, resolved
end

getgenv().FlamesLibrary.set_starter_player_property = function(property, value)
    local starter_player = cloneref and cloneref(game:GetService("StarterPlayer")) or game:GetService("StarterPlayer")
    local matches = resolve_property(getgenv().FlamesLibrary.property_maps.starter_player, property)
    if #matches == 0 then return false, "no matching starter_player property for: " .. tostring(property) end
    if #matches > 1 then return false, "ambiguous property search: " .. tostring(property) .. " matched " .. table.concat(matches, ", ") end
    local resolved = matches[1]
    local success, err = pcall(function() starter_player[resolved] = value end)
    if not success then return false, "failed to set " .. resolved .. ": " .. tostring(err) end
    return true, resolved
end

-- [[ New 'table' methods. ]] --
getgenv().FlamesLibrary.table_lib._is_table = function(value) return type(value) == "table" end
getgenv().FlamesLibrary.table_lib._is_index = function(value) return type(value) == "number" and value == math.floor(value) end
getgenv().FlamesLibrary.table_lib._is_frozen = function(tbl)
    if not table.isfrozen then return false end
    local ok, frozen = pcall(table.isfrozen, tbl)
    return ok and frozen
end

getgenv().FlamesLibrary.table_lib._deep_clone = function(source, seen)
    local lib = getgenv().FlamesLibrary.table_lib
    if seen[source] then return seen[source] end
    local copy = {}
    seen[source] = copy
    for key, value in next, source do
        local new_key = lib._is_table(key) and lib._deep_clone(key, seen) or key
        copy[new_key] = lib._is_table(value) and lib._deep_clone(value, seen) or value
    end
    local meta = getmetatable(source)
    if lib._is_table(meta) then pcall(setmetatable, copy, meta) end
    return copy
end

getgenv().FlamesLibrary.table_lib._shallow_clone = function(source)
    local lib = getgenv().FlamesLibrary.table_lib
    if table.clone then
        local ok, copy = pcall(table.clone, source)
        if ok then return copy end
    end
    local copy = {}
    for key, value in next, source do copy[key] = value end
    local meta = getmetatable(source)
    if lib._is_table(meta) then pcall(setmetatable, copy, meta) end
    return copy
end

getgenv().FlamesLibrary.table_lib._deep_freeze = function(tbl, seen)
    local lib = getgenv().FlamesLibrary.table_lib
    if seen[tbl] then return end
    seen[tbl] = true
    for key, value in next, tbl do
        if lib._is_table(key) then lib._deep_freeze(key, seen) end
        if lib._is_table(value) then lib._deep_freeze(value, seen) end
    end
    if not lib._is_frozen(tbl) then table.freeze(tbl) end
end

getgenv().FlamesLibrary.table_lib.insert = function(tbl, ...)
    local lib = getgenv().FlamesLibrary.table_lib
    if not lib._is_table(tbl) then return false, "invalid table" end
    if lib._is_frozen(tbl) then return false, "table is frozen" end
    local count = select("#", ...)
    if count == 1 then
        local value = ...
        if value == nil then return false, "value is nil" end
        local ok, err = pcall(table.insert, tbl, value)
        if not ok then return false, "insert failed: " .. tostring(err) end
        return true, #tbl
    elseif count == 2 then
        local position, value = ...
        if not lib._is_index(position) then return false, "position must be an integer" end
        if value == nil then return false, "value is nil" end
        if position < 1 or position > #tbl + 1 then
            return false, "position " .. tostring(position) .. " out of bounds (1 to " .. tostring(#tbl + 1) .. ")"
        end
        local ok, err = pcall(function() table.insert(tbl, value) end)
        if not ok then return false, "insert failed: " .. tostring(err) end
        return true, position
    end
    return false, "expected (value) or (position, value)"
end

getgenv().FlamesLibrary.table_lib.remove = function(tbl, position)
    local lib = getgenv().FlamesLibrary.table_lib
    if not lib._is_table(tbl) then return false, "invalid table" end
    if lib._is_frozen(tbl) then return false, "table is frozen" end
    local length = #tbl
    if length == 0 then return false, "table is empty" end
    if position ~= nil then
        if not lib._is_index(position) then return false, "position must be an integer" end
        if position < 1 or position > length then
            return false, "position " .. tostring(position) .. " out of bounds (1 to " .. tostring(length) .. ")"
        end
    end
    local ok, removed = pcall(table.remove, tbl, position)
    if not ok then return false, "remove failed: " .. tostring(removed) end
    return true, removed
end

getgenv().FlamesLibrary.table_lib.clone = function(tbl, deep)
    local lib = getgenv().FlamesLibrary.table_lib
    if not lib._is_table(tbl) then return false, "invalid table" end
    local ok, result = pcall(function()
        if deep == true then return lib._deep_clone(tbl, {}) end
        return lib._shallow_clone(tbl)
    end)
    if not ok then return false, "clone failed: " .. tostring(result) end
    return true, result
end

getgenv().FlamesLibrary.table_lib.freeze = function(tbl, deep)
    local lib = getgenv().FlamesLibrary.table_lib
    if not lib._is_table(tbl) then return false, "invalid table" end
    if not table.freeze then return false, "table.freeze is not supported here" end
    if deep ~= true and lib._is_frozen(tbl) then return true, tbl end
    local ok, err = pcall(function()
        if deep == true then
            lib._deep_freeze(tbl, {})
        else
            table.freeze(tbl)
        end
    end)
    if not ok then return false, "freeze failed: " .. tostring(err) end
    return true, tbl
end
wait(0.1)
local FL = getgenv().FlamesLibrary
g.create_ui = g.create_ui or function(config, global_name, atlas_chain)
    config = config or {}
    local default_chain = {
        "https://gitlab.com/flames2431233/Starter/-/raw/main/UIs/Atlas.lua",
        "https://codeberg.org/talkinboutlol/FlamesHub/raw/branch/main/UIs/Atlas.lua",
        "https://pastebin.com/raw/9Vs0Pq8k",
        "https://pastefy.app/gTPqx1DG/raw",
    }
    local chain = atlas_chain or default_chain
    local defaults = {
        Name         = "Flames Hub",
        ConfigFolder = "FlamesHub_Configuration",
        Color        = Color3.fromRGB(21, 103, 251),
        Credit       = "Flames Hub",
        Bind         = "RightShift",
    }

    local resolved = {}
    for k, v in next, defaults do resolved[k] = v end
    for k, v in next, config do resolved[k] = v end
    local function validate_body(body) return type(body) == "string" and #body > 10 end
    local function try_request(url)
        local http_fn = request or http_request or (syn    and syn.request) or (http   and http.request) or (fluxus and fluxus.request)
        if http_fn and type(http_fn) == "function" then
            local ok, res = pcall(http_fn, { Url = url, Method = "GET" })
            if ok and type(res) == "table" then
                local status = res.StatusCode or res.statusCode or res.status or res.Status
                local body   = res.Body or res.body or res.Response or res.response
                if (status == 200 or status == nil) and validate_body(body) then return body end
            end
        end

        if getgenv().http_get and type(getgenv().http_get) == "function" then
            local ok, body = pcall(getgenv().http_get, url)
            if ok and validate_body(body) then return body end
        end
        return nil
    end

    local function try_load_chain()
        for _, url in ipairs(chain) do
            local src = try_request(url)
            if not src then
                warn("[create_ui]: fetch failed -> " .. url)
                continue
            end

            local fn, compile_err = loadstring(src)
            if not fn then
                warn("[create_ui]: compile error from " .. url .. " -> " .. tostring(compile_err))
                continue
            end

            local run_ok, result = pcall(fn)
            if not run_ok then warn("[create_ui]: runtime error from " .. url .. " -> " .. tostring(result)); continue end
            if type(result) == "table" and type(result.new) == "function" then return result end
            warn("[create_ui]: invalid Atlas return from " .. url .. ", trying next")
        end
        return nil
    end

    local ui, err
    local done = false
    FL.spawn("create_ui_load", "defer", function()
        local ok, result = pcall(function()
            local cached = getgenv().__AtlasLib
            local cache_valid = type(cached) == "table" and type(cached.new) == "function"
            if not cache_valid then
                getgenv().__AtlasLib = nil
                local lib = try_load_chain()
                if not lib then warn("[create_ui]: all Atlas sources exhausted.") end
                getgenv().__AtlasLib = lib
            else
                local existing = CoreGui:FindFirstChild("Atlas")
                if existing and existing:IsA("ScreenGui") then
                    existing:Destroy()
                    local timeout = tick() + 5
                    repeat FL.wait()
                    until not CoreGui:FindFirstChild("Atlas") or tick() > timeout
                end
            end
            return getgenv().__AtlasLib.new(resolved)
        end)

        if ok then
            ui = result
        else
            err = result
            getgenv().__AtlasLib = nil
        end
        done = true
    end)

    while not done do FL.wait() end
    if err then
        local msg = "create_ui failed: " .. tostring(err)
        if g.notify then g.notify("Error", msg, 10) else warn(msg) end
        return nil
    end

    if global_name then getgenv()[global_name] = ui end
    return ui
end
FL.wait(0.25)
g.create_ui_element = g.create_ui_element or function(element_type, parent, config, global_name, flag)
    local creators = {
        Tab         = function() return parent:CreatePage(config) end,
        Page        = function() return parent:CreatePage(config) end,
        Section     = function() return parent:CreateSection(config) end,
        Toggle      = function() return parent:CreateToggle(config, flag) end,
        Slider      = function() return parent:CreateSlider(config, flag) end,
        Button      = function() return parent:CreateButton(config, flag) end,
        ColorPicker = function() return parent:CreateColorPicker(config, flag) end,
        Input       = function() return parent:CreateTextBox(config, flag) end,
        Dropdown    = function() return parent:CreateDropdown(config, flag) end,
        Label       = function() return parent:CreateLabel(config, flag) end,
    }

    local creator = creators[element_type]
    if not creator then g.notify("Error", "Unknown element type: "..tostring(element_type), 1); return end
    local captured_flag = flag
    local captured_config = config
    local element
    local done = false
    FL.spawn("create_ui_element_load", "defer", function()
        local ok, result = pcall(function()
            if element_type == "Toggle" then
                return parent:CreateToggle(captured_config, captured_flag)
            elseif element_type == "Slider" then
                return parent:CreateSlider(captured_config, captured_flag)
            elseif element_type == "Button" then
                return parent:CreateButton(captured_config, captured_flag)
            elseif element_type == "ColorPicker" then
                return parent:CreateColorPicker(captured_config, captured_flag)
            elseif element_type == "Input" then
                return parent:CreateTextBox(captured_config, captured_flag)
            elseif element_type == "Dropdown" then
                return parent:CreateDropdown(captured_config, captured_flag)
            elseif element_type == "Label" then
                return parent:CreateLabel(captured_config, captured_flag)
            elseif element_type == "Tab" or element_type == "Page" then
                return parent:CreatePage(captured_config)
            elseif element_type == "Section" then
                return parent:CreateSection(captured_config)
            end
            return
        end)
        if ok then element = result else g.notify("Error", "[create_ui_element]: " .. tostring(result), 0.25); end
        done = true
    end)

    while not done do FL.wait() end
    if global_name then getgenv()[global_name] = element end
    return element
end

local function retrieve_executor()
    local f = identifyexecutor
    if f and type(f) == "function" then return { Name = f() } end
    return { Name = tostring(f or "Unknown Executor") }
end

local function hb() getgenv().FlamesLibrary.wait() end
local function identify_executor_clean() return tostring(retrieve_executor().Name) end
local executor_string = identify_executor_clean()
local function executor_contains(substr) if type(executor_string) ~= "string" then return false end; return string.find(executor_string:lower(), substr:lower(), 1, true) ~= nil end
executor_contains = g.get_or_set and g.get_or_set("executor_contains", executor_contains)
local Executor_Name = identify_executor_clean()
g.blank = g.blank or function(...) return ... end
g.blankfunction = g.blankfunction or function(...) return ... end
g.set_fps = g.set_fps or function(fps) -- every possible name.
    if setfpscap then
        return setfpscap(fps)
    elseif setfps then
        return setfps(fps)
    elseif set_fps_cap then
        return set_fps_cap(fps)
    elseif set_fps then
        return set_fps(fps)
    else
        return nil
    end
end

-- [[ not sure if it works correctly, but this is a BETA function checker I've implemented for now I plan to use later. ]] --
g._function_cache = g._function_cache or {}
g.check_function = function(func) -- might get rid of this.
    if typeof(func) == "function" then return func end
    if typeof(func) ~= "string" then return false end
    local name = func:lower()
    local cached = g._function_cache[name]
    if cached ~= nil then return cached or false end
    local genv = getgenv()
    for k, v in pairs(genv) do
        if typeof(v) == "function" and tostring(k):lower() == name then
            g._function_cache[name] = v
            return v
        end
    end

    local env = (getfenv :: any)(0)
    for k, v in pairs(env) do
        if typeof(v) == "function" and tostring(k):lower() == name then
            g._function_cache[name] = v
            return v
        end
    end

    g._function_cache[name] = false
    return false
end

getgenv().low_level_executor = getgenv().low_level_executor or function()
    if Executor_Name == "Solara" or string.find(Executor_Name, "JJSploit") or Executor_Name == "Xeno" then
        return true
    else
        return false
    end
end

g.Game = game_ref
g.JobID = game_ref.JobId
g.PlaceID = game_ref.PlaceId
pcall(function() g.set_fps(360) end)
g.AllClipboards = g.AllClipboards or getgenv().FlamesLibrary.safe_func(setclipboard, toclipboard, set_clipboard, Clipboard and Clipboard.set)
g.httprequest_Init = g.httprequest_Init or getgenv().FlamesLibrary.safe_func(syn and syn.request, http and http.request, http_request, fluxus and fluxus.request, request)
g.get_http = g.httprequest_Init
g.queueteleport = g.queueteleport or getgenv().FlamesLibrary.safe_func(syn and syn.queue_on_teleport, queue_on_teleport, fluxus and fluxus.queue_on_teleport)

do
    local active_frame     = nil
    local active_drag_start = nil
    local active_start_pos  = nil
    local last_input_pos    = nil
    local active_tween      = nil
    local GLOBAL_KEY = "dragify_global"
    local TWEEN_INFO = TweenInfo.new(0.05, Enum.EasingStyle.Linear)
    local MIN_DELTA  = 2
    local function cancel_tween()
        if active_tween then
            pcall(function() active_tween:Cancel() end)
            active_tween = nil
        end
    end

    local function stop_drag()
        active_frame      = nil
        active_drag_start = nil
        active_start_pos  = nil
        last_input_pos    = nil
        cancel_tween()
    end

    local function frame_valid(f)
        local ok, res = pcall(function()
        return f and f.Parent and f:IsDescendantOf(game)
        end)
        return ok and res
    end

    getgenv().FlamesLibrary.connect(GLOBAL_KEY .. "_heartbeat", RunService.Heartbeat:Connect(function()
        if not active_frame or not last_input_pos then return end
        if not frame_valid(active_frame) then
            stop_drag()
            return
        end

        local delta = last_input_pos - active_drag_start
        if delta.Magnitude < MIN_DELTA then return end
        local sp  = active_start_pos
        local pos = UDim2.new(
            sp.X.Scale,
            sp.X.Offset + delta.X,
            sp.Y.Scale,
            sp.Y.Offset + delta.Y
        )

        cancel_tween()
        active_tween = TweenService:Create(active_frame, TWEEN_INFO, { Position = pos })
        active_tween:Play()
    end))

    getgenv().FlamesLibrary.connect(GLOBAL_KEY .. "_changed", UserInputService.InputChanged:Connect(function(input)
        if not active_frame then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then last_input_pos = input.Position end
    end))

    getgenv().FlamesLibrary.connect(GLOBAL_KEY .. "_ended", UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then stop_drag() end
    end))

    getgenv().dragify = function(frame)
        if not frame then return end
        while not frame_valid(frame) do task.wait() end
        local frame_key = "dragify_" .. tostring(frame) .. "_" .. tostring(frame:GetDebugId())
        getgenv().FlamesLibrary.connect(frame_key .. "_began", frame.InputBegan:Connect(function(input)
            if not frame_valid(frame) then return end
            if UserInputService:GetFocusedTextBox() then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if active_frame and active_frame ~= frame then stop_drag() end
                active_frame      = frame
                active_drag_start = input.Position
                active_start_pos  = frame.Position
                last_input_pos    = input.Position
            end
        end))

        getgenv().FlamesLibrary.connect(frame_key .. "_ancestry", frame.AncestryChanged:Connect(function(_, parent)
            if not parent then
                if active_frame == frame then stop_drag() end
                getgenv().FlamesLibrary.disconnect(frame_key .. "_began")
                getgenv().FlamesLibrary.disconnect(frame_key .. "_ancestry")
            end
        end))
    end
end

local fps = setfpscap or setfps or set_fps_cap or set_fps or g.blank
SetFPSCap = g.get_or_set("SetFPSCap", fps)
local LibraryName = "Notification Library"
g.NotificationLibrary = {}
local PlayerGui = g.PlayerGui or LocalPlayer:FindFirstChildWhichIsA("PlayerGui") or LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 3)
local parent_gui = (get_hidden_gui and get_hidden_gui()) or (gethui and gethui()) or CoreGui or PlayerGui
local library
local Template_Folder
local canvas
g.NotificationLibrary.Load = function()
    local objects = game:GetObjects("rbxassetid://15133757123")
    if not objects or #objects == 0 then
        warn("[NotificationLibrary]: Asset failed to load — rbxassetid://15133757123 returned nil or empty.")
        return false
    end

    library = objects[1]
    if not library then
        warn("[NotificationLibrary]: Asset index [1] is nil after GetObjects call.")
        return false
    end

    if not library:FindFirstChild("Templates") then
        warn("[NotificationLibrary]: Loaded asset is missing 'Templates' folder.")
        library:Destroy()
        library = nil
        return false
    end

    if not library:FindFirstChild("list") then
        warn("[NotificationLibrary]: Loaded asset is missing 'list' canvas.")
        library:Destroy()
        library = nil
        return false
    end

    Template_Folder = library.Templates
    canvas = library.list
    library.Name = LibraryName
    library.Parent = parent_gui
    return true
end

g.NotificationLibrary.SendNotification = function(Mode, Text, Duration)
    local library_core = parent_gui:FindFirstChild(LibraryName)

    if not library_core then
        local loaded = g.NotificationLibrary:Load()
        if not loaded then
            warn("[NotificationLibrary]: SendNotification aborted — library failed to initialize.")
            return
        end
    else
        library = library_core
        Template_Folder = library:FindFirstChild("Templates")
        canvas = library:FindFirstChild("list")

        if not Template_Folder or not canvas then
            warn("[NotificationLibrary]: Cached library is corrupt — re-initializing.")
            library_core:Destroy()
            library = nil
            Template_Folder = nil
            canvas = nil
            local loaded = g.NotificationLibrary:Load()
            if not loaded then
                warn("[NotificationLibrary]: Re-initialization failed.")
                return
            end
        end
    end

    if not Template_Folder:FindFirstChild(Mode) then
        warn(tostring(Mode) .. " is not a valid Mode! (only: Warning, Success, Error, Info).")
        return
    end

    task.spawn(function()
        local success, err = pcall(function()
            local Notification = Template_Folder:WaitForChild(Mode):Clone()
            local filler = Notification.Filler
            local bar = Notification.bar

            Notification.Header.Text = Text
            Notification.Visible = true
            Notification.Parent = canvas
            Notification.Size = UDim2.new(0, 0, 0.087, 0)
            filler.Size = UDim2.new(1, 0, 1, 0)

            local T1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local T2 = TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local T3 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

            TweenService:Create(Notification, T1, {Size = UDim2.new(1, 0, 0.087, 0)}):Play()
            task.wait(0.2)
            TweenService:Create(filler, T3, {Size = UDim2.new(0.011, 0, 1, 0)}):Play()
            TweenService:Create(bar, T2, {Size = UDim2.new(1, 0, 0.05, 0)}):Play()
            task.wait(Duration)
            TweenService:Create(filler, T1, {Size = UDim2.new(1, 0, 1, 0)}):Play()
            task.wait(0.25)
            TweenService:Create(Notification, T3, {Size = UDim2.new(0, 0, 0.087, 0)}):Play()
            task.wait(0.25)
            Notification:Destroy()
        end)

        if not success then
            warn("[NotificationLibrary]: Error during notification render:")
            warn(err)
        end
    end)
end

local NotificationLibrary_External = getgenv().NotificationLibrary
local Sound_ID_Windows = "rbxassetid://8183296024"
local Sound_ID_iPhone = "rbxassetid://73722479618078"
local Sound_ID_Android = "rbxassetid://17582299860"
local Sound_ID_Universal = "rbxassetid://18595195017"
local Notification_Wrapper = {}
local function Device_Detector()
    local platform = UserInputService:GetPlatform()
    local platform_map = {
        [Enum.Platform.Windows] = "Windows",
        [Enum.Platform.OSX] = "OSX",
        [Enum.Platform.IOS] = "iOS",
        [Enum.Platform.Android] = "Android",
        [Enum.Platform.XBoxOne] = "Xbox One (Console)",
        [Enum.Platform.PS4] = "PS4 (Console)",
        [Enum.Platform.XBox360] = "Xbox 360 (Console)",
        [Enum.Platform.WiiU] = "Wii-U (Console)",
        [Enum.Platform.NX] = "Cisco Nexus",
        [Enum.Platform.Ouya] = "Ouya (Android-Based)",
        [Enum.Platform.AndroidTV] = "Android TV",
        [Enum.Platform.Chromecast] = "Chromecast",
        [Enum.Platform.Linux] = "Linux (Desktop)",
        [Enum.Platform.SteamOS] = "Steam Client",
        [Enum.Platform.WebOS] = "Web-OS",
        [Enum.Platform.DOS] = "DOS",
        [Enum.Platform.BeOS] = "BeOS",
        [Enum.Platform.UWP] = "UWP (Go Back To Web Bro..)",
        [Enum.Platform.PS5] = "PS5 (Console)",
        [Enum.Platform.MetaOS] = "MetaOS",
        [Enum.Platform.None] = "Unknown Device"
    }
    return platform_map[platform] or "Unknown Device"
end

local device_platform = Device_Detector()
function Play_Notification_Sound()
    local Notification_Sound
    Notification_Sound = Instance.new("Sound")
    Notification_Sound.Parent = Workspace
    Notification_Sound.Volume = 1
    if device_platform == "Windows" then
        Notification_Sound.SoundId = Sound_ID_Windows
    elseif device_platform == "iOS" then
        Notification_Sound.SoundId = Sound_ID_iPhone
    elseif device_platform == "Android" then
        Notification_Sound.SoundId = Sound_ID_Android
    else
        Notification_Sound.SoundId = Sound_ID_Universal
    end
    task.wait()
    Notification_Sound:Play()
    Notification_Sound.Ended:Connect(function()
        Notification_Sound:Destroy()
    end)
end

function Notification_Wrapper:External_Notification(Type, Content, Time)
    if not Time then Time = 5 end
    wait()
    Play_Notification_Sound()
    NotificationLibrary_External.SendNotification(tostring(Type), tostring(Content), tonumber(Time))
end

local NotifyLib = Notification_Wrapper
local valid_titles = {
    success="Success", info="Info", warning="Warning", error="Error",
    succes="Success", sucess="Success", eror="Error", erorr="Error", warnin="Warning"
}

local function format_title(str)
    if typeof(str) ~= "string" then return "Info" end
    return valid_titles[str:lower()] or "Info"
end

getgenv().notify = function(title, msg, dur)
    if not getgenv().Notifications_Disabled_In_Flames_Hub then
        local fixed_title = format_title(typeof(title) == "string" and title or "Info")
        NotifyLib:External_Notification(fixed_title, tostring(msg), tonumber(dur) or 5)
    end
end

g.Characters = g.Characters or {}
if not getgenv().Initialized_Flames_All_Characters_Global_System then
    getgenv().Initialized_Flames_All_Characters_Global_System = true
    getgenv().wait_character = function(player)
        if player.Character and player.Character:IsDescendantOf(workspace) and player.Character:IsDescendantOf(game) then return player.Character end
        local char
        repeat
            char = player.Character
            hb()
        until char and char:IsDescendantOf(workspace) and char:IsDescendantOf(game) -- just incase lol.
        return char
    end

    getgenv().wait_instance = function(parent, resolver, timeout)
        timeout = timeout or Players.RespawnTime + 0.75
        if not parent or not parent:IsDescendantOf(game) then return nil end
        local start_time = os.clock()
        local inst
        local ok = pcall(function() inst = resolver() end)
        if ok and inst then return inst end
        local conn
        local success, _ = pcall(function() conn = parent.ChildAdded:Connect(function() pcall(function() inst = resolver() end) end) end)
        if not success then return nil end
        while not inst and os.clock() - start_time < timeout do
            if not parent or not parent:IsDescendantOf(game) then break end
            hb()
        end
        pcall(function() conn:Disconnect() end)
        return inst
    end

    getgenv().char_currently_building = getgenv().char_currently_building or {}
    local function build_entry(player, character)
        if getgenv().char_currently_building[player] then return end
        if not character or not character.Parent then return end
        getgenv().char_currently_building[player] = true
        local ok, err = pcall(function()
            local entry = g.Characters[player] or {}
            entry.character = character
            entry.humanoid = g.wait_instance(character, function()
                if not character.Parent then return nil end
                return character:FindFirstChildWhichIsA("Humanoid")
            end)
            entry.root = g.wait_instance(character, function()
                if not character.Parent then return nil end
                return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
            end)
            entry.head = g.wait_instance(character, function()
                if not character.Parent then return nil end
                return character:FindFirstChild("Head")
            end)
            if not character.Parent then return end
            g.Characters[player] = entry
        end)

        if not ok then warn("build_entry(): Failed for "..tostring(player.Name)..": "..tostring(err)) end
        getgenv().char_currently_building[player] = nil
    end

    local function hook_player(player)
        if player.Character and player.Character.Parent then task.spawn(function() build_entry(player, player.Character) end) end
        player.CharacterAdded:Connect(function(char)
            task.spawn(function()
                task.wait(Players.RespawnTime + 0.75)
                if char and char.Parent and char:IsDescendantOf(game or workspace) then build_entry(player, char) end
            end)
        end)
    end

    for _, player in ipairs(Players:GetPlayers()) do hook_player(player) end
    Players.PlayerAdded:Connect(hook_player)
    Players.PlayerRemoving:Connect(function(player)
        if g.Characters and g.Characters[player] then g.Characters[player] = nil end
        if getgenv().char_currently_building and getgenv().char_currently_building[player] then getgenv().char_currently_building[player] = nil end
    end)
end

local function wait_for_datamodel(inst)
    if not inst then return false end
    local start_time = os.clock()
    local timeout = Players.RespawnTime + 0.75
    while os.clock() - start_time < timeout do
        local ok, result = pcall(function()
            return inst.Parent and inst:IsDescendantOf(workspace) and inst:IsDescendantOf(game)
        end)
        if ok and result then return true end
        hb()
    end
    return false
end
wait(0.1)
g.get_or_set("wait_for_datamodel", wait_for_datamodel)
local function wait_for_child(parent, name, timeout)
    if not parent or not parent:IsDescendantOf(game) then return nil end
    local existing = parent:FindFirstChild(name)
    if existing then return existing end
    timeout = timeout or 10
    local start_time = os.clock()
    local result = nil
    while os.clock() - start_time < timeout do
        if not parent or not parent:IsDescendantOf(game) then break end
        local ok, found = pcall(function() return parent:FindFirstChild(name) end)
        if ok and found then
            result = found
            break
        end
        hb()
    end
    return result
end
wait(0.1)
g.get_or_set("wait_for_child", wait_for_child)
local function wait_for_descendant(parent, name, timeout)
    if not parent or not parent:IsDescendantOf(game) then return nil end
    local found = parent:FindFirstChild(name, true)
    if found then return found end
    timeout = timeout or 10
    local start_time = os.clock()
    local result = nil
    local conn
    pcall(function()
        conn = parent.DescendantAdded:Connect(function(d)
            if d.Name == name then
                result = d
            end
        end)
    end)
    while not result and os.clock() - start_time < timeout do
        if not parent or not parent:IsDescendantOf(game) then break end
        local ok, check = pcall(function() return parent:FindFirstChild(name, true) end)
        if ok and check then
            result = check
            break
        end
        hb()
    end
    pcall(function() if conn then conn:Disconnect() end end)
    return result
end
wait(0.1)
g.get_or_set("wait_for_descendant", wait_for_descendant)
local function wait_for_child_safe(parent, name, timeout)
    if not parent or not parent:IsDescendantOf(game) then return nil end
    local existing = parent:FindFirstChild(name)
    if existing then return existing end
    timeout = timeout or 10
    local start_time = os.clock()
    while os.clock() - start_time < timeout do
        if not parent or not parent:IsDescendantOf(game) then break end
        local ok, found = pcall(function() return parent:FindFirstChild(name) end)
        if ok and found then return found end
        hb()
    end
    return nil
end
g.get_or_set("wait_for_child_safe", wait_for_child_safe)

local function retry_find(func, retries, delay)
    for _ = 1, retries do
        local ok, result = pcall(func)
        if ok and result then return result end
        getgenv().FlamesLibrary.wait(delay)
    end
    return nil
end
g.get_or_set("retry_find", retry_find)

getgenv().return_char = function(player, timeout)
    if not player or not player:IsA("Player") then return nil end
    timeout = tonumber(timeout) or Players.RespawnTime + 1
    local start = os.clock()
    while os.clock() - start < timeout do
        local char = player.Character
        if char and char:IsDescendantOf(workspace) and char:IsDescendantOf(game) then
            local ok, hum = pcall(function() return char:FindFirstChildOfClass("Humanoid") end)
            if ok and hum and hum.Health > 0 then return char end
        end
        hb()
    end
    return nil
end

g.get_char = function(player, time_out)
    time_out = tonumber(time_out) or Players.RespawnTime + 1
    if not player or not player:IsA("Player") then return nil end
    local char = player.Character
    if char and char:IsDescendantOf(workspace) and char:IsDescendantOf(game) then return char end
    local start = os.clock()
    while os.clock() - start < time_out do
        char = player.Character
        if char and wait_for_datamodel(char) then return char end
        hb()
    end
    return nil
end

g.get_human = function(player, time_out)
    time_out = tonumber(time_out) or Players.RespawnTime + 1
    local char = g.get_char(player, time_out)
    if not char then return nil end
    local existing = char:FindFirstChildOfClass("Humanoid")
    if existing then return existing end
    return wait_for_child_safe(char, "Humanoid", time_out)
end

g.get_root = function(player, time_out)
    time_out = tonumber(time_out) or Players.RespawnTime + 1
    local char = g.get_char(player, time_out)
    if not char then return nil end
    local existing = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    if existing then return existing end
    return wait_for_child_safe(char, "HumanoidRootPart", time_out)
        or wait_for_child_safe(char, "UpperTorso", time_out)
        or wait_for_child_safe(char, "Torso", time_out)
end

g.get_head = function(player, time_out)
    time_out = tonumber(time_out) or Players.RespawnTime + 1
    local char = g.get_char(player, time_out)
    if not char then return nil end
    local existing = char:FindFirstChild("Head")
    if existing then return existing end
    return wait_for_child_safe(char, "Head", time_out)
end
wait(0.1)
getgenv().service_cache = getgenv().service_cache or {}
g.Service_Wrap = g.Service_Wrap or function(name)
    local cache = getgenv().service_cache
    if cache[name] then return cache[name] end
    local ok, svc = pcall(function() local s = game:GetService(name); return cloneref and cloneref(s) or s end)
    if not ok or not svc then return nil end
    if rawset then rawset(cache, name, svc) else cache[name] = svc end
    return svc
end

local tries = 0
local max_tries = 100
if not g.Service_Wrap then
    repeat
        task.wait()
        tries += 1
    until (g.Service_Wrap and typeof(g.Service_Wrap) == "function") or tries >= max_tries
end

local function init_services()
    if getgenv().__services_init then return end
    getgenv().__services_init = true
    for _, name in ipairs({
        "Players","Workspace","Lighting","ReplicatedStorage","TweenService","RunService",
        "MaterialService","ReplicatedFirst","Teams","StarterPack","StarterPlayer",
        "VoiceChatInternal","VoiceChatService","CoreGui","SoundService","StarterGui",
        "MarketplaceService","TeleportService","Chat","AssetService","HttpService",
        "UserInputService","TextChatService","ContextActionService","GuiService",
        "PhysicsService","ScriptContext", "AvatarEditorService"
    }) do
        if not getgenv()[name] then
            local ok, svc = pcall(getgenv().Service_Wrap, name)
            if ok and typeof(svc) == "Instance" then
                getgenv()[name] = svc
            end
        end
    end

    if Players and Players:IsA("Players") and Players:IsDescendantOf(game) then while not Players.LocalPlayer do task.wait() end; getgenv().LocalPlayer = Players.LocalPlayer end
    local sp = getgenv().StarterPlayer or cloneref and cloneref(game:GetService("StarterPlayer")) or game:GetService("StarterPlayer")
    if sp then getgenv().StarterPlayerScripts = sp:FindFirstChildOfClass("StarterPlayerScripts"); task.wait(); getgenv().StarterCharacterScripts = sp:FindFirstChildOfClass("StarterCharacterScripts") end
end
wait(0.1)
init_services()
getgenv().Character = g.get_char(LocalPlayer, Players.RespawnTime + 0.75) or getgenv().LocalPlayer.Character or Players.LocalPlayer.Character
getgenv().Humanoid = g.get_human(LocalPlayer, Players.RespawnTime + 0.75) or g.Character and (g.Character:FindFirstChild("Humanoid") or g.Character:FindFirstChildOfClass("Humanoid")) or g.Character and g.Character:WaitForChild("Humanoid", Players.RespawnTime + 0.75)
getgenv().HumanoidRootPart = g.get_root(LocalPlayer, Players.RespawnTime + 0.75) or g.Character and (g.Character:FindFirstChild("HumanoidRootPart") or g.Character and g.Character:WaitForChild("HumanoidRootPart", Players.RespawnTime + 0.75))
getgenv().Head = g.get_head(LocalPlayer, Players.RespawnTime + 0.75) or g.Character and (g.Character:FindFirstChild("Head") or g.Character and g.Character:WaitForChild("Head", Players.RespawnTime + 0.5))

g.findplr = function(args)
    local tbl = Players:GetPlayers()
    if args == "random" then
        local validPlayers = {}
        for _, v in pairs(tbl) do
            if v ~= LocalPlayer then
                table.insert(validPlayers, v)
            end
        end
        return #validPlayers > 0 and validPlayers[math.random(1, #validPlayers)] or nil
    end

    if args == "new" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.AccountAge < 30 and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "old" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.AccountAge > 30 and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "bacon" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v ~= LocalPlayer and g.get_char(v, Players.RespawnTime + 1) and (g.get_char(v, Players.RespawnTime + 1):FindFirstChild("Pal Hair") or g.get_char(v, Players.RespawnTime + 1):FindFirstChild("Kate Hair")) then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "friend" then
        local friendList = {}
        for _, v in pairs(tbl) do
            if v:IsFriendsWith(LocalPlayer.UserId) and v ~= LocalPlayer then
                table.insert(friendList, v)
            end
        end
        return #friendList > 0 and friendList[math.random(1, #friendList)] or nil
    end

    if args == "notfriend" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if not v:IsFriendsWith(LocalPlayer.UserId) and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "ally" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.Team == LocalPlayer.Team and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "enemy" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.Team ~= LocalPlayer.Team and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "near" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v ~= LocalPlayer then
                local vRootPart = g.get_root(v, 1)
                local cmdlpRootPart = g.HumanoidRootPart or g.get_root(LocalPlayer, Players.RespawnTime + 0.75)
                if vRootPart and cmdlpRootPart then
                    local distance = (vRootPart.Position - cmdlpRootPart.Position).magnitude
                    if distance < 30 then
                        table.insert(vAges, v)
                    end
                end
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "far" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v ~= LocalPlayer then
                local vRootPart = g.get_root(v, Players.RespawnTime + 1)
                local cmdlpRootPart = g.HumanoidRootPart or g.get_root(LocalPlayer, Players.RespawnTime + 1)
                if vRootPart and cmdlpRootPart then
                    local distance = (vRootPart.Position - cmdlpRootPart.Position).magnitude
                    if distance > 30 then
                        table.insert(vAges, v)
                    end
                end
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

	if typeof(args) ~= "string" or args == "" then return nil end
	for _, v in pairs(tbl) do
		local name, display = v.Name:lower(), v.DisplayName:lower()
		if name:find(args:lower()) or display:find(args:lower()) then
			if v == LocalPlayer then
				if g.notify and typeof(g.notify) == "function" then g.notify("Error", "You cannot target yourself!", 1) end
				return nil
			end
			return v
		end
	end

	return nil
end

g.Noclip_Enabled = g.Noclip_Enabled or false
g.Noclip_Connection = g.Noclip_Connection or nil
g.noclip_parts = g.noclip_parts or {}
local function refresh_parts()
    table.clear(g.noclip_parts)
    local Character = g.Character or LocalPlayer.Character or g.get_char(LocalPlayer, Players.RespawnTime + 1)
    if not Character or not Character:FindFirstChild("HumanoidRootPart") or not Character:IsDescendantOf(game or workspace) then return end
    for _, inst in ipairs(Character:GetDescendants()) do if inst:IsA("BasePart") then table.insert(g.noclip_parts, inst) end end
end

local function noclip_step()
    local parts = g.noclip_parts
    for i = 1, #parts do
        local p = parts[i]
        if p and p.Parent and p.CanCollide then p.CanCollide = false end
    end
end

g.ToggleNoclip = function(state)
	local lib = getgenv().FlamesLibrary
	local key = "noclip_stepped"

	if state == true then
		if g.Noclip_Enabled then
			g.notify("Warning", "Noclip is already enabled!", 5)
			return nil
		end

		if lib.is_alive(key) then lib.disconnect(key) end
		refresh_parts()
		lib.connect(key, RunService.Stepped:Connect(noclip_step))
		g.Noclip_Enabled = true
		g.notify("Success", "Noclip has been enabled.", 5)
		return nil
	elseif state == false then
		if not g.Noclip_Enabled then
			g.notify("Error", "Noclip is not enabled!", 5)
			return nil
		end

		lib.disconnect(key)
		for i = 1, #g.noclip_parts do
			local part = g.noclip_parts[i]
			if part and part.Parent then part.CanCollide = true end
		end

		table.clear(g.noclip_parts)
		g.Noclip_Enabled = false
		g.notify("Success", "Noclip has been disabled.", 5)
		return nil
	else
		g.notify("Error", "Invalid arg, expected true/false", 5)
		return nil
	end
end

g.randomString = g.randomString or function()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do array[i] = string.char(math.random(32, 126)) end
    return table.concat(array)
end

g.findplayerchild = g.findplayerchild or function(plr, target)
    if not plr or not target then return nil end
    target = tostring(target):lower()
    local class
    if target == "playergui" then
        class = "PlayerGui"
    elseif target == "playerscripts" then
        class = "PlayerScripts"
    elseif target == "backpack" then
        class = "Backpack"
    end

    local obj
    if class then
        obj = plr:FindFirstChildOfClass(class)
        if not obj then obj = plr:FindFirstChildWhichIsA(class) end
        if obj then return obj end
    else
        for _, c in ipairs(plr:GetChildren()) do if c.Name:lower() == target then return c end end
    end

    local conn
    conn = plr.ChildAdded:Connect(function(c)
        if class then
            if c:IsA(class) then
                obj = c
                conn:Disconnect()
            end
        else
            if c.Name:lower() == target then
                obj = c
                conn:Disconnect()
            end
        end
    end)

    while not obj do
        task.wait()
        if class then
            local a = plr:FindFirstChildOfClass(class)
            if not a then a = plr:FindFirstChildWhichIsA(class) end
            if a then
                obj = a
                conn:Disconnect()
                break
            end
        else
            for _, c in ipairs(plr:GetChildren()) do
                if c.Name:lower() == target then
                    obj = c
                    conn:Disconnect()
                    break
                end
            end
        end
    end

    return obj
end

g.findinstance = g.findinstance or function(class)
    class = tostring(class):lower()
    if class == "camera" and Workspace.CurrentCamera then return Workspace.CurrentCamera or workspace:FindFirstChildOfClass("Camera") end
    if class == "terrain" and Workspace.Terrain then return Workspace.Terrain end
    local canon = class:sub(1,1):upper() .. class:sub(2)
    local child = Workspace:FindFirstChild(canon)
    if child then return child end
    for _, obj in ipairs(Workspace:GetChildren()) do if obj.ClassName:lower() == class then return obj end end
    return nil
end

g.minigame_difficulty = {
    memory = "Medium",
    reaction = "Medium",
    keypad = "Medium",
    hacking = "Medium",
    safe = "Medium",
    wire = "Medium",
    simon = "Medium",
    morse = "Medium",
    frequency = "Medium",
    overload = "Medium",
    terminal = "Medium",
    decryption = "Medium",
    voltage = "Medium",
    shadow = "Medium",
    bank_drill = "Medium",
    fingerprint = "Medium",
    dead_drop = "Medium",
}

g.minigame_difficulty_presets = {
    memory = {
        Easy   = {show_time = 14, max_mistakes = 5, pattern_min = 4, pattern_max = 6},
        Medium = {show_time = 10, max_mistakes = 3, pattern_min = 6, pattern_max = 9},
        Hard   = {show_time = 6,  max_mistakes = 2, pattern_min = 9, pattern_max = 12},
    },
    reaction = {
        Easy   = {max_wins = 4, max_misses = 5, start_speed = 0.4, speed_step = 0.08, perfect_window = 0.03},
        Medium = {max_wins = 5, max_misses = 3, start_speed = 0.6, speed_step = 0.15, perfect_window = 0.02},
        Hard   = {max_wins = 7, max_misses = 2, start_speed = 0.9, speed_step = 0.22, perfect_window = 0.012},
    },
    keypad = {
        Easy   = {code_length = 3, max_attempts = 7},
        Medium = {code_length = 4, max_attempts = 5},
        Hard   = {code_length = 5, max_attempts = 4},
    },
    hacking = {
        Easy   = {sequence_length = 3, time_limit = 28, grid_cols = 6, grid_rows = 5},
        Medium = {sequence_length = 4, time_limit = 20, grid_cols = 8, grid_rows = 6},
        Hard   = {sequence_length = 6, time_limit = 14, grid_cols = 10, grid_rows = 7},
    },
    safe = {
        Easy   = {sequence_count = 2, time_limit = 40, dial_speed = 60, target_window = 2},
        Medium = {sequence_count = 3, time_limit = 30, dial_speed = 90, target_window = 1},
        Hard   = {sequence_count = 4, time_limit = 22, dial_speed = 130, target_window = 0.5},
    },
    wire = {
        Easy   = {wire_count = 4, time_limit = 32, clue_count = 3},
        Medium = {wire_count = 5, time_limit = 25, clue_count = 2},
        Hard   = {wire_count = 6, time_limit = 18, clue_count = 1},
    },
    simon = {
        Easy   = {rounds_to_win = 3, flash_duration = 0.5, gap_duration = 0.25},
        Medium = {rounds_to_win = 5, flash_duration = 0.4, gap_duration = 0.15},
        Hard   = {rounds_to_win = 8, flash_duration = 0.25, gap_duration = 0.08},
    },
    lockpick = {
        Easy   = {pin_count = 3, sweet_width = 26, tension_max = 140, tension_rate = 6, dial_speed = 70},
        Medium = {pin_count = 4, sweet_width = 18, tension_max = 120, tension_rate = 9, dial_speed = 100},
        Hard   = {pin_count = 5, sweet_width = 12, tension_max = 100, tension_rate = 13, dial_speed = 140},
    },
    laser = {
        Easy   = {row_count = 4, beam_speed = 1.0, hazard_margin = 0.10, time_limit = 35},
        Medium = {row_count = 6, beam_speed = 1.5, hazard_margin = 0.16, time_limit = 25},
        Hard   = {row_count = 8, beam_speed = 2.2, hazard_margin = 0.24, time_limit = 18},
    },
    signal = {
        Easy   = {tolerance = 8, time_limit = 35, drift_speed = 0},
        Medium = {tolerance = 5, time_limit = 25, drift_speed = 6},
        Hard   = {tolerance = 3, time_limit = 18, drift_speed = 12},
    },
    pipe = {
        Easy   = {grid_size = 3, locked_count = 1, time_limit = 40},
        Medium = {grid_size = 4, locked_count = 2, time_limit = 30},
        Hard   = {grid_size = 5, locked_count = 3, time_limit = 22},
    },
    steady = {
        Easy   = {drift_force = 40, zone_width = 0.30, hold_duration = 3, time_limit = 30},
        Medium = {drift_force = 70, zone_width = 0.20, hold_duration = 4, time_limit = 25},
        Hard   = {drift_force = 110, zone_width = 0.12, hold_duration = 5, time_limit = 20},
    },
    rhythm = {
        Easy   = {note_count = 10, note_speed = 220, hit_window = 0.14, max_misses = 4},
        Medium = {note_count = 14, note_speed = 300, hit_window = 0.10, max_misses = 3},
        Hard   = {note_count = 18, note_speed = 400, hit_window = 0.07, max_misses = 2},
    },
    recall = {
        Easy   = {card_count = 4, show_time = 0.8, grid_cols = 4},
        Medium = {card_count = 6, show_time = 0.6, grid_cols = 4},
        Hard   = {card_count = 8, show_time = 0.45, grid_cols = 4},
    },
    morse = {
        Easy   = {sequence_length = 4, dit_duration = 0.5, gap_duration = 0.3, time_limit = 40},
        Medium = {sequence_length = 6, dit_duration = 0.35, gap_duration = 0.2, time_limit = 30},
        Hard   = {sequence_length = 8, dit_duration = 0.22, gap_duration = 0.12, time_limit = 22},
    },
    frequency = {
        Easy   = {band_count = 3, drift_speed = 0.04, tolerance = 0.07, time_limit = 35},
        Medium = {band_count = 4, drift_speed = 0.09, tolerance = 0.05, time_limit = 25},
        Hard   = {band_count = 5, drift_speed = 0.16, tolerance = 0.03, time_limit = 18},
    },
    overload = {
        Easy   = {node_count = 4, surge_interval = 2.4, max_overloads = 3, time_limit = 40},
        Medium = {node_count = 6, surge_interval = 1.6, max_overloads = 2, time_limit = 30},
        Hard   = {node_count = 8, surge_interval = 1.0, max_overloads = 1, time_limit = 22},
    },
    terminal = {
        Easy   = {word_length = 4, max_attempts = 6, word_count = 6},
        Medium = {word_length = 5, max_attempts = 4, word_count = 8},
        Hard   = {word_length = 6, max_attempts = 3, word_count = 10},
    },
    decryption = {
        Easy   = {segments = 3, rot_speed = 40,  time_limit = 35, key_count = 2},
        Medium = {segments = 4, rot_speed = 65,  time_limit = 25, key_count = 3},
        Hard   = {segments = 5, rot_speed = 100, time_limit = 18, key_count = 4},
    },
    voltage = {
        Easy   = {step_count = 3, tolerance = 0.12, speed = 0.5,  time_limit = 40},
        Medium = {step_count = 5, tolerance = 0.07, speed = 0.85, time_limit = 28},
        Hard   = {step_count = 7, tolerance = 0.04, speed = 1.3,  time_limit = 20},
    },
    shadow = {
        Easy   = {shape_count = 4, display_time = 1.2, pool_size = 5},
        Medium = {shape_count = 6, display_time = 0.8, pool_size = 7},
        Hard   = {shape_count = 8, display_time = 0.5, pool_size = 9},
    },
    bank_drill = {
        Easy   = {heat_zones = 3, overheat_rate = 8,  cooldown_rate = 12, sweet_zone = 0.28, time_limit = 45},
        Medium = {heat_zones = 5, overheat_rate = 14, cooldown_rate = 9,  sweet_zone = 0.18, time_limit = 32},
        Hard   = {heat_zones = 7, overheat_rate = 22, cooldown_rate = 6,  sweet_zone = 0.10, time_limit = 22},
    },
    fingerprint = {
        Easy   = {layers = 1, drift_speed = 0,    tolerance = 0.08, time_limit = 40},
        Medium = {layers = 2, drift_speed = 0.012, tolerance = 0.05, time_limit = 28},
        Hard   = {layers = 2, drift_speed = 0.025, tolerance = 0.03, time_limit = 18},
    },
    dead_drop = {
        Easy   = {grid_cols = 2, grid_rows = 2, hop_interval = 3.5, max_misses = 4, signal_duration = 1.2, decoys = false},
        Medium = {grid_cols = 3, grid_rows = 2, hop_interval = 2.4, max_misses = 3, signal_duration = 0.8, decoys = false},
        Hard   = {grid_cols = 3, grid_rows = 3, hop_interval = 1.6, max_misses = 2, signal_duration = 0.5, decoys = true},
    },
}

g.minigame_reward_multiplier = {Easy = 0.7, Medium = 1, Hard = 1.5}
local DIFFICULTY_ORDER = {"Easy", "Medium", "Hard"}
local DIFFICULTY_COLOR = {
    Easy = Color3.fromRGB(60, 180, 100),
    Medium = Color3.fromRGB(220, 160, 30),
    Hard = Color3.fromRGB(200, 70, 70),
}

local function get_preset(game_key)
    local difficulty = g.minigame_difficulty[game_key] or "Medium"
    local presets = g.minigame_difficulty_presets[game_key]
    return presets[difficulty] or presets.Medium, difficulty
end

g.Memory_Mini_Game_GUI = function()
    local preset = get_preset("memory")
    local GRID_SIZE = 5
    local TILE_COUNT = GRID_SIZE * GRID_SIZE
    local SHOW_TIME = preset.show_time
    local MAX_MISTAKES = preset.max_mistakes
    local GREEN = Color3.fromRGB(0, 255, 0)
    local BLUE = Color3.fromRGB(30, 70, 120)
    local DARK = Color3.fromRGB(20, 20, 20)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED = Color3.fromRGB(150, 0, 0)
    if g.memory_mini_game_cooldown and tick() - g.memory_mini_game_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.memory_mini_game_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end
    
    if CoreGui:FindFirstChild("MemoryMinigameGUI") then CoreGui.MemoryMinigameGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "MemoryMinigameGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.Size = UDim2.fromScale(0.85, 0.85)
    frame.BackgroundColor3 = DARK
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

    local aspect = Instance.new("UIAspectRatioConstraint")
    aspect.AspectRatio = 1
    aspect.Parent = frame

    local size_limit = Instance.new("UISizeConstraint")
    size_limit.MaxSize = Vector2.new(520, 520)
    size_limit.Parent = frame

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0.08, 0)
    padding.PaddingBottom = UDim.new(0.04, 0)
    padding.PaddingLeft = UDim.new(0.04, 0)
    padding.PaddingRight = UDim.new(0.04, 0)
    padding.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.fromScale(0.18, 0.08)
    cancel.Position = UDim2.fromScale(0.99, 0.02)
    cancel.AnchorPoint = Vector2.new(1, 0)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "Cancel"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 12)

    local grid_frame = Instance.new("Frame")
    grid_frame.BackgroundTransparency = 1
    grid_frame.Size = UDim2.fromScale(1, 0.88)
    grid_frame.Position = UDim2.fromScale(0, 0.12)
    grid_frame.Parent = frame

    local grid = Instance.new("UIGridLayout")
    grid.CellPadding = UDim2.fromScale(0.03, 0.03)
    grid.CellSize = UDim2.fromScale(1 / GRID_SIZE - 0.03, 1 / GRID_SIZE - 0.03)
    grid.Parent = grid_frame

    local tiles = {}
    local pattern = {}
    local found = {}
    local mistakes = 0
    local input_locked = true
    local function cleanup() getgenv().Keybind_Input_Disabled_For_Mini_Game = false; if gui then gui:Destroy() end end
    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Mini-game cancelled.", 3) end
        cleanup()
    end)

    for i = 1, TILE_COUNT do
        local btn = Instance.new("TextButton")
        btn.Text = ""
        btn.BackgroundColor3 = BLUE
        btn.AutoButtonColor = false
        btn.Parent = grid_frame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
        tiles[i] = btn
    end

    local function generate_pattern()
        local count = math.random(preset.pattern_min, preset.pattern_max)
        local used = {}
        while #pattern < count do
            local pick = math.random(1, TILE_COUNT)
            if not used[pick] then
                used[pick] = true
                table.insert(pattern, pick)
            end
        end
    end

    local function check_win()
        for _, index in ipairs(pattern) do if not found[index] then return end end
        task.delay(0.02, function()
            g.memory_mini_game_cooldown = tick()
            if g.notify then g.notify("Success", "You completed the memory mini-game.", 5) end
            cleanup()
        end)
    end

    local function show_pattern() for _, index in ipairs(pattern) do tiles[index].BackgroundColor3 = GREEN end end
    local function hide_pattern()
        for i, btn in ipairs(tiles) do
            if not found[i] then
                btn.BackgroundColor3 = BLUE
            end
        end
        input_locked = false
    end

    local function fail()
        if g.notify then g.notify("Error", "You failed the memory mini-game.", 5) end
        cleanup()
    end

    local function on_tile_clicked(index)
        if input_locked then return end
        if found[index] then return end
        if table.find(pattern, index) then
            found[index] = true
            tiles[index].BackgroundColor3 = GREEN
            check_win()
        else
            mistakes = mistakes + 1
            tiles[index].BackgroundColor3 = RED
            if mistakes >= MAX_MISTAKES then
                fail()
            end
        end
    end

    for i, btn in ipairs(tiles) do
        btn.MouseButton1Click:Connect(function()
            on_tile_clicked(i)
        end)
    end

    generate_pattern()
    show_pattern()
    task.delay(SHOW_TIME, hide_pattern)
end

g.reaction_time_minigame = function()
    g.timing_game = g.timing_game or {}
    local tg = g.timing_game
    if tg.renderConn then tg.renderConn:Disconnect() end
    if tg.gui then tg.gui:Destroy() end
    if g.reaction_minigame_cooldown and tick() - g.reaction_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.reaction_minigame_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("reaction")
    local MAX_WINS = preset.max_wins
    local MAX_MISSES = preset.max_misses
    local PURPLE = Color3.fromRGB(170, 85, 255)
    local DARK = Color3.fromRGB(18, 18, 18)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED = Color3.fromRGB(200, 60, 60)
    tg.wins = 0
    tg.misses = 0
    tg.speed = preset.start_speed

    local gui = Instance.new("ScreenGui")
    gui.Name = "ReactionTimeMinigame"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui
    tg.gui = gui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(0.9, 0.32)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

    local ui_scale = Instance.new("UIScale")
    ui_scale.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.fromScale(0.9, 0.25)
    bar.Position = UDim2.fromScale(0.05, 0.55)
    bar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    bar.Parent = frame
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 14)

    local target = Instance.new("Frame")
    target.Size = UDim2.fromScale(0.12, 1)
    target.BackgroundColor3 = PURPLE
    target.Parent = bar
    Instance.new("UICorner", target).CornerRadius = UDim.new(0, 12)

    local arrow = Instance.new("Frame")
    arrow.Size = UDim2.fromScale(0.05, 1)
    arrow.BackgroundColor3 = WHITE
    arrow.Parent = bar
    Instance.new("UICorner", arrow).CornerRadius = UDim.new(0, 10)

    local feedback = Instance.new("TextLabel")
    feedback.Size = UDim2.fromScale(1, 0.25)
    feedback.Position = UDim2.fromScale(0, 0)
    feedback.BackgroundTransparency = 1
    feedback.TextScaled = true
    feedback.Font = Enum.Font.GothamBold
    feedback.TextColor3 = WHITE
    feedback.Text = "CLICK!"
    feedback.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0.0399999991, 0, 0.219999999, 0)
    cancel.Position = UDim2.new(1, 0, 0.00100000005, 0)
    cancel.AnchorPoint = Vector2.new(1, 0)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 12)

    local function flash(text, color)
        feedback.Text = text
        feedback.TextColor3 = color
        task.delay(0.35, function()
            if tg.wins < MAX_WINS and tg.misses < MAX_MISSES then
                feedback.Text = "CLICK!"
                feedback.TextColor3 = WHITE
            end
        end)
    end

    local function cleanup()
        if tg.renderConn then tg.renderConn:Disconnect() end
        if tg.gui then tg.gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        g.reaction_minigame_cooldown = tick()
        if g.notify then
            g.notify("Success", "You've won the mini-game.", 5)
        end
        task.delay(0.1, cleanup)
    end

    local function fail(msg)
        if g.notify then
            g.notify("Error", msg or "You failed the mini-game.", 5)
        end
        task.delay(0.1, cleanup)
    end

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Mini-game cancelled.", 3) end
        cleanup()
    end)

    local function new_target()
        target.Position = UDim2.fromScale(math.random(10, 78) / 100, 0)
    end

    new_target()

    local dir = 1
    local pos = 0
    tg.renderConn = RunService.RenderStepped:Connect(function(dt)
        pos = pos + dt * tg.speed * dir
        if pos >= 0.95 then dir = -1 end
        if pos <= 0 then dir = 1 end
        arrow.Position = UDim2.fromScale(pos, 0)
    end)

    local click = Instance.new("TextButton")
    click.Size = UDim2.fromScale(1, 1)
    click.Position = UDim2.fromScale(0, 0)
    click.BackgroundTransparency = 1
    click.Text = ""
    click.Parent = frame

    click.MouseButton1Click:Connect(function()
        local a_min = arrow.Position.X.Scale
        local a_max = a_min + arrow.Size.X.Scale
        local t_min = target.Position.X.Scale
        local t_max = t_min + target.Size.X.Scale
        local overlap = math.min(a_max, t_max) - math.max(a_min, t_min)

        if overlap > 0 then
            local center_dist = math.abs((a_min + a_max) / 2 - (t_min + t_max) / 2)
            if center_dist < preset.perfect_window then
                flash("PERFECT", Color3.fromRGB(180, 255, 255))
            else
                flash("GOOD", PURPLE)
            end
            tg.wins = tg.wins + 1
            tg.speed = tg.speed + preset.speed_step
            new_target()
            if tg.wins >= MAX_WINS then
                win()
            end
        else
            tg.misses = tg.misses + 1
            flash("BAD", RED)
            if tg.misses >= MAX_MISSES then
                fail()
            end
        end
    end)
end

g.keypad_minigame = function()
    if g.keypad_minigame_cooldown and tick() - g.keypad_minigame_cooldown < 25 then
        local remaining = math.ceil(25 - (tick() - g.keypad_minigame_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("keypad")
    local DARK = Color3.fromRGB(18, 18, 18)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local GREEN = Color3.fromRGB(0, 220, 100)
    local RED = Color3.fromRGB(200, 60, 60)
    local YELLOW = Color3.fromRGB(255, 200, 0)
    local GREY = Color3.fromRGB(40, 40, 40)
    local CODE_LENGTH = preset.code_length
    local MAX_ATTEMPTS = preset.max_attempts
    local secret_code = {}
    local current_input = {}
    local attempts = 0
    local game_over = false
    for i = 1, CODE_LENGTH do table.insert(secret_code, math.random(0, 9)) end
    if CoreGui:FindFirstChild("KeypadMinigame") then CoreGui.KeypadMinigame:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "KeypadMinigame"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 420)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(60, 60, 60)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "KEYPAD HACK"
    title.TextColor3 = YELLOW
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = frame

    local attempts_label = Instance.new("TextLabel")
    attempts_label.Size = UDim2.new(1, 0, 0, 24)
    attempts_label.Position = UDim2.new(0, 0, 0, 48)
    attempts_label.BackgroundTransparency = 1
    attempts_label.Text = "Attempts: " .. MAX_ATTEMPTS
    attempts_label.TextColor3 = WHITE
    attempts_label.Font = Enum.Font.Gotham
    attempts_label.TextSize = 13
    attempts_label.Parent = frame

    local display = Instance.new("Frame")
    display.Size = UDim2.new(0.8, 0, 0, 50)
    display.Position = UDim2.new(0.1, 0, 0, 78)
    display.BackgroundColor3 = GREY
    display.Parent = frame
    Instance.new("UICorner", display).CornerRadius = UDim.new(0, 10)

    local display_label = Instance.new("TextLabel")
    display_label.Size = UDim2.new(1, 0, 1, 0)
    display_label.BackgroundTransparency = 1
    display_label.Text = string.rep("_ ", CODE_LENGTH):sub(1, -2)
    display_label.TextColor3 = GREEN
    display_label.Font = Enum.Font.Code
    display_label.TextSize = 24
    display_label.Parent = display

    local feedback_label = Instance.new("TextLabel")
    feedback_label.Size = UDim2.new(1, 0, 0, 24)
    feedback_label.Position = UDim2.new(0, 0, 0, 134)
    feedback_label.BackgroundTransparency = 1
    feedback_label.Text = ""
    feedback_label.TextColor3 = WHITE
    feedback_label.Font = Enum.Font.Gotham
    feedback_label.TextSize = 12
    feedback_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 6)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)
    local function cleanup() getgenv().Keybind_Input_Disabled_For_Mini_Game = false; if gui then gui:Destroy() end end
    local function update_display()
        local parts = {}
        for i = 1, CODE_LENGTH do
            if current_input[i] then
                table.insert(parts, tostring(current_input[i]))
            else
                table.insert(parts, "_")
            end
        end
        display_label.Text = table.concat(parts, " ")
    end

    local function get_feedback(guess)
        local correct_pos = 0
        local correct_num = 0
        local secret_used = {}
        local guess_used = {}

        for i = 1, CODE_LENGTH do
            if guess[i] == secret_code[i] then
                correct_pos = correct_pos + 1
                secret_used[i] = true
                guess_used[i] = true
            end
        end

        for i = 1, CODE_LENGTH do
            if not guess_used[i] then
                for j = 1, CODE_LENGTH do
                    if not secret_used[j] and guess[i] == secret_code[j] then
                        correct_num = correct_num + 1
                        secret_used[j] = true
                        break
                    end
                end
            end
        end
        return correct_pos, correct_num
    end

    local function win()
        g.keypad_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Keypad cracked!.", 30) end
        task.delay(0.5, cleanup)
    end

    local function fail()
        if g.notify then g.notify("Error", "Keypad locked out!.", 5) end
        task.delay(0.5, cleanup)
    end

    local function submit()
        if #current_input < CODE_LENGTH then return end
        if game_over then return end
        local correct_pos, correct_num = get_feedback(current_input)
        if correct_pos == CODE_LENGTH then
            game_over = true
            display_label.TextColor3 = GREEN
            feedback_label.Text = "ACCESS GRANTED"
            feedback_label.TextColor3 = GREEN
            win()
            return
        end

        attempts = attempts + 1
        attempts_label.Text = "Attempts: " .. (MAX_ATTEMPTS - attempts)
        feedback_label.Text = correct_pos .. " correct position  |  " .. correct_num .. " correct number"
        feedback_label.TextColor3 = YELLOW
        current_input = {}
        update_display()

        if attempts >= MAX_ATTEMPTS then
            game_over = true
            display_label.TextColor3 = RED
            feedback_label.Text = "ACCESS DENIED"
            feedback_label.TextColor3 = RED
            fail()
        end
    end

    local button_grid = Instance.new("Frame")
    button_grid.Size = UDim2.new(0.85, 0, 0, 220)
    button_grid.Position = UDim2.new(0.075, 0, 0, 165)
    button_grid.BackgroundTransparency = 1
    button_grid.Parent = frame

    local grid_layout = Instance.new("UIGridLayout")
    grid_layout.CellSize = UDim2.new(0.3, 0, 0, 52)
    grid_layout.CellPadding = UDim2.new(0.033, 0, 0, 6)
    grid_layout.SortOrder = Enum.SortOrder.LayoutOrder
    grid_layout.Parent = button_grid

    local button_order = {7, 8, 9, 4, 5, 6, 1, 2, 3}
    for _, num in ipairs(button_order) do
        local btn = Instance.new("TextButton")
        btn.Text = tostring(num)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 20
        btn.TextColor3 = WHITE
        btn.BackgroundColor3 = GREY
        btn.LayoutOrder = num
        btn.Parent = button_grid
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

        btn.MouseButton1Click:Connect(function()
            if game_over then return end
            if #current_input >= CODE_LENGTH then return end
            table.insert(current_input, num)
            update_display()
            if #current_input == CODE_LENGTH then
                task.delay(0.1, submit)
            end
        end)
    end

    local zero_btn = Instance.new("TextButton")
    zero_btn.Text = "0"
    zero_btn.Font = Enum.Font.GothamBold
    zero_btn.TextSize = 20
    zero_btn.TextColor3 = WHITE
    zero_btn.BackgroundColor3 = GREY
    zero_btn.LayoutOrder = 10
    zero_btn.Parent = button_grid
    Instance.new("UICorner", zero_btn).CornerRadius = UDim.new(0, 10)

    zero_btn.MouseButton1Click:Connect(function()
        if game_over then return end
        if #current_input >= CODE_LENGTH then return end
        table.insert(current_input, 0)
        update_display()
        if #current_input == CODE_LENGTH then
            task.delay(0.1, submit)
        end
    end)

    local clear_btn = Instance.new("TextButton")
    clear_btn.Text = "CLR"
    clear_btn.Font = Enum.Font.GothamBold
    clear_btn.TextSize = 14
    clear_btn.TextColor3 = WHITE
    clear_btn.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
    clear_btn.LayoutOrder = 11
    clear_btn.Parent = button_grid
    Instance.new("UICorner", clear_btn).CornerRadius = UDim.new(0, 10)

    clear_btn.MouseButton1Click:Connect(function()
        if game_over then return end
        current_input = {}
        update_display()
        feedback_label.Text = ""
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Keypad cancelled.", 3) end
        cleanup()
    end)

    update_display()
end

g.hacking_minigame = function()
    if g.hacking_minigame_cooldown and tick() - g.hacking_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.hacking_minigame_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("hacking")
    local DARK = Color3.fromRGB(10, 10, 10)
    local GREEN = Color3.fromRGB(0, 255, 100)
    local DIM_GREEN = Color3.fromRGB(0, 100, 40)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED = Color3.fromRGB(200, 60, 60)
    local YELLOW = Color3.fromRGB(255, 200, 0)
    local GRID_COLS = preset.grid_cols
    local GRID_ROWS = preset.grid_rows
    local SEQUENCE_LENGTH = preset.sequence_length
    local TIME_LIMIT = preset.time_limit
    local chars = {"A","B","C","D","E","F","1","2","3","4","5","6","7","8","9","0"}
    local grid_data = {}
    local target_sequence = {}
    local current_sequence = {}
    local selected_col = nil
    local select_row = true
    local game_over = false
    local time_left = TIME_LIMIT
    local render_conn = nil
    local timer_conn = nil
    for row = 1, GRID_ROWS do
        grid_data[row] = {}
        for col = 1, GRID_COLS do grid_data[row][col] = chars[math.random(1, #chars)] end
    end

    local start_col = math.random(1, GRID_COLS)
    local cur_col = start_col
    local picking_col = true
    local cur_row = nil

    for i = 1, SEQUENCE_LENGTH do
        if picking_col then
            cur_row = math.random(1, GRID_ROWS)
            table.insert(target_sequence, grid_data[cur_row][cur_col])
            picking_col = false
        else
            cur_col = math.random(1, GRID_COLS)
            table.insert(target_sequence, grid_data[cur_row][cur_col])
            picking_col = true
        end
    end

    if CoreGui:FindFirstChild("HackingMinigame") then CoreGui.HackingMinigame:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "HackingMinigame"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, math.max(420, GRID_COLS * 62 + 20), 0, GRID_ROWS * 44 + 130)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = GREEN
    stroke.Thickness = 1.5

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.6, 0, 0, 36)
    title.Position = UDim2.new(0, 10, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// BREACH PROTOCOL //"
    title.TextColor3 = GREEN
    title.Font = Enum.Font.Code
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.3, 0, 0, 36)
    timer_label.Position = UDim2.new(0.65, -40, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = YELLOW
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 16
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 6)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local seq_label = Instance.new("TextLabel")
    seq_label.Size = UDim2.new(1, -20, 0, 22)
    seq_label.Position = UDim2.new(0, 10, 0, 44)
    seq_label.BackgroundTransparency = 1
    seq_label.Text = "TARGET: " .. table.concat(target_sequence, "  ")
    seq_label.TextColor3 = YELLOW
    seq_label.Font = Enum.Font.Code
    seq_label.TextSize = 14
    seq_label.TextXAlignment = Enum.TextXAlignment.Left
    seq_label.Parent = frame

    local progress_label = Instance.new("TextLabel")
    progress_label.Size = UDim2.new(1, -20, 0, 22)
    progress_label.Position = UDim2.new(0, 10, 0, 64)
    progress_label.BackgroundTransparency = 1
    progress_label.Text = "INPUT:  "
    progress_label.TextColor3 = GREEN
    progress_label.Font = Enum.Font.Code
    progress_label.TextSize = 14
    progress_label.TextXAlignment = Enum.TextXAlignment.Left
    progress_label.Parent = frame

    local hint_label = Instance.new("TextLabel")
    hint_label.Size = UDim2.new(1, -20, 0, 18)
    hint_label.Position = UDim2.new(0, 10, 0, 86)
    hint_label.BackgroundTransparency = 1
    hint_label.Text = "Select from highlighted column"
    hint_label.TextColor3 = DIM_GREEN
    hint_label.Font = Enum.Font.Code
    hint_label.TextSize = 11
    hint_label.TextXAlignment = Enum.TextXAlignment.Left
    hint_label.Parent = frame

    local grid_frame = Instance.new("Frame")
    grid_frame.Size = UDim2.new(1, -20, 0, GRID_ROWS * 46)
    grid_frame.Position = UDim2.new(0, 10, 0, 112)
    grid_frame.BackgroundTransparency = 1
    grid_frame.Parent = frame

    local cell_buttons = {}
    local function cleanup()
        if render_conn then render_conn:Disconnect() end
        if timer_conn then timer_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function update_progress()
        local parts = {}
        for _, v in ipairs(current_sequence) do table.insert(parts, v) end
        progress_label.Text = "INPUT:  " .. table.concat(parts, "  ")
    end

    local function win()
        game_over = true
        g.hacking_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Breach successful!.", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Breach failed!", 5) end
        task.delay(0.5, cleanup)
    end

    local function check_sequence()
        if #current_sequence < SEQUENCE_LENGTH then return end
        for i = 1, SEQUENCE_LENGTH do
            if current_sequence[i] ~= target_sequence[i] then
                fail("Wrong sequence!")
                return
            end
        end
        win()
    end

    local function highlight_cells()
        for row = 1, GRID_ROWS do
            for col = 1, GRID_COLS do
                local btn = cell_buttons[row] and cell_buttons[row][col]
                if not btn then continue end
                if select_row then
                    if selected_col and col == selected_col then
                        btn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
                        btn.TextColor3 = GREEN
                    else
                        btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                        btn.TextColor3 = DIM_GREEN
                    end
                else
                    if selected_col and row == selected_col then
                        btn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
                        btn.TextColor3 = GREEN
                    else
                        btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                        btn.TextColor3 = DIM_GREEN
                    end
                end
            end
        end
        if select_row then
            hint_label.Text = "Select from highlighted COLUMN " .. (selected_col or "?")
        else
            hint_label.Text = "Select from highlighted ROW " .. (selected_col or "?")
        end
    end

    for row = 1, GRID_ROWS do
        cell_buttons[row] = {}
        for col = 1, GRID_COLS do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 56, 0, 38)
            btn.Position = UDim2.new(0, (col - 1) * 62, 0, (row - 1) * 44)
            btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            btn.TextColor3 = DIM_GREEN
            btn.Font = Enum.Font.Code
            btn.TextSize = 16
            btn.Text = grid_data[row][col]
            btn.Parent = grid_frame
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            cell_buttons[row][col] = btn
            btn.MouseButton1Click:Connect(function()
                if game_over then return end
                local valid = false
                if select_row and selected_col and col == selected_col then
                    valid = true
                elseif not select_row and selected_col and row == selected_col then
                    valid = true
                elseif selected_col == nil then
                    valid = true
                end

                if not valid then return end
                table.insert(current_sequence, grid_data[row][col])
                update_progress()
                if select_row then
                    selected_col = row
                    select_row = false
                else
                    selected_col = col
                    select_row = true
                end

                highlight_cells()
                check_sequence()
            end)
        end
    end

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Hack cancelled.", 3) end
        cleanup()
    end)

    selected_col = start_col
    highlight_cells()
    update_progress()
    local elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        elapsed = elapsed + dt
        time_left = TIME_LIMIT - elapsed
        if time_left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up! -5 coins.")
            return
        end
        local mins = math.floor(time_left / 60)
        local secs = math.floor(time_left % 60)
        timer_label.Text = string.format("%02d:%02d", mins, secs)
        if time_left <= 5 then timer_label.TextColor3 = RED end
    end)
end

g.safe_cracker_minigame = function()
    if g.safe_cracker_cooldown and tick() - g.safe_cracker_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.safe_cracker_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("safe")
    local DARK = Color3.fromRGB(12, 10, 8)
    local GOLD = Color3.fromRGB(200, 160, 40)
    local DIM_GOLD = Color3.fromRGB(80, 60, 10)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED = Color3.fromRGB(200, 60, 60)
    local GREEN = Color3.fromRGB(60, 200, 100)
    local SEQUENCE_COUNT = preset.sequence_count
    local NOTCH_COUNT = 20
    local TIME_LIMIT = preset.time_limit
    local TARGET_WINDOW = preset.target_window
    local targets = {}
    for i = 1, SEQUENCE_COUNT do table.insert(targets, math.random(1, NOTCH_COUNT)) end
    local current_step = 1
    local dial_angle = 0
    local dial_speed = preset.dial_speed
    local spin_dir = 1
    local game_over = false
    local timer_conn = nil
    local render_conn = nil
    if CoreGui:FindFirstChild("SafeCrackerGUI") then CoreGui.SafeCrackerGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "SafeCrackerGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, 440)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = GOLD
    fstroke.Thickness = 1.5

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// SAFE CRACKER //"
    title.TextColor3 = GOLD
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.25, -40, 0, 36)
    timer_label.Position = UDim2.new(0.65, -10, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = GOLD
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local step_label = Instance.new("TextLabel")
    step_label.Size = UDim2.new(1, -20, 0, 22)
    step_label.Position = UDim2.new(0, 10, 0, 42)
    step_label.BackgroundTransparency = 1
    step_label.Text = "Step 1 of " .. SEQUENCE_COUNT .. "  —  Target: " .. targets[1]
    step_label.TextColor3 = GOLD
    step_label.Font = Enum.Font.Code
    step_label.TextSize = 13
    step_label.TextXAlignment = Enum.TextXAlignment.Left
    step_label.Parent = frame

    local hint_label = Instance.new("TextLabel")
    hint_label.Size = UDim2.new(1, -20, 0, 18)
    hint_label.Position = UDim2.new(0, 10, 0, 64)
    hint_label.BackgroundTransparency = 1
    hint_label.Text = "Click when the marker lands on the target notch"
    hint_label.TextColor3 = DIM_GOLD
    hint_label.Font = Enum.Font.Code
    hint_label.TextSize = 11
    hint_label.TextXAlignment = Enum.TextXAlignment.Left
    hint_label.Parent = frame

    local dial_holder = Instance.new("Frame")
    dial_holder.Size = UDim2.new(0, 240, 0, 240)
    dial_holder.AnchorPoint = Vector2.new(0.5, 0)
    dial_holder.Position = UDim2.new(0.5, 0, 0, 96)
    dial_holder.BackgroundTransparency = 1
    dial_holder.Parent = frame

    local dial_bg = Instance.new("Frame")
    dial_bg.Size = UDim2.fromScale(1, 1)
    dial_bg.BackgroundColor3 = Color3.fromRGB(28, 24, 16)
    dial_bg.BorderSizePixel = 0
    dial_bg.Parent = dial_holder
    Instance.new("UICorner", dial_bg).CornerRadius = UDim.new(0.5, 0)
    local dstroke = Instance.new("UIStroke", dial_bg)
    dstroke.Color = GOLD
    dstroke.Thickness = 2

    local notch_labels = {}
    for i = 1, NOTCH_COUNT do
        local angle = (i - 1) * (360 / NOTCH_COUNT)
        local rad = math.rad(angle - 90)
        local nx = 0.5 + math.cos(rad) * 0.42
        local ny = 0.5 + math.sin(rad) * 0.42
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 22, 0, 18)
        lbl.AnchorPoint = Vector2.new(0.5, 0.5)
        lbl.Position = UDim2.new(nx, 0, ny, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = tostring(i)
        lbl.Font = Enum.Font.Code
        lbl.TextSize = 10
        lbl.TextColor3 = DIM_GOLD
        lbl.Parent = dial_holder
        notch_labels[i] = lbl
    end

    local marker = Instance.new("Frame")
    marker.Size = UDim2.new(0, 6, 0, 30)
    marker.AnchorPoint = Vector2.new(0.5, 1)
    marker.Position = UDim2.new(0.5, 0, 0.08, 0)
    marker.BackgroundColor3 = WHITE
    marker.BorderSizePixel = 0
    marker.Parent = dial_holder
    Instance.new("UICorner", marker).CornerRadius = UDim.new(0, 3)

    local click_btn = Instance.new("TextButton")
    click_btn.Size = UDim2.new(0, 120, 0, 42)
    click_btn.AnchorPoint = Vector2.new(0.5, 0)
    click_btn.Position = UDim2.new(0.5, 0, 0, 354)
    click_btn.BackgroundColor3 = Color3.fromRGB(38, 30, 10)
    click_btn.Text = "CRACK"
    click_btn.Font = Enum.Font.GothamBold
    click_btn.TextSize = 15
    click_btn.TextColor3 = GOLD
    click_btn.BorderSizePixel = 0
    click_btn.Parent = frame
    Instance.new("UICorner", click_btn).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", click_btn).Color = GOLD

    local feedback = Instance.new("TextLabel")
    feedback.Size = UDim2.new(1, -20, 0, 22)
    feedback.Position = UDim2.new(0, 10, 0, 406)
    feedback.BackgroundTransparency = 1
    feedback.Text = ""
    feedback.TextColor3 = GREEN
    feedback.Font = Enum.Font.Code
    feedback.TextSize = 13
    feedback.TextXAlignment = Enum.TextXAlignment.Center
    feedback.Parent = frame

    local function cleanup()
        if render_conn then render_conn:Disconnect() end
        if timer_conn then timer_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function get_current_notch()
        local normalized = dial_angle % 360
        local notch = math.round(normalized / (360 / NOTCH_COUNT)) % NOTCH_COUNT
        if notch == 0 then notch = NOTCH_COUNT end
        return notch
    end

    local function update_notch_colors()
        local cur = get_current_notch()
        local tgt = targets[current_step]
        for i, lbl in ipairs(notch_labels) do
            if i == tgt then
                lbl.TextColor3 = GOLD
            elseif i == cur then
                lbl.TextColor3 = WHITE
            else
                lbl.TextColor3 = DIM_GOLD
            end
        end
    end

    local function win()
        game_over = true
        g.safe_cracker_cooldown = tick()
        if g.notify then g.notify("Success", "Safe cracked!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Safe locked!", 5) end
        task.delay(0.5, cleanup)
    end

    click_btn.MouseButton1Click:Connect(function()
        if game_over then return end
        local cur = get_current_notch()
        local tgt = targets[current_step]
        local diff = math.abs(cur - tgt)
        local within = diff <= TARGET_WINDOW or diff >= NOTCH_COUNT - TARGET_WINDOW
        if within then
            feedback.Text = "Notch: " .. tgt .. " hit!"
            feedback.TextColor3 = GREEN
            current_step = current_step + 1
            spin_dir = spin_dir * -1
            dial_speed = dial_speed + 20

            if current_step > SEQUENCE_COUNT then
                win()
            else
                step_label.Text = "Step " .. current_step .. " of " .. SEQUENCE_COUNT .. "  —  Target: " .. targets[current_step]
            end
        else
            feedback.Text = "✗ Missed! Got notch: " .. cur
            feedback.TextColor3 = RED
            fail("Wrong notch! -5 coins.")
        end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Safe cracker cancelled.", 3) end
        cleanup()
    end)

    render_conn = RunService.RenderStepped:Connect(function(dt)
        if game_over then return end
        dial_angle = dial_angle + dial_speed * dt * spin_dir
        update_notch_colors()
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up! -5 coins.")
            return
        end
        local mins = math.floor(left / 60)
        local secs = math.floor(left % 60)
        timer_label.Text = string.format("%02d:%02d", mins, secs)
        if left <= 5 then timer_label.TextColor3 = RED end
    end)
end

g.wire_cutter_minigame = function()
    if g.wire_cutter_cooldown and tick() - g.wire_cutter_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.wire_cutter_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("wire")
    local DARK = Color3.fromRGB(12, 12, 14)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local MUTED = Color3.fromRGB(120, 120, 130)
    local RED = Color3.fromRGB(220, 60, 60)
    local GREEN = Color3.fromRGB(60, 200, 100)
    local YELLOW = Color3.fromRGB(230, 200, 50)
    local BLUE = Color3.fromRGB(80, 140, 240)
    local ORANGE = Color3.fromRGB(230, 130, 40)
    local WHITE_W = Color3.fromRGB(200, 200, 200)
    local TIME_LIMIT = preset.time_limit
    local WIRE_COLORS = {
        {name = "Red",    color = RED},
        {name = "Green",  color = GREEN},
        {name = "Yellow", color = YELLOW},
        {name = "Blue",   color = BLUE},
        {name = "Orange", color = ORANGE},
        {name = "White",  color = WHITE_W},
    }
    local WIRE_COUNT = preset.wire_count
    local wires = {}
    local used = {}
    while #wires < WIRE_COUNT do
        local pick = math.random(1, #WIRE_COLORS)
        if not used[pick] then
            used[pick] = true
            table.insert(wires, {name = WIRE_COLORS[pick].name, color = WIRE_COLORS[pick].color, cut = false})
        end
    end

    local safe_wire = math.random(1, WIRE_COUNT)
    local positions = {"first", "second", "third", "fourth", "fifth", "sixth"}
    local clue_types = {}
    for i = 1, WIRE_COUNT do
        if i ~= safe_wire then
            local t = math.random(1, 3)
            if t == 1 then
                table.insert(clue_types, {wire = i, type = "color", text = "Do NOT cut the " .. wires[i].name .. " wire"})
            elseif t == 2 then
                table.insert(clue_types, {wire = i, type = "position", text = "The " .. positions[i] .. " wire is dangerous"})
            else
                table.insert(clue_types, {wire = i, type = "both", text = "Avoid the " .. positions[i] .. " (" .. wires[i].name .. ") wire"})
            end
        end
    end

    local shown_clues = {}
    local indices = {}
    for i = 1, #clue_types do indices[i] = i end
    for i = #indices, 2, -1 do
        local j = math.random(1, i)
        indices[i], indices[j] = indices[j], indices[i]
    end
    for i = 1, math.min(preset.clue_count, #clue_types) do table.insert(shown_clues, clue_types[indices[i]]) end
    local game_over = false
    local timer_conn = nil
    if CoreGui:FindFirstChild("WireCutterGUI") then CoreGui.WireCutterGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "WireCutterGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local wire_start_offset = 44 + (#shown_clues + 2) * 20
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, wire_start_offset + WIRE_COUNT * 56 + 20)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = Color3.fromRGB(60, 60, 70)
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// WIRE CUTTER //"
    title.TextColor3 = GREEN
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = YELLOW
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local clue_header = Instance.new("TextLabel")
    clue_header.Size = UDim2.new(1, -20, 0, 20)
    clue_header.Position = UDim2.new(0, 10, 0, 44)
    clue_header.BackgroundTransparency = 1
    clue_header.Text = "Intel:"
    clue_header.TextColor3 = MUTED
    clue_header.Font = Enum.Font.Code
    clue_header.TextSize = 12
    clue_header.TextXAlignment = Enum.TextXAlignment.Left
    clue_header.Parent = frame

    for i, clue in ipairs(shown_clues) do
        local clue_lbl = Instance.new("TextLabel")
        clue_lbl.Size = UDim2.new(1, -20, 0, 18)
        clue_lbl.Position = UDim2.new(0, 10, 0, 44 + i * 20)
        clue_lbl.BackgroundTransparency = 1
        clue_lbl.Text = "• " .. clue.text
        clue_lbl.TextColor3 = WHITE
        clue_lbl.Font = Enum.Font.Code
        clue_lbl.TextSize = 11
        clue_lbl.TextXAlignment = Enum.TextXAlignment.Left
        clue_lbl.Parent = frame
    end

    local wire_start_y = wire_start_offset
    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.wire_cutter_cooldown = tick()
        if g.notify then g.notify("Success", "Wire cut! Defused!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Wrong wire!", 5) end
        task.delay(0.5, cleanup)
    end

    for i, wire in ipairs(wires) do
        local wire_row = Instance.new("Frame")
        wire_row.Size = UDim2.new(1, -20, 0, 48)
        wire_row.Position = UDim2.new(0, 10, 0, wire_start_y + (i - 1) * 56)
        wire_row.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
        wire_row.BorderSizePixel = 0
        wire_row.Parent = frame
        Instance.new("UICorner", wire_row).CornerRadius = UDim.new(0, 8)
        Instance.new("UIStroke", wire_row).Color = Color3.fromRGB(40, 40, 50)

        local pos_lbl = Instance.new("TextLabel")
        pos_lbl.Size = UDim2.new(0, 20, 1, 0)
        pos_lbl.Position = UDim2.new(0, 8, 0, 0)
        pos_lbl.BackgroundTransparency = 1
        pos_lbl.Text = tostring(i)
        pos_lbl.Font = Enum.Font.Code
        pos_lbl.TextSize = 12
        pos_lbl.TextColor3 = MUTED
        pos_lbl.Parent = wire_row

        local wire_line = Instance.new("Frame")
        wire_line.Size = UDim2.new(0, 180, 0, 8)
        wire_line.AnchorPoint = Vector2.new(0, 0.5)
        wire_line.Position = UDim2.new(0, 30, 0.5, 0)
        wire_line.BackgroundColor3 = wire.color
        wire_line.BorderSizePixel = 0
        wire_line.Parent = wire_row
        Instance.new("UICorner", wire_line).CornerRadius = UDim.new(0.5, 0)

        local name_lbl = Instance.new("TextLabel")
        name_lbl.Size = UDim2.new(0, 60, 1, 0)
        name_lbl.Position = UDim2.new(0, 216, 0, 0)
        name_lbl.BackgroundTransparency = 1
        name_lbl.Text = wire.name
        name_lbl.Font = Enum.Font.Code
        name_lbl.TextSize = 12
        name_lbl.TextColor3 = wire.color
        name_lbl.Parent = wire_row

        local cut_btn = Instance.new("TextButton")
        cut_btn.Size = UDim2.new(0, 52, 0, 30)
        cut_btn.AnchorPoint = Vector2.new(1, 0.5)
        cut_btn.Position = UDim2.new(1, -8, 0.5, 0)
        cut_btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        cut_btn.Text = "CUT"
        cut_btn.Font = Enum.Font.GothamBold
        cut_btn.TextSize = 12
        cut_btn.TextColor3 = WHITE
        cut_btn.BorderSizePixel = 0
        cut_btn.Parent = wire_row
        Instance.new("UICorner", cut_btn).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", cut_btn).Color = Color3.fromRGB(70, 70, 80)

        local wire_index = i
        cut_btn.MouseButton1Click:Connect(function()
            if game_over then return end
            if wire_index == safe_wire then
                wire_line.Size = UDim2.new(0, 80, 0, 8)
                local gap = Instance.new("Frame")
                gap.Size = UDim2.new(0, 20, 0, 8)
                gap.AnchorPoint = Vector2.new(0, 0.5)
                gap.Position = UDim2.new(0, 115, 0.5, 0)
                gap.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
                gap.BorderSizePixel = 0
                gap.Parent = wire_row
                cut_btn.Text = "✅"
                cut_btn.TextColor3 = GREEN
                win()
            else
                cut_btn.TextColor3 = RED
                cut_btn.Text = "X"
                fail("Wrong wire cut!")
            end
        end)
    end

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Wire cutter cancelled.", 3) end
        cleanup()
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up!.")
            return
        end
        local mins = math.floor(left / 60)
        local secs = math.floor(left % 60)
        timer_label.Text = string.format("%02d:%02d", mins, secs)
        if left <= 5 then timer_label.TextColor3 = RED end
    end)
end

g.simon_says_minigame = function()
    if g.simon_says_cooldown and tick() - g.simon_says_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.simon_says_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end
    local preset = get_preset("simon")
    local DARK = Color3.fromRGB(14, 14, 18)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local MUTED = Color3.fromRGB(100, 100, 110)
    local ROUNDS_TO_WIN = preset.rounds_to_win
    local BUTTONS = {
        {name = "Red",    color = Color3.fromRGB(200, 50, 50),   dim = Color3.fromRGB(60, 15, 15)},
        {name = "Green",  color = Color3.fromRGB(50, 200, 90),   dim = Color3.fromRGB(15, 60, 25)},
        {name = "Blue",   color = Color3.fromRGB(60, 120, 220),  dim = Color3.fromRGB(15, 35, 70)},
        {name = "Yellow", color = Color3.fromRGB(220, 200, 40),  dim = Color3.fromRGB(65, 58, 10)},
    }
    local sequence = {}
    local player_index = 1
    local round = 0
    local accepting_input = false
    local game_over = false
    if CoreGui:FindFirstChild("SimonSaysGUI") then CoreGui.SimonSaysGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "SimonSaysGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 400)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(50, 50, 60)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// SIMON SAYS //"
    title.TextColor3 = Color3.fromRGB(180, 180, 220)
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local status_label = Instance.new("TextLabel")
    status_label.Size = UDim2.new(1, -20, 0, 22)
    status_label.Position = UDim2.new(0, 10, 0, 44)
    status_label.BackgroundTransparency = 1
    status_label.Text = "Watch the sequence..."
    status_label.TextColor3 = MUTED
    status_label.Font = Enum.Font.Code
    status_label.TextSize = 12
    status_label.TextXAlignment = Enum.TextXAlignment.Center
    status_label.Parent = frame

    local round_label = Instance.new("TextLabel")
    round_label.Size = UDim2.new(1, -20, 0, 20)
    round_label.Position = UDim2.new(0, 10, 0, 66)
    round_label.BackgroundTransparency = 1
    round_label.Text = "Round 0 / " .. ROUNDS_TO_WIN
    round_label.TextColor3 = MUTED
    round_label.Font = Enum.Font.Code
    round_label.TextSize = 11
    round_label.TextXAlignment = Enum.TextXAlignment.Center
    round_label.Parent = frame

    local grid = Instance.new("Frame")
    grid.Size = UDim2.new(0, 260, 0, 260)
    grid.AnchorPoint = Vector2.new(0.5, 0)
    grid.Position = UDim2.new(0.5, 0, 0, 100)
    grid.BackgroundTransparency = 1
    grid.Parent = frame

    local btn_refs = {}
    local positions = {
        UDim2.new(0, 0, 0, 0),
        UDim2.new(0, 136, 0, 0),
        UDim2.new(0, 0, 0, 136),
        UDim2.new(0, 136, 0, 136),
    }
    local function cleanup() getgenv().Keybind_Input_Disabled_For_Mini_Game = false; if gui then gui:Destroy() end end
    local function win()
        game_over = true
        g.simon_says_cooldown = tick()
        if g.notify then g.notify("Success", "Simon says well done!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Wrong button!", 5) end
        task.delay(0.3, cleanup)
    end

    local function flash_button(index, duration, callback)
        local b = btn_refs[index]
        if not b then if callback then callback() end; return end
        b.BackgroundColor3 = BUTTONS[index].color
        task.delay(duration, function()
            b.BackgroundColor3 = BUTTONS[index].dim
            if callback then task.delay(preset.gap_duration, callback) end
        end)
    end

    local function play_sequence(step, callback)
        if step > #sequence then
            if callback then callback() end
            return
        end
        flash_button(sequence[step], preset.flash_duration, function()
            task.delay(preset.gap_duration, function()
                play_sequence(step + 1, callback)
            end)
        end)
    end

    local function start_round()
        if game_over then return end
        round = round + 1
        round_label.Text = "Round " .. round .. " / " .. ROUNDS_TO_WIN
        status_label.Text = "Watch..."
        status_label.TextColor3 = MUTED
        accepting_input = false
        player_index = 1
        table.insert(sequence, math.random(1, 4))
        task.delay(0.6, function()
            play_sequence(1, function()
                if not game_over then
                    accepting_input = true
                    status_label.Text = "Your turn! Repeat the sequence"
                    status_label.TextColor3 = WHITE
                end
            end)
        end)
    end

    for i, data in ipairs(BUTTONS) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 120, 0, 120)
        btn.Position = positions[i]
        btn.BackgroundColor3 = data.dim
        btn.Text = data.name
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.TextColor3 = WHITE
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.Parent = grid
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
        btn_refs[i] = btn

        local idx = i
        btn.MouseButton1Click:Connect(function()
            if game_over or not accepting_input then return end
            flash_button(idx, 0.2, nil)
            if sequence[player_index] == idx then
                player_index = player_index + 1
                if player_index > #sequence then
                    accepting_input = false
                    if round >= ROUNDS_TO_WIN then
                        win()
                    else
                        status_label.Text = "Correct! Next round..."
                        status_label.TextColor3 = Color3.fromRGB(60, 200, 100)
                        task.delay(0.8, start_round)
                    end
                end
            else
                fail("Wrong button!.")
            end
        end)
    end

    cancel.MouseButton1Click:Connect(function()
        if g.notify and typeof(g.notify) == "function" then g.notify("Info", "Simon Says cancelled.", 3) end
        cleanup()
    end)

    start_round()
end

g.dead_drop_minigame = function()
    if g.dead_drop_minigame_cooldown and tick() - g.dead_drop_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.dead_drop_minigame_cooldown))
        if g.notify then g.notify("Warning", "Wait " .. remaining .. "s.", 5) end
        return
    end

    local preset     = get_preset("dead_drop")
    local DARK       = Color3.fromRGB(8, 8, 10)
    local WHITE      = Color3.fromRGB(240, 240, 240)
    local MUTED      = Color3.fromRGB(80, 80, 95)
    local GREEN      = Color3.fromRGB(60, 200, 100)
    local RED        = Color3.fromRGB(200, 60, 60)
    local SIGNAL_COL = Color3.fromRGB(60, 230, 160)
    local DECOY_COL  = Color3.fromRGB(230, 180, 40)
    local SCREEN_BG  = Color3.fromRGB(12, 14, 12)
    local STATIC_LO  = Color3.fromRGB(18, 20, 18)
    local STATIC_HI  = Color3.fromRGB(38, 42, 38)
    local GRID_COLS       = preset.grid_cols
    local GRID_ROWS       = preset.grid_rows
    local HOP_INTERVAL    = preset.hop_interval
    local MAX_MISSES      = preset.max_misses
    local SIGNAL_DURATION = preset.signal_duration
    local DECOYS          = preset.decoys
    local FEED_COUNT      = GRID_COLS * GRID_ROWS
    local ROUNDS_TO_WIN   = 6
    local signal_feed    = math.random(1, FEED_COUNT)
    local signal_visible = false
    local misses         = 0
    local rounds_won     = 0
    local game_over      = false
    local hop_elapsed    = 0
    local signal_elapsed = 0
    local static_elapsed = 0
    local render_conn    = nil
    local feed_frames    = {}
    local feed_cells     = {}
    local scanline_frames = {}
    local CELL_COLS      = 10
    local CELL_ROWS      = 8
    if CoreGui:FindFirstChild("DeadDropGUI") then CoreGui.DeadDropGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "DeadDropGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true

    local CELL_SIZE  = 54
    local GRID_W     = GRID_COLS * (CELL_SIZE + 8) + 8
    local GRID_H     = GRID_ROWS * (CELL_SIZE + 8) + 8
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, math.max(340, GRID_W + 40), 0, GRID_H + 160)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = Color3.fromRGB(40, 50, 40)
    fstroke.Thickness = 1.5

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// DEAD DROP //"
    title.TextColor3 = SIGNAL_COL
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.22, 0, 0, 36)
    timer_label.Position = UDim2.new(0.7, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "INTERCEPTS: 0/" .. ROUNDS_TO_WIN
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 10
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local miss_lbl = Instance.new("TextLabel")
    miss_lbl.Size = UDim2.new(1, -20, 0, 16)
    miss_lbl.Position = UDim2.new(0, 10, 0, 44)
    miss_lbl.BackgroundTransparency = 1
    miss_lbl.Text = "Misses: 0 / " .. MAX_MISSES .. "   —   Watch for the signal flicker."
    miss_lbl.TextColor3 = MUTED
    miss_lbl.Font = Enum.Font.Code
    miss_lbl.TextSize = 10
    miss_lbl.TextXAlignment = Enum.TextXAlignment.Left
    miss_lbl.Parent = frame

    local grid_frame = Instance.new("Frame")
    grid_frame.Size = UDim2.new(0, GRID_W, 0, GRID_H)
    grid_frame.AnchorPoint = Vector2.new(0.5, 0)
    grid_frame.Position = UDim2.new(0.5, 0, 0, 66)
    grid_frame.BackgroundTransparency = 1
    grid_frame.Parent = frame

    local function cleanup()
        if render_conn then render_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.dead_drop_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Signal intercepted!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Signal lost!", 5) end
        task.delay(0.5, cleanup)
    end

    local function hop_signal()
        signal_visible = false
        local prev = signal_feed
        repeat signal_feed = math.random(1, FEED_COUNT) until signal_feed ~= prev
        hop_elapsed    = 0
        signal_elapsed = 0
        signal_visible = false
    end

    local decoy_feeds  = {}
    local function build_static(cells, intensity)
        for r = 1, CELL_ROWS do
            for c = 1, CELL_COLS do
                local v = math.random()
                local bright = v < intensity
                cells[r][c].BackgroundColor3 = bright and STATIC_HI or STATIC_LO
            end
        end
    end

    local function build_signal_pattern(cells, col)
        for r = 1, CELL_ROWS do
            for c = 1, CELL_COLS do
                local cx = (c - 0.5) / CELL_COLS
                local cy = (r - 0.5) / CELL_ROWS
                local dist = math.sqrt((cx - 0.5)^2 + (cy - 0.5)^2)
                local ring = math.sin(dist * math.pi * 8) > 0.3
                local v = math.random()
                if ring and v > 0.3 then
                    cells[r][c].BackgroundColor3 = col
                else
                    cells[r][c].BackgroundColor3 = v < 0.25 and STATIC_HI or STATIC_LO
                end
            end
        end
    end

    for i = 1, FEED_COUNT do
        local row = math.floor((i - 1) / GRID_COLS)
        local col = (i - 1) % GRID_COLS
        local px  = col * (CELL_SIZE + 8) + 8
        local py  = row * (CELL_SIZE + 8) + 8

        local feed = Instance.new("Frame")
        feed.Size = UDim2.new(0, CELL_SIZE, 0, CELL_SIZE)
        feed.Position = UDim2.new(0, px, 0, py)
        feed.BackgroundColor3 = SCREEN_BG
        feed.BorderSizePixel = 0
        feed.ClipsDescendants = true
        feed.Parent = grid_frame
        Instance.new("UICorner", feed).CornerRadius = UDim.new(0, 6)
        local feed_stroke = Instance.new("UIStroke", feed)
        feed_stroke.Color = Color3.fromRGB(30, 35, 30)
        feed_stroke.Thickness = 1

        local cam_lbl = Instance.new("TextLabel")
        cam_lbl.Size = UDim2.new(1, 0, 0, 8)
        cam_lbl.Position = UDim2.new(0, 0, 0, 1)
        cam_lbl.BackgroundTransparency = 1
        cam_lbl.Text = "CAM " .. string.format("%02d", i)
        cam_lbl.Font = Enum.Font.Code
        cam_lbl.TextSize = 7
        cam_lbl.TextColor3 = Color3.fromRGB(50, 70, 50)
        cam_lbl.TextXAlignment = Enum.TextXAlignment.Left
        cam_lbl.Parent = feed

        local cell_grid = Instance.new("Frame")
        cell_grid.Size = UDim2.new(1, 0, 1, -9)
        cell_grid.Position = UDim2.new(0, 0, 0, 9)
        cell_grid.BackgroundTransparency = 1
        cell_grid.ClipsDescendants = true
        cell_grid.Parent = feed

        feed_cells[i] = {}
        for r = 1, CELL_ROWS do
            feed_cells[i][r] = {}
            for c = 1, CELL_COLS do
                local cell = Instance.new("Frame")
                cell.Size = UDim2.new(1 / CELL_COLS, 0, 1 / CELL_ROWS, 0)
                cell.Position = UDim2.new((c - 1) / CELL_COLS, 0, (r - 1) / CELL_ROWS, 0)
                cell.BackgroundColor3 = STATIC_LO
                cell.BorderSizePixel = 0
                cell.Parent = cell_grid
                feed_cells[i][r][c] = cell
            end
        end

        local scanline = Instance.new("Frame")
        scanline.Size = UDim2.new(1, 0, 0, 2)
        scanline.Position = UDim2.new(0, 0, 0, 0)
        scanline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        scanline.BackgroundTransparency = 0.88
        scanline.BorderSizePixel = 0
        scanline.ZIndex = 4
        scanline.Parent = feed
        scanline_frames[i] = scanline

        local click_btn = Instance.new("TextButton")
        click_btn.Size = UDim2.fromScale(1, 1)
        click_btn.BackgroundTransparency = 1
        click_btn.Text = ""
        click_btn.ZIndex = 5
        click_btn.Parent = feed
        feed_frames[i] = {frame = feed, stroke = feed_stroke, cam_lbl = cam_lbl}

        local feed_idx = i
        click_btn.MouseButton1Click:Connect(function()
            if game_over then return end
            if not signal_visible then return end
            if feed_idx == signal_feed then
                feed_stroke.Color = GREEN
                feed_stroke.Thickness = 2
                cam_lbl.TextColor3 = GREEN
                rounds_won = rounds_won + 1
                timer_label.Text = "INTERCEPTS: " .. rounds_won .. "/" .. ROUNDS_TO_WIN
                signal_visible = false
                if rounds_won >= ROUNDS_TO_WIN then
                    win()
                    return
                end
                task.delay(0.15, function()
                    if game_over then return end
                    feed_stroke.Color = Color3.fromRGB(30, 35, 30)
                    feed_stroke.Thickness = 1
                    cam_lbl.TextColor3 = Color3.fromRGB(50, 70, 50)
                    hop_signal()
                end)
            else
                local is_decoy = false
                for _, di in ipairs(decoy_feeds) do
                    if di == feed_idx then is_decoy = true; break end
                end
                if not is_decoy then
                    misses = misses + 1
                    miss_lbl.Text = "Misses: " .. misses .. " / " .. MAX_MISSES .. "   —   Watch for the signal flicker."
                    feed_stroke.Color = RED
                    feed_stroke.Thickness = 2
                    task.delay(0.3, function()
                        if game_over then return end
                        feed_stroke.Color = Color3.fromRGB(30, 35, 30)
                        feed_stroke.Thickness = 1
                    end)
                    if misses >= MAX_MISSES then
                        fail("Too many wrong feeds!")
                    end
                end
            end
        end)
    end

    local scanline_pos = {}
    for i = 1, FEED_COUNT do scanline_pos[i] = math.random() end

    render_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        static_elapsed = static_elapsed + dt
        hop_elapsed    = hop_elapsed    + dt
        signal_elapsed = signal_elapsed + dt

        if hop_elapsed >= HOP_INTERVAL then
            misses = misses + 1
            miss_lbl.Text = "Misses: " .. misses .. " / " .. MAX_MISSES .. "   —   Watch for the signal flicker."
            if misses >= MAX_MISSES then
                fail("Signal lost — too slow!")
                return
            end
            hop_signal()
        end

        local show_signal = signal_elapsed <= SIGNAL_DURATION
        signal_visible = show_signal

        if DECOYS and show_signal then
            decoy_feeds = {}
            if math.random() > 0.6 then
                local d = math.random(1, FEED_COUNT)
                if d ~= signal_feed then
                    table.insert(decoy_feeds, d)
                end
            end
        else
            decoy_feeds = {}
        end

        if static_elapsed > 0.05 then
            static_elapsed = 0
            for i = 1, FEED_COUNT do
                local is_signal = (i == signal_feed and show_signal)
                local is_decoy  = false
                for _, di in ipairs(decoy_feeds) do if di == i then is_decoy = true; break end end

                if is_signal then
                    build_signal_pattern(feed_cells[i], SIGNAL_COL)
                    feed_frames[i].stroke.Color = SIGNAL_COL
                    feed_frames[i].stroke.Thickness = 2
                elseif is_decoy then
                    build_signal_pattern(feed_cells[i], DECOY_COL)
                    feed_frames[i].stroke.Color = DECOY_COL
                    feed_frames[i].stroke.Thickness = 1.5
                else
                    build_static(feed_cells[i], 0.18)
                    feed_frames[i].stroke.Color = Color3.fromRGB(30, 35, 30)
                    feed_frames[i].stroke.Thickness = 1
                end

                scanline_pos[i] = (scanline_pos[i] + dt * 0.4) % 1
                scanline_frames[i].Position = UDim2.new(0, 0, scanline_pos[i], 0)
            end
        end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Dead drop cancelled.", 3) end
        cleanup()
    end)
end

g.open_difficulty_editor = function()
    if CoreGui:FindFirstChild("DifficultyEditorGUI") then
        CoreGui.DifficultyEditorGUI.Frame.Visible = true
        return
    end

    local DARK = Color3.fromRGB(18, 18, 18)
    local SURFACE = Color3.fromRGB(26, 26, 26)
    local BORDER = Color3.fromRGB(50, 50, 50)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local MUTED = Color3.fromRGB(140, 140, 140)
    local GAME_LABELS = {
        {key = "memory", name = "Memory Grid"},
        {key = "reaction", name = "Reaction Time"},
        {key = "keypad", name = "Keypad Hack"},
        {key = "hacking", name = "Breach Protocol"},
        {key = "safe", name = "Safe Cracker"},
        {key = "wire", name = "Wire Cutter"},
        {key = "simon", name = "Simon Says"},
        {key = "lockpick", name = "Lockpick"},
        {key = "laser", name = "Laser Grid"},
        {key = "signal", name = "Signal Triangulation"},
        {key = "pipe", name = "Pipe Reroute"},
        {key = "steady", name = "Steady Hand"},
        {key = "rhythm", name = "Rhythm Splice"},
        {key = "recall", name = "Vault Recall"},
        {key = "morse",      name = "Morse Decoder"},
        {key = "frequency",  name = "Frequency Tuner"},
        {key = "overload",   name = "Overload"},
        {key = "terminal",   name = "Terminal Hack"},
        {key = "voltage",    name = "Voltage Regulator"},
        {key = "shadow",     name = "Shadow Recall"},
        {key = "bank_drill", name = "Vault Drill"},
        {key = "fingerprint", name = "Fingerprint Scanner"},
        {key = "dead_drop", name = "Dead Drop"},
    }

    local gui = Instance.new("ScreenGui")
    gui.Name = "DifficultyEditorGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    local outer = Instance.new("Frame")
    outer.Name = "Frame"
    outer.AnchorPoint = Vector2.new(0.5, 0.5)
    outer.Position = UDim2.fromScale(0.5, 0.5)
    outer.Size = UDim2.new(0, 340, 0, 470)
    outer.BackgroundColor3 = DARK
    outer.BorderSizePixel = 0
    outer.Parent = gui
    Instance.new("UICorner", outer).CornerRadius = UDim.new(0, 14)
    Instance.new("UIStroke", outer).Color = BORDER

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 42)
    header.BackgroundColor3 = SURFACE
    header.BorderSizePixel = 0
    header.Parent = outer
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 14)

    local hfix = Instance.new("Frame")
    hfix.Size = UDim2.new(1, 0, 0.5, 0)
    hfix.Position = UDim2.fromScale(0, 0.5)
    hfix.BackgroundColor3 = SURFACE
    hfix.BorderSizePixel = 0
    hfix.Parent = header

    local title_lbl = Instance.new("TextLabel")
    title_lbl.Size = UDim2.new(1, -50, 1, 0)
    title_lbl.Position = UDim2.new(0, 14, 0, 0)
    title_lbl.BackgroundTransparency = 1
    title_lbl.Text = "Difficulty Editor"
    title_lbl.Font = Enum.Font.GothamBold
    title_lbl.TextSize = 14
    title_lbl.TextColor3 = WHITE
    title_lbl.TextXAlignment = Enum.TextXAlignment.Left
    title_lbl.Parent = header

    local close_btn = Instance.new("TextButton")
    close_btn.Size = UDim2.new(0, 34, 0, 24)
    close_btn.Position = UDim2.new(1, -42, 0.5, -12)
    close_btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    close_btn.Text = "X"
    close_btn.TextColor3 = MUTED
    close_btn.Font = Enum.Font.GothamBold
    close_btn.TextSize = 13
    close_btn.BorderSizePixel = 0
    close_btn.Parent = header
    Instance.new("UICorner", close_btn).CornerRadius = UDim.new(0, 6)
    close_btn.MouseButton1Click:Connect(function() outer.Visible = false end)

    if g.dragify and typeof(g.dragify) == "function" then g.dragify(outer) end
    local list_frame = Instance.new("ScrollingFrame")
    list_frame.Size = UDim2.new(1, 0, 1, -92)
    list_frame.Position = UDim2.new(0, 0, 0, 42)
    list_frame.BackgroundTransparency = 1
    list_frame.BorderSizePixel = 0
    list_frame.ScrollBarThickness = 3
    list_frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    list_frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    list_frame.Parent = outer

    local ui_list = Instance.new("UIListLayout")
    ui_list.Padding = UDim.new(0, 8)
    ui_list.SortOrder = Enum.SortOrder.LayoutOrder
    ui_list.Parent = list_frame

    local list_pad = Instance.new("UIPadding")
    list_pad.PaddingTop = UDim.new(0, 10)
    list_pad.PaddingBottom = UDim.new(0, 10)
    list_pad.PaddingLeft = UDim.new(0, 10)
    list_pad.PaddingRight = UDim.new(0, 10)
    list_pad.Parent = list_frame

    local refresh_row
    local function randomize_one(game_key)
        g.minigame_difficulty[game_key] = DIFFICULTY_ORDER[math.random(1, #DIFFICULTY_ORDER)]
        refresh_row(game_key)
    end

    local row_buttons = {}
    local function build_row(entry, order)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, 0, 0, 62)
        card.BackgroundColor3 = SURFACE
        card.BorderSizePixel = 0
        card.LayoutOrder = order
        card.Parent = list_frame
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
        Instance.new("UIStroke", card).Color = BORDER

        local name_lbl = Instance.new("TextLabel")
        name_lbl.Size = UDim2.new(1, -20, 0, 18)
        name_lbl.Position = UDim2.new(0, 10, 0, 6)
        name_lbl.BackgroundTransparency = 1
        name_lbl.Text = entry.name
        name_lbl.Font = Enum.Font.GothamBold
        name_lbl.TextSize = 12
        name_lbl.TextColor3 = WHITE
        name_lbl.TextXAlignment = Enum.TextXAlignment.Left
        name_lbl.Parent = card

        local btn_row = Instance.new("Frame")
        btn_row.Size = UDim2.new(1, -20, 0, 28)
        btn_row.Position = UDim2.new(0, 10, 0, 26)
        btn_row.BackgroundTransparency = 1
        btn_row.Parent = card

        local btn_layout = Instance.new("UIListLayout")
        btn_layout.FillDirection = Enum.FillDirection.Horizontal
        btn_layout.Padding = UDim.new(0, 6)
        btn_layout.SortOrder = Enum.SortOrder.LayoutOrder
        btn_layout.Parent = btn_row

        row_buttons[entry.key] = {}

        for _, diff_name in ipairs(DIFFICULTY_ORDER) do
            local diff_btn = Instance.new("TextButton")
            diff_btn.Size = UDim2.new(0, 68, 1, 0)
            diff_btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            diff_btn.Text = diff_name
            diff_btn.Font = Enum.Font.GothamBold
            diff_btn.TextSize = 11
            diff_btn.TextColor3 = MUTED
            diff_btn.BorderSizePixel = 0
            diff_btn.Parent = btn_row
            Instance.new("UICorner", diff_btn).CornerRadius = UDim.new(0, 6)
            row_buttons[entry.key][diff_name] = diff_btn

            diff_btn.MouseButton1Click:Connect(function()
                g.minigame_difficulty[entry.key] = diff_name
                refresh_row(entry.key)
            end)
        end

        local dice_btn = Instance.new("TextButton")
        dice_btn.Size = UDim2.new(0, 28, 1, 0)
        dice_btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        dice_btn.Text = "🎲"
        dice_btn.TextSize = 13
        dice_btn.BorderSizePixel = 0
        dice_btn.Parent = btn_row
        Instance.new("UICorner", dice_btn).CornerRadius = UDim.new(0, 6)
        dice_btn.MouseButton1Click:Connect(function() randomize_one(entry.key) end)
    end

    refresh_row = function(game_key)
        local current = g.minigame_difficulty[game_key] or "Medium"
        for diff_name, btn in pairs(row_buttons[game_key]) do
            if diff_name == current then
                btn.BackgroundColor3 = DIFFICULTY_COLOR[diff_name]
                btn.TextColor3 = Color3.fromRGB(20, 20, 20)
            else
                btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                btn.TextColor3 = MUTED
            end
        end
    end

    for i, entry in ipairs(GAME_LABELS) do build_row(entry, i) end
    for _, entry in ipairs(GAME_LABELS) do refresh_row(entry.key) end
    local footer = Instance.new("Frame")
    footer.Size = UDim2.new(1, 0, 0, 50)
    footer.Position = UDim2.new(0, 0, 1, -50)
    footer.BackgroundColor3 = SURFACE
    footer.BorderSizePixel = 0
    footer.Parent = outer

    local randomize_all_btn = Instance.new("TextButton")
    randomize_all_btn.Size = UDim2.new(1, -20, 0, 32)
    randomize_all_btn.Position = UDim2.new(0, 10, 0, 9)
    randomize_all_btn.BackgroundColor3 = Color3.fromRGB(60, 50, 90)
    randomize_all_btn.Text = "🎲 Randomize All"
    randomize_all_btn.Font = Enum.Font.GothamBold
    randomize_all_btn.TextSize = 13
    randomize_all_btn.TextColor3 = WHITE
    randomize_all_btn.BorderSizePixel = 0
    randomize_all_btn.Parent = footer
    Instance.new("UICorner", randomize_all_btn).CornerRadius = UDim.new(0, 8)
    randomize_all_btn.MouseButton1Click:Connect(function() for _, entry in ipairs(GAME_LABELS) do randomize_one(entry.key) end end)
end

g.lockpick_minigame = function()
    if g.lockpick_minigame_cooldown and tick() - g.lockpick_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.lockpick_minigame_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("lockpick")
    local DARK = Color3.fromRGB(16, 14, 12)
    local BRONZE = Color3.fromRGB(190, 140, 70)
    local DIM_BRONZE = Color3.fromRGB(70, 55, 30)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED = Color3.fromRGB(200, 60, 60)
    local GREEN = Color3.fromRGB(60, 200, 100)
    local PIN_COUNT = preset.pin_count
    local SWEET_WIDTH = preset.sweet_width
    local TENSION_MAX = preset.tension_max
    local TENSION_RATE = preset.tension_rate
    local DIAL_SPEED = preset.dial_speed
    local pin = 1
    local angle = 0
    local dir = 1
    local sweet_start = math.random(0, 359)
    local tension = 0
    local holding_tension = false
    local game_over = false
    local render_conn = nil
    local heartbeat_conn = nil
    if CoreGui:FindFirstChild("LockpickGUI") then CoreGui.LockpickGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "LockpickGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 440)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = BRONZE
    fstroke.Thickness = 1.5

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// LOCKPICK //"
    title.TextColor3 = BRONZE
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local pin_label = Instance.new("TextLabel")
    pin_label.Size = UDim2.new(1, -20, 0, 22)
    pin_label.Position = UDim2.new(0, 10, 0, 44)
    pin_label.BackgroundTransparency = 1
    pin_label.Text = "Pin 1 of " .. PIN_COUNT
    pin_label.TextColor3 = BRONZE
    pin_label.Font = Enum.Font.Code
    pin_label.TextSize = 13
    pin_label.TextXAlignment = Enum.TextXAlignment.Left
    pin_label.Parent = frame

    local dial_holder = Instance.new("Frame")
    dial_holder.Size = UDim2.new(0, 240, 0, 240)
    dial_holder.AnchorPoint = Vector2.new(0.5, 0)
    dial_holder.Position = UDim2.new(0.5, 0, 0, 76)
    dial_holder.BackgroundTransparency = 1
    dial_holder.Parent = frame

    local dial_bg = Instance.new("Frame")
    dial_bg.Size = UDim2.fromScale(1, 1)
    dial_bg.BackgroundColor3 = Color3.fromRGB(24, 20, 16)
    dial_bg.BorderSizePixel = 0
    dial_bg.Parent = dial_holder
    Instance.new("UICorner", dial_bg).CornerRadius = UDim.new(0.5, 0)
    local dstroke = Instance.new("UIStroke", dial_bg)
    dstroke.Color = DIM_BRONZE
    dstroke.Thickness = 2

    local sweet_arc = Instance.new("Frame")
    sweet_arc.Size = UDim2.new(0, 10, 0, 40)
    sweet_arc.AnchorPoint = Vector2.new(0.5, 1)
    sweet_arc.BackgroundColor3 = GREEN
    sweet_arc.BorderSizePixel = 0
    sweet_arc.Parent = dial_holder
    Instance.new("UICorner", sweet_arc).CornerRadius = UDim.new(0, 4)

    local pick_marker = Instance.new("Frame")
    pick_marker.Size = UDim2.new(0, 6, 0, 90)
    pick_marker.AnchorPoint = Vector2.new(0.5, 1)
    pick_marker.BackgroundColor3 = WHITE
    pick_marker.BorderSizePixel = 0
    pick_marker.Parent = dial_holder
    Instance.new("UICorner", pick_marker).CornerRadius = UDim.new(0, 3)

    local function position_at_angle(part, degrees, radius)
        local rad = math.rad(degrees - 90)
        local px = 0.5 + math.cos(rad) * radius
        local py = 0.5 + math.sin(rad) * radius
        part.Position = UDim2.new(px, 0, py, 0)
        part.Rotation = degrees
    end

    position_at_angle(sweet_arc, sweet_start + SWEET_WIDTH / 2, 0.42)

    local tension_bg = Instance.new("Frame")
    tension_bg.Size = UDim2.new(1, -20, 0, 18)
    tension_bg.Position = UDim2.new(0, 10, 0, 328)
    tension_bg.BackgroundColor3 = Color3.fromRGB(30, 26, 20)
    tension_bg.BorderSizePixel = 0
    tension_bg.Parent = frame
    Instance.new("UICorner", tension_bg).CornerRadius = UDim.new(0, 8)

    local tension_fill = Instance.new("Frame")
    tension_fill.Size = UDim2.new(0, 0, 1, 0)
    tension_fill.BackgroundColor3 = GREEN
    tension_fill.BorderSizePixel = 0
    tension_fill.Parent = tension_bg
    Instance.new("UICorner", tension_fill).CornerRadius = UDim.new(0, 8)

    local tension_label = Instance.new("TextLabel")
    tension_label.Size = UDim2.new(1, -20, 0, 16)
    tension_label.Position = UDim2.new(0, 10, 0, 350)
    tension_label.BackgroundTransparency = 1
    tension_label.Text = "TENSION"
    tension_label.TextColor3 = DIM_BRONZE
    tension_label.Font = Enum.Font.Code
    tension_label.TextSize = 11
    tension_label.TextXAlignment = Enum.TextXAlignment.Center
    tension_label.Parent = frame

    local tension_btn = Instance.new("TextButton")
    tension_btn.Size = UDim2.new(0, 160, 0, 40)
    tension_btn.AnchorPoint = Vector2.new(0.5, 0)
    tension_btn.Position = UDim2.new(0.5, 0, 0, 376)
    tension_btn.BackgroundColor3 = Color3.fromRGB(38, 32, 20)
    tension_btn.Text = "HOLD + SET PIN"
    tension_btn.Font = Enum.Font.GothamBold
    tension_btn.TextSize = 13
    tension_btn.TextColor3 = BRONZE
    tension_btn.BorderSizePixel = 0
    tension_btn.Parent = frame
    Instance.new("UICorner", tension_btn).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", tension_btn).Color = BRONZE

    local function cleanup()
        if render_conn then render_conn:Disconnect() end
        if heartbeat_conn then heartbeat_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.lockpick_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Lock picked!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Pick broke!", 5) end
        task.delay(0.5, cleanup)
    end

    local function next_pin()
        pin = pin + 1
        if pin > PIN_COUNT then
            win()
            return
        end
        pin_label.Text = "Pin " .. pin .. " of " .. PIN_COUNT
        sweet_start = math.random(0, 359)
        position_at_angle(sweet_arc, sweet_start + SWEET_WIDTH / 2, 0.42)
        tension = math.max(0, tension - TENSION_MAX * 0.25)
    end

    tension_btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            holding_tension = true
        end
    end)

    tension_btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            holding_tension = false
        end
    end)

    tension_btn.MouseButton1Click:Connect(function()
        if game_over then return end
        local diff = math.abs(angle - (sweet_start + SWEET_WIDTH / 2))
        diff = math.min(diff, 360 - diff)
        if diff <= SWEET_WIDTH / 2 then
            next_pin()
        else
            tension = math.min(TENSION_MAX, tension + TENSION_RATE * 4)
        end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Lockpick cancelled.", 3) end
        cleanup()
    end)

    render_conn = RunService.RenderStepped:Connect(function(dt)
        if game_over then return end
        angle = angle + DIAL_SPEED * dt * dir
        if angle >= 360 then angle = angle - 360 end
        if angle < 0 then angle = angle + 360 end
        position_at_angle(pick_marker, angle, 0.45)
    end)

    heartbeat_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        if holding_tension then
            tension = tension + TENSION_RATE * dt
        else
            tension = math.max(0, tension - TENSION_RATE * 1.5 * dt)
        end
        tension_fill.Size = UDim2.new(math.clamp(tension / TENSION_MAX, 0, 1), 0, 1, 0)
        tension_fill.BackgroundColor3 = tension > TENSION_MAX * 0.75 and RED or GREEN
        if tension >= TENSION_MAX then
            fail("Pick snapped!")
        end
    end)
end

g.laser_grid_minigame = function()
    if g.laser_grid_cooldown and tick() - g.laser_grid_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.laser_grid_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("laser")
    local DARK = Color3.fromRGB(10, 10, 14)
    local RED = Color3.fromRGB(220, 50, 50)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local GREEN = Color3.fromRGB(60, 200, 100)
    local MUTED = Color3.fromRGB(90, 90, 100)
    local ROW_COUNT = preset.row_count
    local BEAM_SPEED = preset.beam_speed
    local HAZARD_MARGIN = preset.hazard_margin
    local TIME_LIMIT = preset.time_limit
    local BEAM_WIDTH = 0.08
    local current_row = 1
    local game_over = false
    local timer_conn = nil
    local render_conn = nil
    local beam_phase = {}
    for i = 1, ROW_COUNT do beam_phase[i] = math.random() * math.pi * 2 end

    if CoreGui:FindFirstChild("LaserGridGUI") then CoreGui.LaserGridGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "LaserGridGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, ROW_COUNT * 46 + 130)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = RED
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// LASER GRID //"
    title.TextColor3 = RED
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local status_label = Instance.new("TextLabel")
    status_label.Size = UDim2.new(1, -20, 0, 20)
    status_label.Position = UDim2.new(0, 10, 0, 44)
    status_label.BackgroundTransparency = 1
    status_label.Text = "Row 1 of " .. ROW_COUNT .. " — advance between beams"
    status_label.TextColor3 = MUTED
    status_label.Font = Enum.Font.Code
    status_label.TextSize = 11
    status_label.TextXAlignment = Enum.TextXAlignment.Left
    status_label.Parent = frame

    local rows_holder = Instance.new("Frame")
    rows_holder.Size = UDim2.new(1, -20, 0, ROW_COUNT * 46)
    rows_holder.Position = UDim2.new(0, 10, 0, 70)
    rows_holder.BackgroundTransparency = 1
    rows_holder.Parent = frame

    local lanes = {}
    local token_col = 0.1
    for i = 1, ROW_COUNT do
        local lane = Instance.new("Frame")
        lane.Size = UDim2.new(1, 0, 0, 38)
        lane.Position = UDim2.new(0, 0, 0, (ROW_COUNT - i) * 46)
        lane.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
        lane.BorderSizePixel = 0
        lane.Parent = rows_holder
        Instance.new("UICorner", lane).CornerRadius = UDim.new(0, 6)

        local beam = Instance.new("Frame")
        beam.Size = UDim2.new(BEAM_WIDTH, 0, 1, 0)
        beam.BackgroundColor3 = RED
        beam.BorderSizePixel = 0
        beam.Parent = lane
        Instance.new("UICorner", beam).CornerRadius = UDim.new(0, 6)

        lanes[i] = {lane = lane, beam = beam}
    end

    local token = Instance.new("Frame")
    token.Size = UDim2.new(0, 20, 0, 20)
    token.AnchorPoint = Vector2.new(0.5, 0.5)
    token.BackgroundColor3 = GREEN
    token.BorderSizePixel = 0
    token.Parent = lanes[1].lane
    token.Position = UDim2.new(token_col, 0, 0.5, 0)
    Instance.new("UICorner", token).CornerRadius = UDim.new(0.5, 0)

    local advance_btn = Instance.new("TextButton")
    advance_btn.Size = UDim2.new(0, 140, 0, 36)
    advance_btn.AnchorPoint = Vector2.new(0.5, 0)
    advance_btn.Position = UDim2.new(0.5, 0, 1, -46)
    advance_btn.BackgroundColor3 = Color3.fromRGB(38, 30, 30)
    advance_btn.Text = "ADVANCE"
    advance_btn.Font = Enum.Font.GothamBold
    advance_btn.TextSize = 13
    advance_btn.TextColor3 = RED
    advance_btn.BorderSizePixel = 0
    advance_btn.Parent = frame
    Instance.new("UICorner", advance_btn).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", advance_btn).Color = RED

    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if render_conn then render_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.laser_grid_cooldown = tick()
        if g.notify then g.notify("Success", "Bypassed the laser grid!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Tripped a laser!", 5) end
        task.delay(0.5, cleanup)
    end

    advance_btn.MouseButton1Click:Connect(function()
        if game_over then return end
        local row_data = lanes[current_row]
        local beam_min = row_data.beam.Position.X.Scale - HAZARD_MARGIN / 2
        local beam_max = beam_min + BEAM_WIDTH + HAZARD_MARGIN
        if token_col >= beam_min and token_col <= beam_max then
            fail("Tripped a laser!")
            return
        end
        current_row = current_row + 1
        if current_row > ROW_COUNT then
            win()
            return
        end
        token.Parent = lanes[current_row].lane
        status_label.Text = "Row " .. current_row .. " of " .. ROW_COUNT .. " — advance between beams"
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Laser grid cancelled.", 3) end
        cleanup()
    end)

    render_conn = RunService.RenderStepped:Connect(function(dt)
        if game_over then return end
        for i, row_data in ipairs(lanes) do
            beam_phase[i] = beam_phase[i] + dt * BEAM_SPEED
            local offset = (math.sin(beam_phase[i]) + 1) / 2 * (1 - BEAM_WIDTH)
            row_data.beam.Position = UDim2.new(offset, 0, 0, 0)
        end
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up!")
            return
        end
        local mins = math.floor(left / 60)
        local secs = math.floor(left % 60)
        timer_label.Text = string.format("%02d:%02d", mins, secs)
        if left <= 5 then timer_label.TextColor3 = RED end
    end)
end

g.signal_triangulation_minigame = function()
    if g.signal_triangulation_cooldown and tick() - g.signal_triangulation_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.signal_triangulation_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local UserInputService = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
    local preset = get_preset("signal")
    local DARK = Color3.fromRGB(10, 12, 16)
    local CYAN = Color3.fromRGB(60, 200, 220)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED = Color3.fromRGB(200, 60, 60)
    local GREEN = Color3.fromRGB(60, 200, 100)
    local TOLERANCE = preset.tolerance
    local DRIFT_SPEED = preset.drift_speed
    local TIME_LIMIT = preset.time_limit
    local target_pos = math.random(10, 90)
    local handle_pos = 50
    local dragging = false
    local game_over = false
    local drift_dir = 1
    local timer_conn = nil
    local input_ended_conn = nil
    local input_changed_conn = nil

    if CoreGui:FindFirstChild("SignalTriangulationGUI") then CoreGui.SignalTriangulationGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "SignalTriangulationGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 260)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = CYAN
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// SIGNAL TRIANGULATION //"
    title.TextColor3 = CYAN
    title.Font = Enum.Font.Code
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local strength_label = Instance.new("TextLabel")
    strength_label.Size = UDim2.new(1, -20, 0, 30)
    strength_label.Position = UDim2.new(0, 10, 0, 48)
    strength_label.BackgroundTransparency = 1
    strength_label.Text = "SIGNAL: 0%"
    strength_label.TextColor3 = CYAN
    strength_label.Font = Enum.Font.Code
    strength_label.TextSize = 20
    strength_label.TextXAlignment = Enum.TextXAlignment.Center
    strength_label.Parent = frame

    local strength_bar_bg = Instance.new("Frame")
    strength_bar_bg.Size = UDim2.new(1, -40, 0, 14)
    strength_bar_bg.Position = UDim2.new(0, 20, 0, 84)
    strength_bar_bg.BackgroundColor3 = Color3.fromRGB(20, 22, 26)
    strength_bar_bg.BorderSizePixel = 0
    strength_bar_bg.Parent = frame
    Instance.new("UICorner", strength_bar_bg).CornerRadius = UDim.new(0, 8)

    local strength_bar_fill = Instance.new("Frame")
    strength_bar_fill.Size = UDim2.new(0, 0, 1, 0)
    strength_bar_fill.BackgroundColor3 = CYAN
    strength_bar_fill.BorderSizePixel = 0
    strength_bar_fill.Parent = strength_bar_bg
    Instance.new("UICorner", strength_bar_fill).CornerRadius = UDim.new(0, 8)

    local slider_bg = Instance.new("Frame")
    slider_bg.Size = UDim2.new(1, -40, 0, 8)
    slider_bg.Position = UDim2.new(0, 20, 0, 150)
    slider_bg.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
    slider_bg.BorderSizePixel = 0
    slider_bg.Parent = frame
    Instance.new("UICorner", slider_bg).CornerRadius = UDim.new(0, 4)

    local handle = Instance.new("TextButton")
    handle.Size = UDim2.new(0, 24, 0, 24)
    handle.AnchorPoint = Vector2.new(0.5, 0.5)
    handle.Position = UDim2.new(handle_pos / 100, 0, 0.5, 0)
    handle.BackgroundColor3 = WHITE
    handle.Text = ""
    handle.BorderSizePixel = 0
    handle.Parent = slider_bg
    Instance.new("UICorner", handle).CornerRadius = UDim.new(0.5, 0)

    local lock_btn = Instance.new("TextButton")
    lock_btn.Size = UDim2.new(0, 140, 0, 36)
    lock_btn.AnchorPoint = Vector2.new(0.5, 0)
    lock_btn.Position = UDim2.new(0.5, 0, 0, 190)
    lock_btn.BackgroundColor3 = Color3.fromRGB(20, 34, 36)
    lock_btn.Text = "LOCK SIGNAL"
    lock_btn.Font = Enum.Font.GothamBold
    lock_btn.TextSize = 13
    lock_btn.TextColor3 = CYAN
    lock_btn.BorderSizePixel = 0
    lock_btn.Parent = frame
    Instance.new("UICorner", lock_btn).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", lock_btn).Color = CYAN

    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if input_ended_conn then input_ended_conn:Disconnect() end
        if input_changed_conn then input_changed_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.signal_triangulation_cooldown = tick()
        if g.notify then g.notify("Success", "Signal triangulated!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Signal lost!", 5) end
        task.delay(0.5, cleanup)
    end

    local function update_strength()
        local diff = math.abs(handle_pos - target_pos)
        local strength = math.clamp(100 - diff * 2, 0, 100)
        strength_label.Text = "SIGNAL: " .. math.floor(strength) .. "%"
        strength_bar_fill.Size = UDim2.new(strength / 100, 0, 1, 0)
        strength_bar_fill.BackgroundColor3 = strength > 80 and GREEN or CYAN
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)

    input_ended_conn = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    input_changed_conn = UserInputService.InputChanged:Connect(function(input)
        if not dragging or game_over then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local bar_pos = slider_bg.AbsolutePosition.X
        local bar_size = slider_bg.AbsoluteSize.X
        local mouse_x = input.Position.X
        local scale = math.clamp((mouse_x - bar_pos) / bar_size, 0, 1)
        handle_pos = scale * 100
        handle.Position = UDim2.new(scale, 0, 0.5, 0)
        update_strength()
    end)

    lock_btn.MouseButton1Click:Connect(function()
        if game_over then return end
        if math.abs(handle_pos - target_pos) <= TOLERANCE then
            win()
        else
            fail("Signal lost!")
        end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Signal triangulation cancelled.", 3) end
        cleanup()
    end)

    update_strength()

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        if DRIFT_SPEED > 0 then
            target_pos = target_pos + DRIFT_SPEED * dt * drift_dir
            if target_pos >= 95 then drift_dir = -1 end
            if target_pos <= 5 then drift_dir = 1 end
            update_strength()
        end
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up!")
            return
        end
        local mins = math.floor(left / 60)
        local secs = math.floor(left % 60)
        timer_label.Text = string.format("%02d:%02d", mins, secs)
        if left <= 5 then timer_label.TextColor3 = RED end
    end)
end

g.pipe_reroute_minigame = function()
    if g.pipe_reroute_cooldown and tick() - g.pipe_reroute_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.pipe_reroute_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("pipe")
    local DARK = Color3.fromRGB(14, 16, 14)
    local TEAL = Color3.fromRGB(60, 200, 170)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local MUTED = Color3.fromRGB(90, 100, 95)
    local GOLD = Color3.fromRGB(210, 170, 60)
    local RED = Color3.fromRGB(200, 60, 60)
    local GRID_SIZE = preset.grid_size
    local LOCKED_COUNT = preset.locked_count
    local TIME_LIMIT = preset.time_limit
    local DELTA = {[1] = {-1, 0}, [2] = {0, 1}, [3] = {1, 0}, [4] = {0, -1}}
    local OPPOSITE = {[1] = 3, [2] = 4, [3] = 1, [4] = 2}
    local GLYPHS_STRAIGHT = {"│", "─"}
    local GLYPHS_ELBOW = {"└", "┌", "┐", "┘"}
    local grid_data = {}
    local game_over = false
    local timer_conn = nil

    for r = 1, GRID_SIZE do
        grid_data[r] = {}
        for c = 1, GRID_SIZE do
            grid_data[r][c] = {
                kind = math.random(1, 2) == 1 and "straight" or "elbow",
                rotation = math.random(0, 3),
                locked = false,
            }
        end
    end

    local locked_set = 0
    while locked_set < LOCKED_COUNT do
        local r = math.random(1, GRID_SIZE)
        local c = math.random(1, GRID_SIZE)
        if not grid_data[r][c].locked then
            grid_data[r][c].locked = true
            locked_set = locked_set + 1
        end
    end

    local function connections_for(tile)
        if tile.kind == "straight" then
            if tile.rotation % 2 == 0 then return {[1] = true, [3] = true} else return {[2] = true, [4] = true} end
        else
            local a = ((1 - 1 + tile.rotation) % 4) + 1
            local b = ((2 - 1 + tile.rotation) % 4) + 1
            return {[a] = true, [b] = true}
        end
    end

    local function glyph_for(tile)
        if tile.kind == "straight" then
            return tile.rotation % 2 == 0 and GLYPHS_STRAIGHT[1] or GLYPHS_STRAIGHT[2]
        else
            return GLYPHS_ELBOW[tile.rotation + 1]
        end
    end

    local function check_solved()
        local visited = {}
        local queue = {{1, 1}}
        visited["1_1"] = true
        while #queue > 0 do
            local cur = table.remove(queue)
            local r, c = cur[1], cur[2]
            if r == GRID_SIZE and c == GRID_SIZE then return true end
            local conns = connections_for(grid_data[r][c])
            for dir, open in pairs(conns) do
                if open then
                    local delta = DELTA[dir]
                    local nr, nc = r + delta[1], c + delta[2]
                    if nr >= 1 and nr <= GRID_SIZE and nc >= 1 and nc <= GRID_SIZE then
                        local key = nr .. "_" .. nc
                        if not visited[key] then
                            local neighbor_conns = connections_for(grid_data[nr][nc])
                            if neighbor_conns[OPPOSITE[dir]] then
                                visited[key] = true
                                table.insert(queue, {nr, nc})
                            end
                        end
                    end
                end
            end
        end
        return false
    end

    if CoreGui:FindFirstChild("PipeRerouteGUI") then CoreGui.PipeRerouteGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "PipeRerouteGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local cell_size = 52
    local grid_pixel = GRID_SIZE * cell_size
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, grid_pixel + 100, 0, grid_pixel + 130)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = TEAL
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// PIPE REROUTE //"
    title.TextColor3 = TEAL
    title.Font = Enum.Font.Code
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.6, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local hint_label = Instance.new("TextLabel")
    hint_label.Size = UDim2.new(1, -20, 0, 20)
    hint_label.Position = UDim2.new(0, 10, 0, 44)
    hint_label.BackgroundTransparency = 1
    hint_label.Text = "Connect top-left to bottom-right."
    hint_label.TextColor3 = MUTED
    hint_label.Font = Enum.Font.Code
    hint_label.TextSize = 11
    hint_label.TextScaled = true
    hint_label.TextXAlignment = Enum.TextXAlignment.Left
    hint_label.Parent = frame

    local grid_frame = Instance.new("Frame")
    grid_frame.Size = UDim2.new(0, grid_pixel, 0, grid_pixel)
    grid_frame.AnchorPoint = Vector2.new(0.5, 0)
    grid_frame.Position = UDim2.new(0.5, 0, 0, 70)
    grid_frame.BackgroundTransparency = 1
    grid_frame.Parent = frame

    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.pipe_reroute_cooldown = tick()
        if g.notify then g.notify("Success", "Circuit rerouted!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Time's up!", 5) end
        task.delay(0.5, cleanup)
    end

    for r = 1, GRID_SIZE do
        for c = 1, GRID_SIZE do
            local tile = grid_data[r][c]
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, cell_size - 6, 0, cell_size - 6)
            btn.Position = UDim2.new(0, (c - 1) * cell_size, 0, (r - 1) * cell_size)
            btn.BackgroundColor3 = tile.locked and Color3.fromRGB(50, 40, 15) or Color3.fromRGB(22, 24, 22)
            btn.Text = glyph_for(tile)
            btn.Font = Enum.Font.Code
            btn.TextSize = 26
            btn.TextColor3 = tile.locked and GOLD or TEAL
            btn.BorderSizePixel = 0
            btn.Parent = grid_frame
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

            btn.MouseButton1Click:Connect(function()
                if game_over or tile.locked then return end
                tile.rotation = (tile.rotation + 1) % 4
                btn.Text = glyph_for(tile)
                if check_solved() then win() end
            end)
        end
    end

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Pipe reroute cancelled.", 3) end
        cleanup()
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up!")
            return
        end
        local mins = math.floor(left / 60)
        local secs = math.floor(left % 60)
        timer_label.Text = string.format("%02d:%02d", mins, secs)
        if left <= 5 then timer_label.TextColor3 = RED end
    end)

    if check_solved() then win() end
end

g.steady_hand_minigame = function()
    if g.steady_hand_cooldown and tick() - g.steady_hand_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.steady_hand_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("steady")
    local DARK = Color3.fromRGB(14, 14, 16)
    local ORANGE = Color3.fromRGB(230, 140, 40)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED = Color3.fromRGB(200, 60, 60)
    local GREEN = Color3.fromRGB(60, 200, 100)
    local MUTED = Color3.fromRGB(90, 90, 100)
    local DRIFT_FORCE = preset.drift_force
    local ZONE_WIDTH = preset.zone_width
    local HOLD_DURATION = preset.hold_duration
    local TIME_LIMIT = preset.time_limit
    local needle_pos = 0.5
    local velocity = 0
    local holding = false
    local progress = 0
    local game_over = false
    local timer_conn = nil
    local heartbeat_conn = nil

    if CoreGui:FindFirstChild("SteadyHandGUI") then CoreGui.SteadyHandGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "SteadyHandGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 260)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = ORANGE
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// STEADY HAND //"
    title.TextColor3 = ORANGE
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local bar_bg = Instance.new("Frame")
    bar_bg.Size = UDim2.new(1, -40, 0, 40)
    bar_bg.Position = UDim2.new(0, 20, 0, 60)
    bar_bg.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
    bar_bg.BorderSizePixel = 0
    bar_bg.Parent = frame
    Instance.new("UICorner", bar_bg).CornerRadius = UDim.new(0, 10)

    local zone = Instance.new("Frame")
    zone.Size = UDim2.new(ZONE_WIDTH, 0, 1, 0)
    zone.Position = UDim2.new(0.5 - ZONE_WIDTH / 2, 0, 0, 0)
    zone.BackgroundColor3 = GREEN
    zone.BackgroundTransparency = 0.6
    zone.BorderSizePixel = 0
    zone.Parent = bar_bg
    Instance.new("UICorner", zone).CornerRadius = UDim.new(0, 10)

    local needle = Instance.new("Frame")
    needle.Size = UDim2.new(0, 6, 1, 10)
    needle.AnchorPoint = Vector2.new(0.5, 0.5)
    needle.Position = UDim2.new(needle_pos, 0, 0.5, 0)
    needle.BackgroundColor3 = WHITE
    needle.BorderSizePixel = 0
    needle.Parent = bar_bg
    Instance.new("UICorner", needle).CornerRadius = UDim.new(0, 3)

    local progress_bg = Instance.new("Frame")
    progress_bg.Size = UDim2.new(1, -40, 0, 14)
    progress_bg.Position = UDim2.new(0, 20, 0, 116)
    progress_bg.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
    progress_bg.BorderSizePixel = 0
    progress_bg.Parent = frame
    Instance.new("UICorner", progress_bg).CornerRadius = UDim.new(0, 8)

    local progress_fill = Instance.new("Frame")
    progress_fill.Size = UDim2.new(0, 0, 1, 0)
    progress_fill.BackgroundColor3 = GREEN
    progress_fill.BorderSizePixel = 0
    progress_fill.Parent = progress_bg
    Instance.new("UICorner", progress_fill).CornerRadius = UDim.new(0, 8)

    local hint_label = Instance.new("TextLabel")
    hint_label.Size = UDim2.new(1, -40, 0, 18)
    hint_label.Position = UDim2.new(0, 20, 0, 138)
    hint_label.BackgroundTransparency = 1
    hint_label.Text = "Hold STEADY to keep the needle in the zone"
    hint_label.TextColor3 = MUTED
    hint_label.Font = Enum.Font.Code
    hint_label.TextSize = 11
    hint_label.TextXAlignment = Enum.TextXAlignment.Center
    hint_label.Parent = frame

    local steady_btn = Instance.new("TextButton")
    steady_btn.Size = UDim2.new(0, 160, 0, 44)
    steady_btn.AnchorPoint = Vector2.new(0.5, 0)
    steady_btn.Position = UDim2.new(0.5, 0, 0, 168)
    steady_btn.BackgroundColor3 = Color3.fromRGB(40, 30, 16)
    steady_btn.Text = "STEADY"
    steady_btn.Font = Enum.Font.GothamBold
    steady_btn.TextSize = 14
    steady_btn.TextColor3 = ORANGE
    steady_btn.BorderSizePixel = 0
    steady_btn.Parent = frame
    Instance.new("UICorner", steady_btn).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", steady_btn).Color = ORANGE

    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if heartbeat_conn then heartbeat_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.steady_hand_cooldown = tick()
        if g.notify then g.notify("Success", "Held steady!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Hand slipped!", 5) end
        task.delay(0.5, cleanup)
    end

    steady_btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            holding = true
        end
    end)

    steady_btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            holding = false
        end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Steady hand cancelled.", 3) end
        cleanup()
    end)

    heartbeat_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        local drift = (math.random() - 0.5) * DRIFT_FORCE
        velocity = velocity + drift * dt
        if holding then
            velocity = velocity + (0.5 - needle_pos) * DRIFT_FORCE * 1.2 * dt
        end
        velocity = velocity * 0.96
        needle_pos = math.clamp(needle_pos + velocity * dt, 0, 1)
        needle.Position = UDim2.new(needle_pos, 0, 0.5, 0)

        local zone_min = 0.5 - ZONE_WIDTH / 2
        local zone_max = 0.5 + ZONE_WIDTH / 2
        if needle_pos >= zone_min and needle_pos <= zone_max then
            progress = progress + dt
            progress_fill.BackgroundColor3 = GREEN
        else
            progress = math.max(0, progress - dt * 2)
            progress_fill.BackgroundColor3 = RED
        end
        progress_fill.Size = UDim2.new(math.clamp(progress / HOLD_DURATION, 0, 1), 0, 1, 0)
        if progress >= HOLD_DURATION then
            win()
        end
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up!")
            return
        end
        local mins = math.floor(left / 60)
        local secs = math.floor(left % 60)
        timer_label.Text = string.format("%02d:%02d", mins, secs)
        if left <= 5 then timer_label.TextColor3 = RED end
    end)
end

g.rhythm_splice_minigame = function()
    if g.rhythm_splice_cooldown and tick() - g.rhythm_splice_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.rhythm_splice_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("rhythm")
    local DARK = Color3.fromRGB(12, 12, 18)
    local PINK = Color3.fromRGB(230, 80, 160)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local NOTE_COUNT = preset.note_count
    local NOTE_SPEED = preset.note_speed
    local HIT_WINDOW = preset.hit_window
    local MAX_MISSES = preset.max_misses
    local spawn_interval = 1.1
    local notes_spawned = 0
    local notes_resolved = 0
    local misses = 0
    local active_notes = {}
    local game_over = false
    local elapsed = 0
    local next_spawn = 0
    local render_conn = nil
    if CoreGui:FindFirstChild("RhythmSpliceGUI") then CoreGui.RhythmSpliceGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "RhythmSpliceGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 220)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = PINK
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.6, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// RHYTHM SPLICE //"
    title.TextColor3 = PINK
    title.Font = Enum.Font.Code
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local status_label = Instance.new("TextLabel")
    status_label.Size = UDim2.new(0.35, 0, 0, 36)
    status_label.Position = UDim2.new(0.62, 0, 0, 6)
    status_label.BackgroundTransparency = 1
    status_label.Text = "Misses: 0 / " .. MAX_MISSES
    status_label.TextColor3 = WHITE
    status_label.Font = Enum.Font.Code
    status_label.TextSize = 12
    status_label.TextXAlignment = Enum.TextXAlignment.Right
    status_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local lane = Instance.new("Frame")
    lane.Size = UDim2.new(1, -40, 0, 60)
    lane.Position = UDim2.new(0, 20, 0, 60)
    lane.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    lane.BorderSizePixel = 0
    lane.ClipsDescendants = true
    lane.Parent = frame
    Instance.new("UICorner", lane).CornerRadius = UDim.new(0, 10)

    local hit_line = Instance.new("Frame")
    hit_line.Size = UDim2.new(0, 4, 1, 0)
    hit_line.Position = UDim2.new(0, 40, 0, 0)
    hit_line.BackgroundColor3 = PINK
    hit_line.BorderSizePixel = 0
    hit_line.Parent = lane
    Instance.new("UICorner", hit_line).CornerRadius = UDim.new(0, 2)

    local hit_btn = Instance.new("TextButton")
    hit_btn.Size = UDim2.new(0, 160, 0, 44)
    hit_btn.AnchorPoint = Vector2.new(0.5, 0)
    hit_btn.Position = UDim2.new(0.5, 0, 0, 140)
    hit_btn.BackgroundColor3 = Color3.fromRGB(40, 16, 30)
    hit_btn.Text = "HIT"
    hit_btn.Font = Enum.Font.GothamBold
    hit_btn.TextSize = 16
    hit_btn.TextColor3 = PINK
    hit_btn.BorderSizePixel = 0
    hit_btn.Parent = frame
    Instance.new("UICorner", hit_btn).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", hit_btn).Color = PINK

    local function cleanup()
        if render_conn then render_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.rhythm_splice_cooldown = tick()
        if g.notify then g.notify("Success", "Perfect splice!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Splice failed!", 5) end
        task.delay(0.5, cleanup)
    end

    local function register_miss()
        misses = misses + 1
        notes_resolved = notes_resolved + 1
        status_label.Text = "Misses: " .. misses .. " / " .. MAX_MISSES
        if misses >= MAX_MISSES then
            fail("Too many misses!")
        elseif notes_resolved >= NOTE_COUNT and not game_over then
            win()
        end
    end

    local function register_hit()
        notes_resolved = notes_resolved + 1
        if notes_resolved >= NOTE_COUNT and not game_over then win() end
    end

    hit_btn.MouseButton1Click:Connect(function()
        if game_over then return end
        local best_index = nil
        local best_dist = math.huge
        for i, note in ipairs(active_notes) do
            local dist = math.abs(note.frame.Position.X.Offset - 40)
            if dist < best_dist then
                best_dist = dist
                best_index = i
            end
        end
        if best_index and best_dist <= HIT_WINDOW * NOTE_SPEED then
            active_notes[best_index].frame:Destroy()
            table.remove(active_notes, best_index)
            register_hit()
        end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Rhythm splice cancelled.", 3) end
        cleanup()
    end)

    render_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        elapsed = elapsed + dt
        local lane_width = lane.AbsoluteSize.X

        if notes_spawned < NOTE_COUNT and elapsed >= next_spawn then
            notes_spawned = notes_spawned + 1
            next_spawn = elapsed + spawn_interval
            local note = Instance.new("Frame")
            note.Size = UDim2.new(0, 26, 0, 26)
            note.AnchorPoint = Vector2.new(0.5, 0.5)
            note.Position = UDim2.new(0, lane_width - 20, 0.5, 0)
            note.BackgroundColor3 = PINK
            note.BorderSizePixel = 0
            note.Parent = lane
            Instance.new("UICorner", note).CornerRadius = UDim.new(0.5, 0)
            table.insert(active_notes, {frame = note, spawn_time = elapsed})
        end

        for i = #active_notes, 1, -1 do
            local note = active_notes[i]
            local traveled = NOTE_SPEED * (elapsed - note.spawn_time)
            local new_x = (lane_width - 20) - traveled
            note.frame.Position = UDim2.new(0, new_x, 0.5, 0)
            if new_x < 40 - HIT_WINDOW * NOTE_SPEED then
                note.frame:Destroy()
                table.remove(active_notes, i)
                register_miss()
            end
        end
    end)
end

g.card_recall_minigame = function()
    if g.card_recall_cooldown and tick() - g.card_recall_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.card_recall_cooldown))
        if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
        return
    end

    local preset = get_preset("recall")
    local DARK = Color3.fromRGB(14, 12, 18)
    local PURPLE = Color3.fromRGB(160, 100, 220)
    local DIM_PURPLE = Color3.fromRGB(50, 40, 70)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED = Color3.fromRGB(200, 60, 60)
    local GREEN = Color3.fromRGB(60, 200, 100)
    local CARD_COUNT = preset.card_count
    local SHOW_TIME = preset.show_time
    local GRID_COLS = preset.grid_cols
    local reveal_order = {}
    for i = 1, CARD_COUNT do reveal_order[i] = i end
    for i = CARD_COUNT, 2, -1 do
        local j = math.random(1, i)
        reveal_order[i], reveal_order[j] = reveal_order[j], reveal_order[i]
    end

    local player_index = 1
    local accepting_input = false
    local game_over = false
    if CoreGui:FindFirstChild("CardRecallGUI") then CoreGui.CardRecallGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "CardRecallGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true
    local grid_rows = math.ceil(CARD_COUNT / GRID_COLS)
    local cell_size = 64
    local grid_width = GRID_COLS * cell_size
    local grid_height = grid_rows * cell_size
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, grid_width + 40, 0, grid_height + 110)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = PURPLE
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// VAULT RECALL //"
    title.TextColor3 = PURPLE
    title.Font = Enum.Font.Code
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local status_label = Instance.new("TextLabel")
    status_label.Size = UDim2.new(1, -20, 0, 22)
    status_label.Position = UDim2.new(0, 10, 0, 44)
    status_label.BackgroundTransparency = 1
    status_label.Text = "Watch the sequence..."
    status_label.TextColor3 = DIM_PURPLE
    status_label.Font = Enum.Font.Code
    status_label.TextSize = 12
    status_label.TextXAlignment = Enum.TextXAlignment.Center
    status_label.Parent = frame

    local grid_frame = Instance.new("Frame")
    grid_frame.Size = UDim2.new(0, grid_width, 0, grid_height)
    grid_frame.AnchorPoint = Vector2.new(0.5, 0)
    grid_frame.Position = UDim2.new(0.5, 0, 0, 74)
    grid_frame.BackgroundTransparency = 1
    grid_frame.Parent = frame

    local card_buttons = {}
    for i = 1, CARD_COUNT do
        local row = math.floor((i - 1) / GRID_COLS)
        local col = (i - 1) % GRID_COLS
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, cell_size - 8, 0, cell_size - 8)
        btn.Position = UDim2.new(0, col * cell_size, 0, row * cell_size)
        btn.BackgroundColor3 = DIM_PURPLE
        btn.Text = "?"
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.TextColor3 = WHITE
        btn.BorderSizePixel = 0
        btn.Parent = grid_frame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        card_buttons[i] = btn
    end

    local function cleanup() getgenv().Keybind_Input_Disabled_For_Mini_Game = false; if gui then gui:Destroy() end end
    local function win()
        game_over = true
        g.card_recall_cooldown = tick()
        if g.notify then g.notify("Success", "Vault sequence recalled!", 5) end
        task.delay(0.4, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Wrong card!", 5) end
        task.delay(0.4, cleanup)
    end

    local function show_sequence(step)
        if step > CARD_COUNT then
            status_label.Text = "Your turn! Repeat the sequence"
            status_label.TextColor3 = WHITE
            accepting_input = true
            return
        end
        local card_index = reveal_order[step]
        local btn = card_buttons[card_index]
        btn.BackgroundColor3 = PURPLE
        btn.Text = tostring(step)
        task.delay(SHOW_TIME, function()
            if game_over then return end
            btn.BackgroundColor3 = DIM_PURPLE
            btn.Text = "?"
            task.delay(0.15, function()
                show_sequence(step + 1)
            end)
        end)
    end

    for i, btn in ipairs(card_buttons) do
        btn.MouseButton1Click:Connect(function()
            if game_over or not accepting_input then return end
            if reveal_order[player_index] == i then
                btn.BackgroundColor3 = GREEN
                player_index = player_index + 1
                if player_index > CARD_COUNT then
                    win()
                end
            else
                btn.BackgroundColor3 = RED
                fail("Wrong card!")
            end
        end)
    end

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Vault recall cancelled.", 3) end
        cleanup()
    end)

    task.delay(0.6, function() show_sequence(1) end)
end

g.morse_minigame = function()
    if g.morse_minigame_cooldown and tick() - g.morse_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.morse_minigame_cooldown))
        if g.notify then g.notify("Warning", "Wait " .. remaining .. "s.", 5) end
        return
    end

    local preset = get_preset("morse")
    local DARK  = Color3.fromRGB(12, 12, 16)
    local AMBER = Color3.fromRGB(230, 160, 40)
    local DIM   = Color3.fromRGB(60, 45, 10)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED   = Color3.fromRGB(200, 60, 60)
    local MUTED = Color3.fromRGB(100, 100, 110)
    local MORSE_TABLE = {
        A=".-",  B="-...", C="-.-.", D="-..",  E=".",    F="..-.",
        G="--.",  H="....", I="..",   J=".---", K="-.-",  L=".-..",
        M="--",   N="-.",   O="---",  P=".--.", Q="--.-", R=".-.",
        S="...",  T="-",    U="..-",  V="...-", W=".--",  X="-..-",
        Y="-.--", Z="--..",
    }
    local ALPHA = {}
    for k in pairs(MORSE_TABLE) do table.insert(ALPHA, k) end
    local sequence = {}
    for i = 1, preset.sequence_length do
        local letter = ALPHA[math.random(1, #ALPHA)]
        table.insert(sequence, {letter = letter, code = MORSE_TABLE[letter]})
    end

    local current_letter = 1
    local player_input   = ""
    local game_over      = false
    local playing        = false
    local timer_conn     = nil
    local dot_btn_ref    = nil
    local dash_btn_ref   = nil
    local submit_btn_ref = nil

    if CoreGui:FindFirstChild("MorseGUI") then CoreGui.MorseGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "MorseGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 300)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = AMBER
    fstroke.Thickness = 1.5

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// MORSE DECODER //"
    title.TextColor3 = AMBER
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", preset.time_limit)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local progress_lbl = Instance.new("TextLabel")
    progress_lbl.Size = UDim2.new(1, -20, 0, 20)
    progress_lbl.Position = UDim2.new(0, 10, 0, 44)
    progress_lbl.BackgroundTransparency = 1
    progress_lbl.Text = "Letter 1 of " .. preset.sequence_length
    progress_lbl.TextColor3 = MUTED
    progress_lbl.Font = Enum.Font.Code
    progress_lbl.TextSize = 12
    progress_lbl.TextXAlignment = Enum.TextXAlignment.Left
    progress_lbl.Parent = frame

    local flash_indicator = Instance.new("Frame")
    flash_indicator.Size = UDim2.new(0, 60, 0, 60)
    flash_indicator.AnchorPoint = Vector2.new(0.5, 0)
    flash_indicator.Position = UDim2.new(0.5, 0, 0, 72)
    flash_indicator.BackgroundColor3 = DIM
    flash_indicator.BorderSizePixel = 0
    flash_indicator.Parent = frame
    Instance.new("UICorner", flash_indicator).CornerRadius = UDim.new(0.5, 0)

    local input_display = Instance.new("TextLabel")
    input_display.Size = UDim2.new(1, -20, 0, 28)
    input_display.Position = UDim2.new(0, 10, 0, 146)
    input_display.BackgroundTransparency = 1
    input_display.Text = "Input: "
    input_display.TextColor3 = AMBER
    input_display.Font = Enum.Font.Code
    input_display.TextSize = 20
    input_display.TextXAlignment = Enum.TextXAlignment.Center
    input_display.Parent = frame

    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.morse_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Morse decoded!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Decode failed!", 5) end
        task.delay(0.5, cleanup)
    end

    local function set_input_locked(locked)
        if dot_btn_ref then dot_btn_ref.Active = not locked; dot_btn_ref.BackgroundTransparency = locked and 0.6 or 0 end
        if dash_btn_ref then dash_btn_ref.Active = not locked; dash_btn_ref.BackgroundTransparency = locked and 0.6 or 0 end
        if submit_btn_ref then submit_btn_ref.Active = not locked; submit_btn_ref.BackgroundTransparency = locked and 0.6 or 0 end
    end

    local function play_letter(idx, callback)
        if game_over then return end
        playing = true
        set_input_locked(true)
        local code = sequence[idx].code
        local function play_symbol(s_idx)
            if game_over then return end
            if s_idx > #code then
                playing = false
                set_input_locked(false)
                if callback then callback() end
                return
            end
            local sym = code:sub(s_idx, s_idx)
            local duration = sym == "." and preset.dit_duration or preset.dit_duration * 3
            flash_indicator.BackgroundColor3 = AMBER
            task.delay(duration, function()
                if game_over then return end
                flash_indicator.BackgroundColor3 = DIM
                task.delay(preset.gap_duration, function()
                    play_symbol(s_idx + 1)
                end)
            end)
        end
        play_symbol(1)
    end

    local btn_row = Instance.new("Frame")
    btn_row.Size = UDim2.new(1, -20, 0, 40)
    btn_row.Position = UDim2.new(0, 10, 0, 184)
    btn_row.BackgroundTransparency = 1
    btn_row.Parent = frame

    local btn_layout = Instance.new("UIListLayout")
    btn_layout.FillDirection = Enum.FillDirection.Horizontal
    btn_layout.Padding = UDim.new(0, 8)
    btn_layout.SortOrder = Enum.SortOrder.LayoutOrder
    btn_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    btn_layout.Parent = btn_row

    local function make_btn(text, color, order)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 80, 1, 0)
        b.BackgroundColor3 = color
        b.Text = text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 18
        b.TextColor3 = WHITE
        b.BorderSizePixel = 0
        b.LayoutOrder = order
        b.Parent = btn_row
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        return b
    end

    local dot_btn  = make_btn("•", Color3.fromRGB(60, 100, 180), 1)
    local dash_btn = make_btn("—", Color3.fromRGB(100, 60, 180), 2)
    dot_btn_ref  = dot_btn
    dash_btn_ref = dash_btn

    local clear_btn = Instance.new("TextButton")
    clear_btn.Size = UDim2.new(0, 60, 0, 26)
    clear_btn.Position = UDim2.new(0, 10, 0, 234)
    clear_btn.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
    clear_btn.Text = "CLR"
    clear_btn.Font = Enum.Font.GothamBold
    clear_btn.TextSize = 12
    clear_btn.TextColor3 = WHITE
    clear_btn.BorderSizePixel = 0
    clear_btn.Parent = frame
    Instance.new("UICorner", clear_btn).CornerRadius = UDim.new(0, 6)

    local replay_btn = Instance.new("TextButton")
    replay_btn.Size = UDim2.new(0, 80, 0, 26)
    replay_btn.AnchorPoint = Vector2.new(0.5, 0)
    replay_btn.Position = UDim2.new(0.5, 0, 0, 234)
    replay_btn.BackgroundColor3 = Color3.fromRGB(30, 50, 40)
    replay_btn.Text = "REPLAY"
    replay_btn.Font = Enum.Font.GothamBold
    replay_btn.TextSize = 12
    replay_btn.TextColor3 = WHITE
    replay_btn.BorderSizePixel = 0
    replay_btn.Parent = frame
    Instance.new("UICorner", replay_btn).CornerRadius = UDim.new(0, 6)

    local submit_btn = Instance.new("TextButton")
    submit_btn.Size = UDim2.new(0, 80, 0, 26)
    submit_btn.AnchorPoint = Vector2.new(1, 0)
    submit_btn.Position = UDim2.new(1, -10, 0, 234)
    submit_btn.BackgroundColor3 = Color3.fromRGB(30, 60, 30)
    submit_btn.Text = "SUBMIT"
    submit_btn.Font = Enum.Font.GothamBold
    submit_btn.TextSize = 12
    submit_btn.TextColor3 = WHITE
    submit_btn.BorderSizePixel = 0
    submit_btn.Parent = frame
    Instance.new("UICorner", submit_btn).CornerRadius = UDim.new(0, 6)
    submit_btn_ref = submit_btn

    local function update_display()
        input_display.Text = "Input: " .. player_input
    end

    dot_btn.MouseButton1Click:Connect(function()
        if game_over or playing then return end
        player_input = player_input .. "."
        update_display()
    end)

    dash_btn.MouseButton1Click:Connect(function()
        if game_over or playing then return end
        player_input = player_input .. "-"
        update_display()
    end)

    clear_btn.MouseButton1Click:Connect(function()
        if game_over or playing then return end
        player_input = ""
        update_display()
    end)

    replay_btn.MouseButton1Click:Connect(function()
        if game_over or playing then return end
        player_input = ""
        update_display()
        play_letter(current_letter, nil)
    end)

    submit_btn.MouseButton1Click:Connect(function()
        if game_over or playing then return end
        local expected = sequence[current_letter].code
        if player_input == expected then
            current_letter = current_letter + 1
            player_input = ""
            update_display()
            if current_letter > preset.sequence_length then
                win()
            else
                progress_lbl.Text = "Letter " .. current_letter .. " of " .. preset.sequence_length
                task.delay(0.3, function() play_letter(current_letter, nil) end)
            end
        else
            fail("Wrong code! Expected: " .. expected)
        end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Morse cancelled.", 3) end
        cleanup()
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = preset.time_limit - time_elapsed
        if left <= 0 then timer_label.Text = "00:00"; fail("Time's up!"); return end
        timer_label.Text = string.format("%02d:%02d", math.floor(left / 60), math.floor(left % 60))
        if left <= 5 then timer_label.TextColor3 = RED end
    end)

    play_letter(1, nil)
end

g.frequency_minigame = function()
    if g.frequency_minigame_cooldown and tick() - g.frequency_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.frequency_minigame_cooldown))
        if g.notify then g.notify("Warning", "Wait " .. remaining .. "s.", 5) end
        return
    end

    local preset = get_preset("frequency")
    local DARK  = Color3.fromRGB(10, 14, 18)
    local CYAN  = Color3.fromRGB(60, 210, 230)
    local WHITE = Color3.fromRGB(240, 240, 240)
    local RED   = Color3.fromRGB(200, 60, 60)
    local GREEN = Color3.fromRGB(60, 200, 100)
    local MUTED = Color3.fromRGB(90, 100, 110)
    local DIM   = Color3.fromRGB(20, 30, 35)

    local BAND_COUNT  = preset.band_count
    local DRIFT_SPEED = preset.drift_speed
    local TOLERANCE   = preset.tolerance
    local TIME_LIMIT  = preset.time_limit

    local bands = {}
    for i = 1, BAND_COUNT do
        bands[i] = {
            target = math.random(15, 85) / 100,
            handle = 0.5,
            drift  = (math.random() > 0.5 and 1 or -1),
            locked = false,
        }
    end

    local game_over   = false
    local timer_conn  = nil
    local dragging    = nil
    local handle_refs = {}
    local UIS = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")

    if CoreGui:FindFirstChild("FrequencyGUI") then CoreGui.FrequencyGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "FrequencyGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true

    local ROW_H = 58
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, BAND_COUNT * ROW_H + 130)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = CYAN
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// FREQUENCY TUNER //"
    title.TextColor3 = CYAN
    title.Font = Enum.Font.Code
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(1, -20, 0, 18)
    hint.Position = UDim2.new(0, 10, 0, 44)
    hint.BackgroundTransparency = 1
    hint.Text = "Drag all bands into the green zone, then LOCK."
    hint.TextColor3 = MUTED
    hint.Font = Enum.Font.Code
    hint.TextSize = 11
    hint.TextXAlignment = Enum.TextXAlignment.Left
    hint.Parent = frame

    local rows_holder = Instance.new("Frame")
    rows_holder.Size = UDim2.new(1, -20, 0, BAND_COUNT * ROW_H)
    rows_holder.Position = UDim2.new(0, 10, 0, 66)
    rows_holder.BackgroundTransparency = 1
    rows_holder.Parent = frame

    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.frequency_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "All frequencies locked!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Signal lost!", 5) end
        task.delay(0.5, cleanup)
    end

    local function check_all_locked()
        for _, b in ipairs(bands) do
            if not b.locked then return end
        end
        win()
    end

    for i, band in ipairs(bands) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, ROW_H - 10)
        row.Position = UDim2.new(0, 0, 0, (i - 1) * ROW_H)
        row.BackgroundColor3 = DIM
        row.BorderSizePixel = 0
        row.Parent = rows_holder
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 50, 0, 14)
        lbl.Position = UDim2.new(0, 6, 0, 4)
        lbl.BackgroundTransparency = 1
        lbl.Text = "BAND " .. i
        lbl.Font = Enum.Font.Code
        lbl.TextSize = 10
        lbl.TextColor3 = MUTED
        lbl.Parent = row

        local track_bg = Instance.new("Frame")
        track_bg.Size = UDim2.new(1, -100, 0, 10)
        track_bg.Position = UDim2.new(0, 6, 0, 22)
        track_bg.BackgroundColor3 = Color3.fromRGB(25, 30, 34)
        track_bg.BorderSizePixel = 0
        track_bg.Parent = row
        Instance.new("UICorner", track_bg).CornerRadius = UDim.new(0, 5)

        local zone_marker = Instance.new("Frame")
        zone_marker.Size = UDim2.new(TOLERANCE * 2, 0, 1, 4)
        zone_marker.AnchorPoint = Vector2.new(0.5, 0.5)
        zone_marker.Position = UDim2.new(band.target, 0, 0.5, 0)
        zone_marker.BackgroundColor3 = GREEN
        zone_marker.BackgroundTransparency = 0.5
        zone_marker.BorderSizePixel = 0
        zone_marker.Parent = track_bg
        Instance.new("UICorner", zone_marker).CornerRadius = UDim.new(0, 4)

        local handle = Instance.new("TextButton")
        handle.Size = UDim2.new(0, 16, 0, 18)
        handle.AnchorPoint = Vector2.new(0.5, 0.5)
        handle.Position = UDim2.new(band.handle, 0, 0.5, 0)
        handle.BackgroundColor3 = WHITE
        handle.Text = ""
        handle.BorderSizePixel = 0
        handle.Parent = track_bg
        Instance.new("UICorner", handle).CornerRadius = UDim.new(0, 4)

        local lock_btn = Instance.new("TextButton")
        lock_btn.Size = UDim2.new(0, 70, 0, 26)
        lock_btn.AnchorPoint = Vector2.new(1, 0.5)
        lock_btn.Position = UDim2.new(1, -4, 0.5, 4)
        lock_btn.BackgroundColor3 = Color3.fromRGB(30, 40, 30)
        lock_btn.Text = "LOCK"
        lock_btn.Font = Enum.Font.GothamBold
        lock_btn.TextSize = 11
        lock_btn.TextColor3 = CYAN
        lock_btn.BorderSizePixel = 0
        lock_btn.Parent = row
        Instance.new("UICorner", lock_btn).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", lock_btn).Color = CYAN

        handle_refs[i] = {handle = handle, track = track_bg, band = band, lock_btn = lock_btn}

        local band_idx = i
        handle.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = band_idx
            end
        end)

        lock_btn.MouseButton1Click:Connect(function()
            if game_over or band.locked then return end
            if math.abs(band.handle - band.target) <= TOLERANCE then
                band.locked = true
                handle.BackgroundColor3 = GREEN
                lock_btn.Text = "✓ LOCKED"
                lock_btn.TextColor3 = GREEN
                check_all_locked()
            else
                if g.notify then g.notify("Warning", "Band " .. band_idx .. " not in range.", 3) end
            end
        end)
    end

    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = nil
        end
    end)

    UIS.InputChanged:Connect(function(inp)
        if not dragging or game_over then return end
        if inp.UserInputType ~= Enum.UserInputType.MouseMovement and inp.UserInputType ~= Enum.UserInputType.Touch then return end
        local ref = handle_refs[dragging]
        if not ref or ref.band.locked then return end
        local bar_pos  = ref.track.AbsolutePosition.X
        local bar_size = ref.track.AbsoluteSize.X
        local new_scale = math.clamp((inp.Position.X - bar_pos) / bar_size, 0, 1)
        ref.band.handle = new_scale
        ref.handle.Position = UDim2.new(new_scale, 0, 0.5, 0)
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Frequency tuner cancelled.", 3) end
        cleanup()
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then timer_label.Text = "00:00"; fail("Time's up!"); return end
        for i, ref in ipairs(handle_refs) do
            if not ref.band.locked then
                ref.band.handle = math.clamp(ref.band.handle + ref.band.drift * DRIFT_SPEED * dt, 0, 1)
                ref.handle.Position = UDim2.new(ref.band.handle, 0, 0.5, 0)
                if ref.band.handle >= 0.99 or ref.band.handle <= 0.01 then ref.band.drift = -ref.band.drift end
            end
        end
        timer_label.Text = string.format("%02d:%02d", math.floor(left / 60), math.floor(left % 60))
        if left <= 5 then timer_label.TextColor3 = RED end
    end)
end

g.overload_minigame = function()
    if g.overload_minigame_cooldown and tick() - g.overload_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.overload_minigame_cooldown))
        if g.notify then g.notify("Warning", "Wait " .. remaining .. "s.", 5) end
        return
    end

    local preset = get_preset("overload")
    local DARK   = Color3.fromRGB(10, 10, 14)
    local YELLOW = Color3.fromRGB(240, 200, 40)
    local WHITE  = Color3.fromRGB(240, 240, 240)
    local RED    = Color3.fromRGB(220, 60, 60)
    local GREEN  = Color3.fromRGB(60, 200, 100)
    local MUTED  = Color3.fromRGB(90, 90, 100)
    local DIM    = Color3.fromRGB(28, 28, 34)
    local NODE_COUNT     = preset.node_count
    local SURGE_INTERVAL = preset.surge_interval
    local MAX_OVERLOADS  = preset.max_overloads
    local TIME_LIMIT     = preset.time_limit
    local nodes        = {}
    local overloads    = 0
    local game_over    = false
    local timer_conn   = nil
    local surge_conn   = nil
    if CoreGui:FindFirstChild("OverloadGUI") then CoreGui.OverloadGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "OverloadGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui
    getgenv().Keybind_Input_Disabled_For_Mini_Game = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 400)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = YELLOW
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// OVERLOAD //"
    title.TextColor3 = YELLOW
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local overload_lbl = Instance.new("TextLabel")
    overload_lbl.Size = UDim2.new(1, -20, 0, 20)
    overload_lbl.Position = UDim2.new(0, 10, 0, 44)
    overload_lbl.BackgroundTransparency = 1
    overload_lbl.Text = "Overloads: 0 / " .. MAX_OVERLOADS
    overload_lbl.TextColor3 = MUTED
    overload_lbl.Font = Enum.Font.Code
    overload_lbl.TextSize = 12
    overload_lbl.TextXAlignment = Enum.TextXAlignment.Left
    overload_lbl.Parent = frame

    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(1, -20, 0, 16)
    hint.Position = UDim2.new(0, 10, 0, 62)
    hint.BackgroundTransparency = 1
    hint.Text = "Click surging nodes before they overload."
    hint.TextColor3 = MUTED
    hint.Font = Enum.Font.Code
    hint.TextSize = 11
    hint.TextXAlignment = Enum.TextXAlignment.Left
    hint.Parent = frame

    local grid_frame = Instance.new("Frame")
    grid_frame.Size = UDim2.new(1, -20, 0, 300)
    grid_frame.Position = UDim2.new(0, 10, 0, 84)
    grid_frame.BackgroundTransparency = 1
    grid_frame.Parent = frame

    local grid_layout = Instance.new("UIGridLayout")
    grid_layout.CellSize = UDim2.new(0, 80, 0, 80)
    grid_layout.CellPadding = UDim2.new(0, 10, 0, 10)
    grid_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    grid_layout.VerticalAlignment = Enum.VerticalAlignment.Center
    grid_layout.SortOrder = Enum.SortOrder.LayoutOrder
    grid_layout.Parent = grid_frame

    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if surge_conn then surge_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.overload_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Grid stabilized!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Grid overloaded!", 5) end
        task.delay(0.5, cleanup)
    end

    for i = 1, NODE_COUNT do
        local node_frame = Instance.new("Frame")
        node_frame.BackgroundColor3 = DIM
        node_frame.BorderSizePixel = 0
        node_frame.LayoutOrder = i
        node_frame.Parent = grid_frame
        Instance.new("UICorner", node_frame).CornerRadius = UDim.new(0, 12)
        Instance.new("UIStroke", node_frame).Color = Color3.fromRGB(50, 50, 60)

        local charge_bar_bg = Instance.new("Frame")
        charge_bar_bg.Size = UDim2.new(0.8, 0, 0, 8)
        charge_bar_bg.AnchorPoint = Vector2.new(0.5, 1)
        charge_bar_bg.Position = UDim2.new(0.5, 0, 1, -8)
        charge_bar_bg.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
        charge_bar_bg.BorderSizePixel = 0
        charge_bar_bg.Parent = node_frame
        Instance.new("UICorner", charge_bar_bg).CornerRadius = UDim.new(0, 4)

        local charge_fill = Instance.new("Frame")
        charge_fill.Size = UDim2.new(0, 0, 1, 0)
        charge_fill.BackgroundColor3 = GREEN
        charge_fill.BorderSizePixel = 0
        charge_fill.Parent = charge_bar_bg
        Instance.new("UICorner", charge_fill).CornerRadius = UDim.new(0, 4)

        local node_lbl = Instance.new("TextLabel")
        node_lbl.Size = UDim2.new(1, 0, 0.6, 0)
        node_lbl.Position = UDim2.new(0, 0, 0, 6)
        node_lbl.BackgroundTransparency = 1
        node_lbl.Text = "⚡"
        node_lbl.TextScaled = true
        node_lbl.Font = Enum.Font.GothamBold
        node_lbl.TextColor3 = MUTED
        node_lbl.Parent = node_frame

        local click_btn = Instance.new("TextButton")
        click_btn.Size = UDim2.fromScale(1, 1)
        click_btn.BackgroundTransparency = 1
        click_btn.Text = ""
        click_btn.Parent = node_frame

        local node_data = {
            frame      = node_frame,
            fill       = charge_fill,
            lbl        = node_lbl,
            charge     = 0,
            surging    = false,
            surge_rate = 0,
        }
        nodes[i] = node_data

        local node_idx = i
        click_btn.MouseButton1Click:Connect(function()
            if game_over then return end
            local nd = nodes[node_idx]
            if nd.surging then
                nd.surging    = false
                nd.charge     = 0
                nd.surge_rate = 0
                nd.fill.Size  = UDim2.new(0, 0, 1, 0)
                nd.fill.BackgroundColor3 = GREEN
                nd.lbl.TextColor3 = MUTED
                node_frame.BackgroundColor3 = DIM
            end
        end)
    end

    local time_elapsed  = 0
    local surge_elapsed = 0
    local surging_count = 0
    local function pick_new_surge()
        local candidates = {}
        for i, nd in ipairs(nodes) do
            if not nd.surging then table.insert(candidates, i) end
        end
        if #candidates == 0 then return end
        local pick = candidates[math.random(1, #candidates)]
        local nd = nodes[pick]
        nd.surging    = true
        nd.charge     = 0
        nd.surge_rate = math.random(18, 35) / 100
        nd.lbl.TextColor3 = YELLOW
        surging_count = surging_count + 1
    end

    surge_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed  = time_elapsed  + dt
        surge_elapsed = surge_elapsed + dt

        if surge_elapsed >= SURGE_INTERVAL then
            surge_elapsed = 0
            pick_new_surge()
        end

        for _, nd in ipairs(nodes) do
            if nd.surging then
                nd.charge = nd.charge + nd.surge_rate * dt
                local pct = math.clamp(nd.charge, 0, 1)
                nd.fill.Size = UDim2.new(pct, 0, 1, 0)
                nd.fill.BackgroundColor3 = pct < 0.5 and GREEN or (pct < 0.8 and YELLOW or RED)
                nd.frame.BackgroundColor3 = pct > 0.8 and Color3.fromRGB(50, 10, 10) or DIM
                if nd.charge >= 1 then
                    nd.surging = false
                    overloads  = overloads + 1
                    nd.charge  = 0
                    nd.fill.Size = UDim2.new(0, 0, 1, 0)
                    nd.lbl.TextColor3 = MUTED
                    nd.frame.BackgroundColor3 = DIM
                    overload_lbl.Text = "Overloads: " .. overloads .. " / " .. MAX_OVERLOADS
                    if overloads >= MAX_OVERLOADS then
                        fail("Grid overloaded!")
                        return
                    end
                end
            end
        end

        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then timer_label.Text = "00:00"; win(); return end
        timer_label.Text = string.format("%02d:%02d", math.floor(left / 60), math.floor(left % 60))
        if left <= 5 then timer_label.TextColor3 = RED end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Overload cancelled.", 3) end
        cleanup()
    end)
end

g.terminal_minigame = function()
    if g.terminal_minigame_cooldown and tick() - g.terminal_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.terminal_minigame_cooldown))
        if g.notify then g.notify("Warning", "Wait " .. remaining .. "s.", 5) end
        return
    end

    local preset = get_preset("terminal")
    local DARK   = Color3.fromRGB(10, 14, 10)
    local GREEN  = Color3.fromRGB(60, 220, 80)
    local DIM    = Color3.fromRGB(25, 35, 25)
    local WHITE  = Color3.fromRGB(240, 240, 240)
    local RED    = Color3.fromRGB(200, 60, 60)
    local YELLOW = Color3.fromRGB(230, 200, 50)
    local MUTED  = Color3.fromRGB(80, 110, 80)

    local WORD_LENGTH  = preset.word_length
    local MAX_ATTEMPTS = preset.max_attempts
    local WORD_COUNT   = preset.word_count

    local WORD_POOL_RAW = {
        "ALPHA","BRAVO","CHAIN","DELTA","EAGLE","FLARE","GHOST","HYDRA",
        "INPUT","JOKER","KNIFE","LANCE","MICRO","NERVE","ORBIT","PILOT",
        "QUAKE","RADON","SCOPE","TIGER","ULTRA","VAPOR","WITCH","XENON",
        "YIELD","ZONES","BLAST","CLOAK","DRONE","EMBER","FROST","GLIDE",
        "HAUNT","IONIC","JADED","KNEEL","LUMEN","MECHA","NEXUS","OZONE",
        "PARSE","QUERY","RELAY","SURGE","TRACE","UMBRA","VALVE","WIRED",
        "XERIC","YARNS","ZILCH","ABBOT","BARON","CEDAR","DIGIT","ENVOY",
    }

    local filtered = {}
    for _, w in ipairs(WORD_POOL_RAW) do
        if #w == WORD_LENGTH then table.insert(filtered, w) end
    end

    if #filtered < WORD_COUNT then
        local all_alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        while #filtered < WORD_COUNT + 5 do
            local w = ""
            for i = 1, WORD_LENGTH do
                local idx = math.random(1, 26)
                w = w .. all_alpha:sub(idx, idx)
            end
            local dup = false
            for _, fw in ipairs(filtered) do if fw == w then dup = true; break end end
            if not dup then table.insert(filtered, w) end
        end
    end

    local shuffled = {}
    for i = #filtered, 1, -1 do
        local j = math.random(1, i)
        filtered[i], filtered[j] = filtered[j], filtered[i]
    end
    for i = 1, WORD_COUNT do shuffled[i] = filtered[i] end

    local answer      = shuffled[math.random(1, #shuffled)]
    local attempts    = 0
    local game_over   = false
    local btn_refs    = {}

    if CoreGui:FindFirstChild("TerminalGUI") then CoreGui.TerminalGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "TerminalGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, math.max(400, WORD_COUNT * 36 + 160))
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = GREEN
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// TERMINAL HACK //"
    title.TextColor3 = GREEN
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local attempts_lbl = Instance.new("TextLabel")
    attempts_lbl.Size = UDim2.new(1, -20, 0, 20)
    attempts_lbl.Position = UDim2.new(0, 10, 0, 44)
    attempts_lbl.BackgroundTransparency = 1
    attempts_lbl.Text = "Attempts remaining: " .. MAX_ATTEMPTS
    attempts_lbl.TextColor3 = MUTED
    attempts_lbl.Font = Enum.Font.Code
    attempts_lbl.TextSize = 12
    attempts_lbl.TextXAlignment = Enum.TextXAlignment.Left
    attempts_lbl.Parent = frame

    local feedback_lbl = Instance.new("TextLabel")
    feedback_lbl.Size = UDim2.new(1, -20, 0, 20)
    feedback_lbl.Position = UDim2.new(0, 10, 0, 64)
    feedback_lbl.BackgroundTransparency = 1
    feedback_lbl.Text = "Select the correct access word."
    feedback_lbl.TextColor3 = MUTED
    feedback_lbl.Font = Enum.Font.Code
    feedback_lbl.TextSize = 11
    feedback_lbl.TextXAlignment = Enum.TextXAlignment.Left
    feedback_lbl.Parent = frame

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -100)
    scroll.Position = UDim2.new(0, 10, 0, 90)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 6)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = scroll

    local function cleanup()
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.terminal_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Access granted!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Locked out!", 5) end
        task.delay(0.5, cleanup)
    end

    local function get_likeness(a, b)
        local count = 0
        for i = 1, #a do
            if a:sub(i, i) == b:sub(i, i) then count = count + 1 end
        end
        return count
    end

    for i, word in ipairs(shuffled) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = DIM
        btn.Text = "> " .. word
        btn.Font = Enum.Font.Code
        btn.TextSize = 14
        btn.TextColor3 = GREEN
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        btn.LayoutOrder = i
        btn.Parent = scroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        local pad = Instance.new("UIPadding")
        pad.PaddingLeft = UDim.new(0, 10)
        pad.Parent = btn

        btn_refs[word] = btn

        btn.MouseButton1Click:Connect(function()
            if game_over then return end
            if word == answer then
                btn.BackgroundColor3 = Color3.fromRGB(20, 60, 20)
                btn.TextColor3 = Color3.fromRGB(100, 255, 100)
                win()
                return
            end
            attempts = attempts + 1
            local likeness = get_likeness(word, answer)
            btn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
            btn.TextColor3 = MUTED
            btn.Text = "> " .. word .. "  [" .. likeness .. "/" .. WORD_LENGTH .. "]"
            btn.Active = false
            attempts_lbl.Text = "Attempts remaining: " .. (MAX_ATTEMPTS - attempts)
            feedback_lbl.Text = likeness .. " character" .. (likeness == 1 and "" or "s") .. " match."
            feedback_lbl.TextColor3 = likeness > 0 and YELLOW or RED
            if attempts >= MAX_ATTEMPTS then
                fail("Locked out!")
            end
        end)
    end

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Terminal cancelled.", 3) end
        cleanup()
    end)
end

g.voltage_minigame = function()
    if g.voltage_minigame_cooldown and tick() - g.voltage_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.voltage_minigame_cooldown))
        if g.notify then g.notify("Warning", "Wait " .. remaining .. "s.", 5) end
        return
    end
    local preset = get_preset("voltage")
    local DARK   = Color3.fromRGB(10, 10, 16)
    local BLUE   = Color3.fromRGB(80, 140, 240)
    local WHITE  = Color3.fromRGB(240, 240, 240)
    local RED    = Color3.fromRGB(200, 60, 60)
    local GREEN  = Color3.fromRGB(60, 200, 100)
    local MUTED  = Color3.fromRGB(90, 90, 110)
    local STEP_COUNT  = preset.step_count
    local TOLERANCE   = preset.tolerance
    local SPEED       = preset.speed
    local TIME_LIMIT  = preset.time_limit
    local targets = {}
    for i = 1, STEP_COUNT do targets[i] = math.random(15, 85) / 100 end
    local current_step = 1
    local needle_pos   = 0.5
    local needle_dir   = 1
    local game_over    = false
    local timer_conn   = nil
    local render_conn  = nil
    if CoreGui:FindFirstChild("VoltageGUI") then CoreGui.VoltageGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "VoltageGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 280)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = BLUE
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// VOLTAGE REGULATOR //"
    title.TextColor3 = BLUE
    title.Font = Enum.Font.Code
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local step_lbl = Instance.new("TextLabel")
    step_lbl.Size = UDim2.new(1, -20, 0, 20)
    step_lbl.Position = UDim2.new(0, 10, 0, 44)
    step_lbl.BackgroundTransparency = 1
    step_lbl.Text = "Step 1 of " .. STEP_COUNT
    step_lbl.TextColor3 = MUTED
    step_lbl.Font = Enum.Font.Code
    step_lbl.TextSize = 12
    step_lbl.TextXAlignment = Enum.TextXAlignment.Left
    step_lbl.Parent = frame

    local bar_bg = Instance.new("Frame")
    bar_bg.Size = UDim2.new(1, -40, 0, 24)
    bar_bg.Position = UDim2.new(0, 20, 0, 78)
    bar_bg.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    bar_bg.BorderSizePixel = 0
    bar_bg.Parent = frame
    Instance.new("UICorner", bar_bg).CornerRadius = UDim.new(0, 8)

    local target_marker = Instance.new("Frame")
    target_marker.Size = UDim2.new(TOLERANCE * 2, 0, 1, 8)
    target_marker.AnchorPoint = Vector2.new(0.5, 0.5)
    target_marker.Position = UDim2.new(targets[1], 0, 0.5, 0)
    target_marker.BackgroundColor3 = GREEN
    target_marker.BackgroundTransparency = 0.5
    target_marker.BorderSizePixel = 0
    target_marker.Parent = bar_bg
    Instance.new("UICorner", target_marker).CornerRadius = UDim.new(0, 6)

    local needle = Instance.new("Frame")
    needle.Size = UDim2.new(0, 6, 1, 10)
    needle.AnchorPoint = Vector2.new(0.5, 0.5)
    needle.Position = UDim2.new(needle_pos, 0, 0.5, 0)
    needle.BackgroundColor3 = BLUE
    needle.BorderSizePixel = 0
    needle.Parent = bar_bg
    Instance.new("UICorner", needle).CornerRadius = UDim.new(0, 3)

    local tap_btn = Instance.new("TextButton")
    tap_btn.Size = UDim2.new(0, 160, 0, 44)
    tap_btn.AnchorPoint = Vector2.new(0.5, 0)
    tap_btn.Position = UDim2.new(0.5, 0, 0, 126)
    tap_btn.BackgroundColor3 = Color3.fromRGB(20, 28, 50)
    tap_btn.Text = "REGULATE"
    tap_btn.Font = Enum.Font.GothamBold
    tap_btn.TextSize = 14
    tap_btn.TextColor3 = BLUE
    tap_btn.BorderSizePixel = 0
    tap_btn.Parent = frame
    Instance.new("UICorner", tap_btn).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", tap_btn).Color = BLUE

    local feedback_lbl = Instance.new("TextLabel")
    feedback_lbl.Size = UDim2.new(1, -20, 0, 20)
    feedback_lbl.Position = UDim2.new(0, 10, 0, 182)
    feedback_lbl.BackgroundTransparency = 1
    feedback_lbl.Text = ""
    feedback_lbl.TextColor3 = GREEN
    feedback_lbl.Font = Enum.Font.Code
    feedback_lbl.TextSize = 13
    feedback_lbl.TextXAlignment = Enum.TextXAlignment.Center
    feedback_lbl.Parent = frame

    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if render_conn then render_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.voltage_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Voltage regulated!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Voltage spiked!", 5) end
        task.delay(0.5, cleanup)
    end

    tap_btn.MouseButton1Click:Connect(function()
        if game_over then return end
        local diff = math.abs(needle_pos - targets[current_step])
        if diff <= TOLERANCE then
            feedback_lbl.Text = "✓ Step " .. current_step .. " locked"
            feedback_lbl.TextColor3 = GREEN
            current_step = current_step + 1
            if current_step > STEP_COUNT then
                win()
                return
            end
            step_lbl.Text = "Step " .. current_step .. " of " .. STEP_COUNT
            target_marker.Position = UDim2.new(targets[current_step], 0, 0.5, 0)
            SPEED = SPEED + 0.15
        else
            feedback_lbl.Text = "✗ Missed"
            feedback_lbl.TextColor3 = RED
            fail("Voltage spiked!")
        end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Voltage cancelled.", 3) end
        cleanup()
    end)

    render_conn = RunService.RenderStepped:Connect(function(dt)
        if game_over then return end
        needle_pos = needle_pos + SPEED * dt * needle_dir
        if needle_pos >= 1 then needle_dir = -1 end
        if needle_pos <= 0 then needle_dir = 1 end
        needle.Position = UDim2.new(math.clamp(needle_pos, 0, 1), 0, 0.5, 0)
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then timer_label.Text = "00:00"; fail("Time's up!"); return end
        timer_label.Text = string.format("%02d:%02d", math.floor(left / 60), math.floor(left % 60))
        if left <= 5 then timer_label.TextColor3 = RED end
    end)
end

g.shadow_minigame = function()
    if g.shadow_minigame_cooldown and tick() - g.shadow_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.shadow_minigame_cooldown))
        if g.notify then g.notify("Warning", "Wait " .. remaining .. "s.", 5) end
        return
    end

    local preset = get_preset("shadow")
    local DARK   = Color3.fromRGB(10, 10, 12)
    local PURPLE = Color3.fromRGB(160, 80, 240)
    local WHITE  = Color3.fromRGB(240, 240, 240)
    local MUTED  = Color3.fromRGB(80, 80, 100)
    local DIM    = Color3.fromRGB(28, 26, 36)
    local SHAPE_COUNT   = preset.shape_count
    local DISPLAY_TIME  = preset.display_time
    local POOL_SIZE     = preset.pool_size
    local SHAPES = {"▲","■","●","◆","★","▼","▶","◀","♦","♠"}
    local sequence = {}
    for i = 1, SHAPE_COUNT do table.insert(sequence, SHAPES[math.random(1, #SHAPES)]) end
    local player_index  = 1
    local show_phase    = true
    local game_over     = false

    if CoreGui:FindFirstChild("ShadowGUI") then CoreGui.ShadowGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "ShadowGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 340)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = PURPLE
    fstroke.Thickness = 1

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// SHADOW RECALL //"
    title.TextColor3 = PURPLE
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local status_lbl = Instance.new("TextLabel")
    status_lbl.Size = UDim2.new(1, -20, 0, 22)
    status_lbl.Position = UDim2.new(0, 10, 0, 44)
    status_lbl.BackgroundTransparency = 1
    status_lbl.Text = "Memorize the sequence..."
    status_lbl.TextColor3 = MUTED
    status_lbl.Font = Enum.Font.Code
    status_lbl.TextSize = 12
    status_lbl.TextXAlignment = Enum.TextXAlignment.Center
    status_lbl.Parent = frame

    local display_frame = Instance.new("Frame")
    display_frame.Size = UDim2.new(1, -20, 0, 80)
    display_frame.Position = UDim2.new(0, 10, 0, 70)
    display_frame.BackgroundColor3 = DIM
    display_frame.BorderSizePixel = 0
    display_frame.Parent = frame
    Instance.new("UICorner", display_frame).CornerRadius = UDim.new(0, 10)

    local display_lbl = Instance.new("TextLabel")
    display_lbl.Size = UDim2.fromScale(1, 1)
    display_lbl.BackgroundTransparency = 1
    display_lbl.Text = ""
    display_lbl.TextScaled = true
    display_lbl.Font = Enum.Font.GothamBold
    display_lbl.TextColor3 = PURPLE
    display_lbl.Parent = display_frame

    local btn_grid = Instance.new("Frame")
    btn_grid.Size = UDim2.new(1, -20, 0, 160)
    btn_grid.Position = UDim2.new(0, 10, 0, 162)
    btn_grid.BackgroundTransparency = 1
    btn_grid.Parent = frame

    local grid_layout = Instance.new("UIGridLayout")
    grid_layout.CellSize = UDim2.new(0, 60, 0, 60)
    grid_layout.CellPadding = UDim2.new(0, 8, 0, 8)
    grid_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    grid_layout.VerticalAlignment = Enum.VerticalAlignment.Center
    grid_layout.SortOrder = Enum.SortOrder.LayoutOrder
    grid_layout.Parent = btn_grid

    local pool = {}
    local used = {}
    for _, s in ipairs(sequence) do used[s] = true end
    for _, s in ipairs(sequence) do
        if not pool[s] then pool[s] = true; table.insert(pool, s) end
    end
    while #pool < POOL_SIZE do
        local pick = SHAPES[math.random(1, #SHAPES)]
        if not used[pick] then
            used[pick] = true
            table.insert(pool, pick)
        end
    end
    for i = #pool, 2, -1 do
        local j = math.random(1, i)
        pool[i], pool[j] = pool[j], pool[i]
    end

    local function cleanup()
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.shadow_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Sequence recalled!", 5) end
        task.delay(0.4, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Wrong shape!", 5) end
        task.delay(0.4, cleanup)
    end

    local btn_refs_shadow = {}
    for i, shape in ipairs(pool) do
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = DIM
        btn.Text = shape
        btn.Font = Enum.Font.GothamBold
        btn.TextScaled = true
        btn.TextColor3 = WHITE
        btn.BorderSizePixel = 0
        btn.LayoutOrder = i
        btn.Active = false
        btn.Parent = btn_grid
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
        Instance.new("UIStroke", btn).Color = Color3.fromRGB(50, 40, 70)
        btn_refs_shadow[i] = {btn = btn, shape = shape}

        btn.MouseButton1Click:Connect(function()
            if game_over or show_phase then return end
            if shape == sequence[player_index] then
                btn.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
                player_index = player_index + 1
                if player_index > #sequence then win() end
            else
                btn.BackgroundColor3 = Color3.fromRGB(50, 10, 10)
                fail("Wrong shape!")
            end
        end)
    end

    local function show_sequence(idx, callback)
        if idx > #sequence then
            display_lbl.Text = "?"
            display_lbl.TextColor3 = MUTED
            show_phase = false
            status_lbl.Text = "Repeat the sequence"
            status_lbl.TextColor3 = WHITE
            for _, ref in ipairs(btn_refs_shadow) do ref.btn.Active = true end
            if callback then callback() end
            return
        end
        display_lbl.Text = sequence[idx]
        display_lbl.TextColor3 = PURPLE
        task.delay(DISPLAY_TIME, function()
            if game_over then return end
            display_lbl.Text = ""
            task.delay(0.15, function()
                show_sequence(idx + 1, callback)
            end)
        end)
    end

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Shadow recall cancelled.", 3) end
        cleanup()
    end)

    task.delay(0.5, function() show_sequence(1, nil) end)
end

g.bank_drill_minigame = function()
    if g.bank_drill_minigame_cooldown and tick() - g.bank_drill_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.bank_drill_minigame_cooldown))
        if g.notify then g.notify("Warning", "Wait " .. remaining .. "s.", 5) end
        return
    end

    local preset = get_preset("bank_drill")
    local DARK        = Color3.fromRGB(8, 8, 10)
    local WHITE       = Color3.fromRGB(240, 240, 240)
    local MUTED       = Color3.fromRGB(90, 90, 100)
    local COLD        = Color3.fromRGB(60, 160, 255)
    local WARM        = Color3.fromRGB(255, 200, 50)
    local HOT         = Color3.fromRGB(255, 100, 30)
    local CRITICAL    = Color3.fromRGB(220, 40, 40)
    local GREEN       = Color3.fromRGB(60, 200, 100)
    local STEEL       = Color3.fromRGB(80, 90, 100)

    local HEAT_ZONES    = preset.heat_zones
    local OVERHEAT_RATE = preset.overheat_rate
    local COOLDOWN_RATE = preset.cooldown_rate
    local SWEET_ZONE    = preset.sweet_zone
    local TIME_LIMIT    = preset.time_limit

    local zones = {}
    for i = 1, HEAT_ZONES do
        zones[i] = {
            target   = math.random(20, 80) / 100,
            cleared  = false,
        }
    end

    local current_zone    = 1
    local heat            = 0
    local drilling        = false
    local game_over       = false
    local timer_conn      = nil
    local render_conn     = nil
    local sparks_conn     = nil

    if CoreGui:FindFirstChild("BankDrillGUI") then CoreGui.BankDrillGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "BankDrillGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 480)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = STEEL
    fstroke.Thickness = 1.5

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// VAULT DRILL //"
    title.TextColor3 = STEEL
    title.Font = Enum.Font.Code
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local zone_lbl = Instance.new("TextLabel")
    zone_lbl.Size = UDim2.new(1, -20, 0, 20)
    zone_lbl.Position = UDim2.new(0, 10, 0, 44)
    zone_lbl.BackgroundTransparency = 1
    zone_lbl.Text = "Drill Point 1 of " .. HEAT_ZONES
    zone_lbl.TextColor3 = MUTED
    zone_lbl.Font = Enum.Font.Code
    zone_lbl.TextSize = 12
    zone_lbl.TextXAlignment = Enum.TextXAlignment.Left
    zone_lbl.Parent = frame

    local hint_lbl = Instance.new("TextLabel")
    hint_lbl.Size = UDim2.new(1, -20, 0, 16)
    hint_lbl.Position = UDim2.new(0, 10, 0, 62)
    hint_lbl.BackgroundTransparency = 1
    hint_lbl.Text = "Hold DRILL in the green heat zone. Release to cool down."
    hint_lbl.TextColor3 = MUTED
    hint_lbl.Font = Enum.Font.Code
    hint_lbl.TextSize = 10
    hint_lbl.TextXAlignment = Enum.TextXAlignment.Left
    hint_lbl.Parent = frame

    local vault_frame = Instance.new("Frame")
    vault_frame.Size = UDim2.new(1, -40, 0, 160)
    vault_frame.Position = UDim2.new(0, 20, 0, 84)
    vault_frame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
    vault_frame.BorderSizePixel = 0
    vault_frame.Parent = frame
    Instance.new("UICorner", vault_frame).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", vault_frame).Color = STEEL

    local heat_gradient_bg = Instance.new("Frame")
    heat_gradient_bg.Size = UDim2.new(1, -20, 0, 28)
    heat_gradient_bg.Position = UDim2.new(0, 10, 0, 16)
    heat_gradient_bg.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    heat_gradient_bg.BorderSizePixel = 0
    heat_gradient_bg.Parent = vault_frame
    Instance.new("UICorner", heat_gradient_bg).CornerRadius = UDim.new(0, 8)

    local sweet_zone_frame = Instance.new("Frame")
    sweet_zone_frame.Size = UDim2.new(SWEET_ZONE, 0, 1, 0)
    sweet_zone_frame.AnchorPoint = Vector2.new(0.5, 0.5)
    sweet_zone_frame.Position = UDim2.new(zones[1].target, 0, 0.5, 0)
    sweet_zone_frame.BackgroundColor3 = GREEN
    sweet_zone_frame.BackgroundTransparency = 0.55
    sweet_zone_frame.BorderSizePixel = 0
    sweet_zone_frame.Parent = heat_gradient_bg
    Instance.new("UICorner", sweet_zone_frame).CornerRadius = UDim.new(0, 6)

    local heat_needle = Instance.new("Frame")
    heat_needle.Size = UDim2.new(0, 5, 1, 8)
    heat_needle.AnchorPoint = Vector2.new(0.5, 0.5)
    heat_needle.Position = UDim2.new(heat, 0, 0.5, 0)
    heat_needle.BackgroundColor3 = COLD
    heat_needle.BorderSizePixel = 0
    heat_needle.Parent = heat_gradient_bg
    Instance.new("UICorner", heat_needle).CornerRadius = UDim.new(0, 3)

    local heat_fill = Instance.new("Frame")
    heat_fill.Size = UDim2.new(0, 0, 1, 0)
    heat_fill.BackgroundColor3 = COLD
    heat_fill.BackgroundTransparency = 0.7
    heat_fill.BorderSizePixel = 0
    heat_fill.Parent = heat_gradient_bg
    Instance.new("UICorner", heat_fill).CornerRadius = UDim.new(0, 8)

    local heat_label = Instance.new("TextLabel")
    heat_label.Size = UDim2.new(1, 0, 0, 20)
    heat_label.Position = UDim2.new(0, 0, 0, 50)
    heat_label.BackgroundTransparency = 1
    heat_label.Text = "HEAT: 0%"
    heat_label.TextColor3 = COLD
    heat_label.Font = Enum.Font.Code
    heat_label.TextSize = 13
    heat_label.TextXAlignment = Enum.TextXAlignment.Center
    heat_label.Parent = vault_frame

    local vision_frame = Instance.new("Frame")
    vision_frame.Size = UDim2.new(1, -20, 0, 70)
    vision_frame.Position = UDim2.new(0, 10, 0, 78)
    vision_frame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    vision_frame.BorderSizePixel = 0
    vision_frame.ClipsDescendants = true
    vision_frame.Parent = vault_frame
    Instance.new("UICorner", vision_frame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", vision_frame).Color = Color3.fromRGB(40, 40, 50)

    local vision_lbl = Instance.new("TextLabel")
    vision_lbl.Size = UDim2.new(0, 60, 0, 14)
    vision_lbl.Position = UDim2.new(0, 6, 0, 4)
    vision_lbl.BackgroundTransparency = 1
    vision_lbl.Text = "HEAT-CAM"
    vision_lbl.Font = Enum.Font.Code
    vision_lbl.TextSize = 9
    vision_lbl.TextColor3 = Color3.fromRGB(60, 60, 70)
    vision_lbl.Parent = vision_frame

    local CELL_COLS = 18
    local CELL_ROWS = 5
    local heat_cells = {}
    for r = 1, CELL_ROWS do
        heat_cells[r] = {}
        for c = 1, CELL_COLS do
            local cell = Instance.new("Frame")
            cell.Size = UDim2.new(1 / CELL_COLS, -1, 1 / CELL_ROWS, -1)
            cell.Position = UDim2.new((c - 1) / CELL_COLS, 0, (r - 1) / CELL_ROWS, 0)
            cell.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
            cell.BorderSizePixel = 0
            cell.Parent = vision_frame
            heat_cells[r][c] = cell
        end
    end

    local spark_pool = {}
    local spark_frame = Instance.new("Frame")
    spark_frame.Size = UDim2.fromScale(1, 1)
    spark_frame.BackgroundTransparency = 1
    spark_frame.Parent = vision_frame

    local function get_heat_color(t)
        if t < 0.3 then
            return COLD:Lerp(WARM, t / 0.3)
        elseif t < 0.7 then
            return WARM:Lerp(HOT, (t - 0.3) / 0.4)
        else
            return HOT:Lerp(CRITICAL, (t - 0.7) / 0.3)
        end
    end

    local function update_heat_vision(t)
        local zone_target = zones[current_zone] and zones[current_zone].target or 0.5
        for r = 1, CELL_ROWS do
            for c = 1, CELL_COLS do
                local col_scale = (c - 0.5) / CELL_COLS
                local dist = math.abs(col_scale - zone_target)
                local proximity = math.clamp(1 - dist * 3, 0, 1)
                local local_heat = math.clamp(t * proximity + math.random() * 0.06 - 0.03, 0, 1)
                heat_cells[r][c].BackgroundColor3 = get_heat_color(local_heat)
            end
        end
    end

    local function spawn_spark()
        local s = Instance.new("Frame")
        s.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        s.Position = UDim2.new(math.random(20, 80) / 100, 0, math.random(20, 80) / 100, 0)
        s.BackgroundColor3 = math.random() > 0.5 and WARM or WHITE
        s.BorderSizePixel = 0
        s.Parent = spark_frame
        Instance.new("UICorner", s).CornerRadius = UDim.new(0.5, 0)
        table.insert(spark_pool, {frame = s, life = 0, max_life = math.random(6, 14) / 100})
    end

    local drill_btn = Instance.new("TextButton")
    drill_btn.Size = UDim2.new(0, 180, 0, 52)
    drill_btn.AnchorPoint = Vector2.new(0.5, 0)
    drill_btn.Position = UDim2.new(0.5, 0, 0, 264)
    drill_btn.BackgroundColor3 = Color3.fromRGB(30, 28, 24)
    drill_btn.Text = "⚙ DRILL"
    drill_btn.Font = Enum.Font.GothamBold
    drill_btn.TextSize = 16
    drill_btn.TextColor3 = STEEL
    drill_btn.BorderSizePixel = 0
    drill_btn.Parent = frame
    Instance.new("UICorner", drill_btn).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", drill_btn).Color = STEEL

    local drill_status = Instance.new("TextLabel")
    drill_status.Size = UDim2.new(1, -20, 0, 20)
    drill_status.Position = UDim2.new(0, 10, 0, 326)
    drill_status.BackgroundTransparency = 1
    drill_status.Text = "IDLE"
    drill_status.TextColor3 = MUTED
    drill_status.Font = Enum.Font.Code
    drill_status.TextSize = 13
    drill_status.TextXAlignment = Enum.TextXAlignment.Center
    drill_status.Parent = frame

    local progress_row = Instance.new("Frame")
    progress_row.Size = UDim2.new(1, -20, 0, 22)
    progress_row.Position = UDim2.new(0, 10, 0, 354)
    progress_row.BackgroundTransparency = 1
    progress_row.Parent = frame

    local progress_layout = Instance.new("UIListLayout")
    progress_layout.FillDirection = Enum.FillDirection.Horizontal
    progress_layout.Padding = UDim.new(0, 6)
    progress_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    progress_layout.VerticalAlignment = Enum.VerticalAlignment.Center
    progress_layout.Parent = progress_row

    local zone_indicators = {}
    for i = 1, HEAT_ZONES do
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 18, 0, 18)
        dot.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        dot.BorderSizePixel = 0
        dot.LayoutOrder = i
        dot.Parent = progress_row
        Instance.new("UICorner", dot).CornerRadius = UDim.new(0.5, 0)
        Instance.new("UIStroke", dot).Color = STEEL
        zone_indicators[i] = dot
    end

    local function update_indicators()
        for i, dot in ipairs(zone_indicators) do
            if zones[i].cleared then
                dot.BackgroundColor3 = GREEN
            elseif i == current_zone then
                dot.BackgroundColor3 = WARM
            else
                dot.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            end
        end
    end

    update_indicators()

    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if render_conn then render_conn:Disconnect() end
        if sparks_conn then sparks_conn:Disconnect() end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.bank_drill_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Vault breached!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Drill overheated!", 5) end
        task.delay(0.5, cleanup)
    end

    drill_btn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drilling = true
        end
    end)

    drill_btn.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drilling = false
        end
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Drill cancelled.", 3) end
        cleanup()
    end)

    render_conn = RunService.RenderStepped:Connect(function(dt)
        if game_over then return end

        if drilling then
            heat = math.clamp(heat + OVERHEAT_RATE * dt * 0.01, 0, 1)
        else
            heat = math.clamp(heat - COOLDOWN_RATE * dt * 0.01, 0, 1)
        end

        local zone_target = zones[current_zone].target
        local in_sweet = math.abs(heat - zone_target) <= SWEET_ZONE / 2

        heat_needle.Position = UDim2.new(heat, 0, 0.5, 0)
        heat_fill.Size = UDim2.new(heat, 0, 1, 0)

        local h_color = get_heat_color(heat)
        heat_needle.BackgroundColor3 = h_color
        heat_fill.BackgroundColor3 = h_color

        heat_label.Text = "HEAT: " .. math.floor(heat * 100) .. "%"
        heat_label.TextColor3 = h_color

        if drilling then
            drill_btn.BackgroundColor3 = in_sweet and Color3.fromRGB(20, 40, 20) or Color3.fromRGB(50, 20, 10)
            drill_btn.TextColor3 = in_sweet and GREEN or HOT
            drill_status.Text = in_sweet and "✓ OPTIMAL ZONE" or "⚠ ADJUST HEAT"
            drill_status.TextColor3 = in_sweet and GREEN or HOT
        else
            drill_btn.BackgroundColor3 = Color3.fromRGB(30, 28, 24)
            drill_btn.TextColor3 = STEEL
            drill_status.Text = "COOLING..."
            drill_status.TextColor3 = COLD
        end

        update_heat_vision(heat)

        if heat >= 1 then
            fail("Drill overheated! Bit destroyed.")
            return
        end

        if drilling and in_sweet then
            zones[current_zone].cleared = true
            current_zone = current_zone + 1
            update_indicators()
            if current_zone > HEAT_ZONES then
                win()
                return
            end
            sweet_zone_frame.Position = UDim2.new(zones[current_zone].target, 0, 0.5, 0)
            zone_lbl.Text = "Drill Point " .. current_zone .. " of " .. HEAT_ZONES
            heat = 0
        end
    end)

    local spark_elapsed = 0
    sparks_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        spark_elapsed = spark_elapsed + dt
        if drilling and heat > 0.3 and spark_elapsed > 0.04 then
            spark_elapsed = 0
            spawn_spark()
        end
        for i = #spark_pool, 1, -1 do
            local sp = spark_pool[i]
            sp.life = sp.life + dt
            local alpha = 1 - (sp.life / sp.max_life)
            sp.frame.BackgroundTransparency = 1 - alpha
            sp.frame.Position = sp.frame.Position + UDim2.new(
                (math.random() - 0.5) * 0.02, 0,
                -0.01, 0
            )
            if sp.life >= sp.max_life then
                sp.frame:Destroy()
                table.remove(spark_pool, i)
            end
        end
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then timer_label.Text = "00:00"; fail("Time's up!"); return end
        timer_label.Text = string.format("%02d:%02d", math.floor(left / 60), math.floor(left % 60))
        if left <= 5 then timer_label.TextColor3 = Color3.fromRGB(200, 60, 60) end
    end)
end

g.fingerprint_minigame = function()
    if g.fingerprint_minigame_cooldown and tick() - g.fingerprint_minigame_cooldown < 30 then
        local remaining = math.ceil(30 - (tick() - g.fingerprint_minigame_cooldown))
        if g.notify then g.notify("Warning", "Wait " .. remaining .. "s.", 5) end
        return
    end

    local preset = get_preset("fingerprint")
    local DARK    = Color3.fromRGB(10, 10, 14)
    local WHITE   = Color3.fromRGB(240, 240, 240)
    local MUTED   = Color3.fromRGB(90, 90, 110)
    local COLD    = Color3.fromRGB(60, 140, 255)
    local WARM    = Color3.fromRGB(255, 200, 50)
    local HOT     = Color3.fromRGB(255, 100, 30)
    local GREEN   = Color3.fromRGB(60, 200, 100)
    local RED     = Color3.fromRGB(200, 60, 60)
    local STEEL   = Color3.fromRGB(100, 110, 130)

    local LAYERS      = preset.layers
    local DRIFT_SPEED = preset.drift_speed
    local TOLERANCE   = preset.tolerance
    local TIME_LIMIT  = preset.time_limit

    local targets = {}
    local handles = {}
    local drifts  = {}
    local locked  = {}

    for i = 1, LAYERS do
        targets[i] = math.random(10, 90) / 100
        handles[i] = math.random(10, 90) / 100
        drifts[i]  = (math.random() > 0.5 and 1 or -1)
        locked[i]  = false
    end

    local game_over  = false
    local timer_conn = nil
    local hb_conn    = nil
    local dragging   = nil

    if CoreGui:FindFirstChild("FingerprintGUI") then CoreGui.FingerprintGUI:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "FingerprintGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    getgenv().Keybind_Input_Disabled_For_Mini_Game = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, LAYERS * 120 + 220)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
    local fstroke = Instance.new("UIStroke", frame)
    fstroke.Color = STEEL
    fstroke.Thickness = 1.5

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.75, 0, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "// FINGERPRINT SCAN //"
    title.TextColor3 = STEEL
    title.Font = Enum.Font.Code
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local timer_label = Instance.new("TextLabel")
    timer_label.Size = UDim2.new(0.2, 0, 0, 36)
    timer_label.Position = UDim2.new(0.72, 0, 0, 6)
    timer_label.BackgroundTransparency = 1
    timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
    timer_label.TextColor3 = WHITE
    timer_label.Font = Enum.Font.Code
    timer_label.TextSize = 15
    timer_label.TextXAlignment = Enum.TextXAlignment.Right
    timer_label.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 28, 0, 28)
    cancel.Position = UDim2.new(1, -34, 0, 8)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "X"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.BorderSizePixel = 0
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

    local hint = Instance.new("TextLabel")
    hint.Size = UDim2.new(1, -20, 0, 16)
    hint.Position = UDim2.new(0, 10, 0, 44)
    hint.BackgroundTransparency = 1
    hint.Text = "Align all scan layers to the target, then LOCK."
    hint.TextColor3 = MUTED
    hint.Font = Enum.Font.Code
    hint.TextSize = 11
    hint.TextXAlignment = Enum.TextXAlignment.Left
    hint.Parent = frame

    local CELL_COLS = 20
    local CELL_ROWS = 6

    local function get_match_color(match)
        if match < 0.4 then
            return COLD:Lerp(WARM, match / 0.4)
        elseif match < 0.85 then
            return WARM:Lerp(HOT, (match - 0.4) / 0.45)
        else
            return HOT:Lerp(GREEN, (match - 0.85) / 0.15)
        end
    end

    local function build_fp_pattern(seed, offset)
        local pattern = {}
        for r = 1, CELL_ROWS do
            pattern[r] = {}
            for c = 1, CELL_COLS do
                local x = (c - 0.5) / CELL_COLS
                local y = (r - 0.5) / CELL_ROWS
                local cx = 0.5 + offset
                local dist = math.sqrt((x - cx)^2 + (y - 0.5)^2)
                local ring = math.sin(dist * math.pi * (6 + seed * 2) - seed) 
                pattern[r][c] = ring > 0.1
            end
        end
        return pattern
    end

    local scan_cells     = {}
    local target_cells   = {}
    local match_labels   = {}
    local lock_btns      = {}
    local layer_sliders  = {}
    local layer_handles  = {}
    local function cleanup()
        if timer_conn then timer_conn:Disconnect() end
        if hb_conn    then hb_conn:Disconnect()    end
        if gui then gui:Destroy() end
        getgenv().Keybind_Input_Disabled_For_Mini_Game = false
    end

    local function win()
        game_over = true
        g.fingerprint_minigame_cooldown = tick()
        if g.notify then g.notify("Success", "Identity confirmed!", 5) end
        task.delay(0.5, cleanup)
    end

    local function fail(msg)
        game_over = true
        if g.notify then g.notify("Error", msg or "Scan failed!", 5) end
        task.delay(0.5, cleanup)
    end

    local function check_all_locked()
        for i = 1, LAYERS do
            if not locked[i] then return end
        end
        win()
    end

    local function get_match(layer_idx)
        local diff = math.abs(handles[layer_idx] - targets[layer_idx])
        return math.clamp(1 - diff / 0.5, 0, 1)
    end

    local function update_scan_grid(layer_idx)
        local offset = handles[layer_idx] - 0.5
        local seed   = layer_idx * 1.7
        local pat    = build_fp_pattern(seed, offset * 0.3)
        local cells  = scan_cells[layer_idx]
        local match  = get_match(layer_idx)
        local col    = get_match_color(match)
        for r = 1, CELL_ROWS do
            for c = 1, CELL_COLS do
                local active = pat[r][c]
                cells[r][c].BackgroundColor3 = active and col or Color3.fromRGB(14, 14, 18)
                cells[r][c].BackgroundTransparency = active and 0 or 0
            end
        end
        match_labels[layer_idx].Text = "MATCH: " .. math.floor(match * 100) .. "%"
        match_labels[layer_idx].TextColor3 = col
    end

    for li = 1, LAYERS do
        local layer_y = 66 + (li - 1) * 120

        local layer_lbl = Instance.new("TextLabel")
        layer_lbl.Size = UDim2.new(1, -20, 0, 14)
        layer_lbl.Position = UDim2.new(0, 10, 0, layer_y)
        layer_lbl.BackgroundTransparency = 1
        layer_lbl.Text = "LAYER " .. li
        layer_lbl.Font = Enum.Font.Code
        layer_lbl.TextSize = 10
        layer_lbl.TextColor3 = MUTED
        layer_lbl.TextXAlignment = Enum.TextXAlignment.Left
        layer_lbl.Parent = frame

        local fp_row = Instance.new("Frame")
        fp_row.Size = UDim2.new(1, -20, 0, 60)
        fp_row.Position = UDim2.new(0, 10, 0, layer_y + 16)
        fp_row.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
        fp_row.BorderSizePixel = 0
        fp_row.ClipsDescendants = true
        fp_row.Parent = frame
        Instance.new("UICorner", fp_row).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", fp_row).Color = Color3.fromRGB(35, 35, 45)

        local target_seed   = li * 1.7
        local target_offset = (targets[li] - 0.5) * 0.3
        local tpat = build_fp_pattern(target_seed, target_offset)

        local tgt_panel = Instance.new("Frame")
        tgt_panel.Size = UDim2.new(0.5, -2, 1, 0)
        tgt_panel.Position = UDim2.new(0, 0, 0, 0)
        tgt_panel.BackgroundTransparency = 1
        tgt_panel.ClipsDescendants = true
        tgt_panel.Parent = fp_row

        local tgt_lbl = Instance.new("TextLabel")
        tgt_lbl.Size = UDim2.new(1, 0, 0, 10)
        tgt_lbl.Position = UDim2.new(0, 0, 0, 0)
        tgt_lbl.BackgroundTransparency = 1
        tgt_lbl.Text = "TARGET"
        tgt_lbl.Font = Enum.Font.Code
        tgt_lbl.TextSize = 8
        tgt_lbl.TextColor3 = MUTED
        tgt_lbl.TextXAlignment = Enum.TextXAlignment.Center
        tgt_lbl.Parent = tgt_panel

        target_cells[li] = {}
        for r = 1, CELL_ROWS do
            target_cells[li][r] = {}
            for c = 1, CELL_COLS do
                local cell = Instance.new("Frame")
                cell.Size = UDim2.new(1 / CELL_COLS, -1, 1 / CELL_ROWS, -1)
                cell.Position = UDim2.new((c - 1) / CELL_COLS, 0, (r - 1) / CELL_ROWS, 10)
                cell.BackgroundColor3 = tpat[r][c] and Color3.fromRGB(60, 160, 255) or Color3.fromRGB(14, 14, 18)
                cell.BorderSizePixel = 0
                cell.Parent = tgt_panel
                target_cells[li][r][c] = cell
            end
        end

        local divider = Instance.new("Frame")
        divider.Size = UDim2.new(0, 1, 1, 0)
        divider.Position = UDim2.new(0.5, 0, 0, 0)
        divider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        divider.BorderSizePixel = 0
        divider.Parent = fp_row

        local scan_panel = Instance.new("Frame")
        scan_panel.Size = UDim2.new(0.5, -2, 1, 0)
        scan_panel.Position = UDim2.new(0.5, 2, 0, 0)
        scan_panel.BackgroundTransparency = 1
        scan_panel.ClipsDescendants = true
        scan_panel.Parent = fp_row

        local scan_lbl = Instance.new("TextLabel")
        scan_lbl.Size = UDim2.new(1, 0, 0, 10)
        scan_lbl.Position = UDim2.new(0, 0, 0, 0)
        scan_lbl.BackgroundTransparency = 1
        scan_lbl.Text = "SCAN"
        scan_lbl.Font = Enum.Font.Code
        scan_lbl.TextSize = 8
        scan_lbl.TextColor3 = MUTED
        scan_lbl.TextXAlignment = Enum.TextXAlignment.Center
        scan_lbl.Parent = scan_panel

        scan_cells[li] = {}
        for r = 1, CELL_ROWS do
            scan_cells[li][r] = {}
            for c = 1, CELL_COLS do
                local cell = Instance.new("Frame")
                cell.Size = UDim2.new(1 / CELL_COLS, -1, 1 / CELL_ROWS, -1)
                cell.Position = UDim2.new((c - 1) / CELL_COLS, 0, (r - 1) / CELL_ROWS, 10)
                cell.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
                cell.BorderSizePixel = 0
                cell.Parent = scan_panel
                scan_cells[li][r][c] = cell
            end
        end

        local slider_row = Instance.new("Frame")
        slider_row.Size = UDim2.new(1, -20, 0, 22)
        slider_row.Position = UDim2.new(0, 10, 0, layer_y + 80)
        slider_row.BackgroundTransparency = 1
        slider_row.Parent = frame

        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, -90, 0, 8)
        track.AnchorPoint = Vector2.new(0, 0.5)
        track.Position = UDim2.new(0, 0, 0.5, 0)
        track.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        track.BorderSizePixel = 0
        track.Parent = slider_row
        Instance.new("UICorner", track).CornerRadius = UDim.new(0, 4)

        local handle = Instance.new("TextButton")
        handle.Size = UDim2.new(0, 18, 0, 18)
        handle.AnchorPoint = Vector2.new(0.5, 0.5)
        handle.Position = UDim2.new(handles[li], 0, 0.5, 0)
        handle.BackgroundColor3 = WHITE
        handle.Text = ""
        handle.BorderSizePixel = 0
        handle.Parent = track
        Instance.new("UICorner", handle).CornerRadius = UDim.new(0.5, 0)

        local match_lbl = Instance.new("TextLabel")
        match_lbl.Size = UDim2.new(0, 80, 1, 0)
        match_lbl.AnchorPoint = Vector2.new(1, 0.5)
        match_lbl.Position = UDim2.new(1, 0, 0.5, 0)
        match_lbl.BackgroundTransparency = 1
        match_lbl.Text = "MATCH: 0%"
        match_lbl.Font = Enum.Font.Code
        match_lbl.TextSize = 11
        match_lbl.TextColor3 = COLD
        match_lbl.TextXAlignment = Enum.TextXAlignment.Right
        match_lbl.Parent = slider_row

        local lock_btn = Instance.new("TextButton")
        lock_btn.Size = UDim2.new(0, 70, 0, 20)
        lock_btn.AnchorPoint = Vector2.new(0.5, 0)
        lock_btn.Position = UDim2.new(0.5, 0, 0, layer_y + 104)
        lock_btn.BackgroundColor3 = Color3.fromRGB(20, 34, 20)
        lock_btn.Text = "LOCK"
        lock_btn.Font = Enum.Font.GothamBold
        lock_btn.TextSize = 11
        lock_btn.TextColor3 = GREEN
        lock_btn.BorderSizePixel = 0
        lock_btn.Parent = frame
        Instance.new("UICorner", lock_btn).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", lock_btn).Color = GREEN

        match_labels[li]  = match_lbl
        layer_sliders[li]  = track
        layer_handles[li]  = handle
        lock_btns[li]      = lock_btn

        local layer_idx = li
        handle.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = layer_idx
            end
        end)

        lock_btn.MouseButton1Click:Connect(function()
            if game_over or locked[layer_idx] then return end
            if get_match(layer_idx) >= 1 - TOLERANCE then
                locked[layer_idx] = true
                handle.BackgroundColor3 = GREEN
                lock_btn.Text = "✓ LOCKED"
                lock_btn.TextColor3 = GREEN
                check_all_locked()
            else
                if g.notify then g.notify("Warning", "Layer " .. layer_idx .. " not aligned.", 3) end
            end
        end)

        update_scan_grid(li)
    end

    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = nil
        end
    end)

    UIS.InputChanged:Connect(function(inp)
        if not dragging or game_over then return end
        if inp.UserInputType ~= Enum.UserInputType.MouseMovement and inp.UserInputType ~= Enum.UserInputType.Touch then return end
        if locked[dragging] then return end
        local track    = layer_sliders[dragging]
        local bar_pos  = track.AbsolutePosition.X
        local bar_size = track.AbsoluteSize.X
        local new_scale = math.clamp((inp.Position.X - bar_pos) / bar_size, 0, 1)
        handles[dragging] = new_scale
        layer_handles[dragging].Position = UDim2.new(new_scale, 0, 0.5, 0)
        update_scan_grid(dragging)
    end)

    cancel.MouseButton1Click:Connect(function()
        if g.notify then g.notify("Info", "Fingerprint scan cancelled.", 3) end
        cleanup()
    end)

    local time_elapsed = 0
    timer_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        time_elapsed = time_elapsed + dt
        local left = TIME_LIMIT - time_elapsed
        if left <= 0 then timer_label.Text = "00:00"; fail("Time's up!"); return end
        timer_label.Text = string.format("%02d:%02d", math.floor(left / 60), math.floor(left % 60))
        if left <= 5 then timer_label.TextColor3 = RED end
    end)

    hb_conn = RunService.Heartbeat:Connect(function(dt)
        if game_over then return end
        for i = 1, LAYERS do
            if not locked[i] and DRIFT_SPEED > 0 then
                targets[i] = targets[i] + drifts[i] * DRIFT_SPEED * dt
                if targets[i] >= 0.92 then drifts[i] = -1 end
                if targets[i] <= 0.08 then drifts[i] =  1 end
                local target_seed   = i * 1.7
                local target_offset = (targets[i] - 0.5) * 0.3
                local tpat = build_fp_pattern(target_seed, target_offset)
                for r = 1, CELL_ROWS do
                    for c = 1, CELL_COLS do
                        target_cells[i][r][c].BackgroundColor3 = tpat[r][c] and COLD or Color3.fromRGB(14, 14, 18)
                    end
                end
                update_scan_grid(i)
            end
        end
    end)
end

g.open_minigame_menu = function()
    if CoreGui:FindFirstChild("MinigameMenuGUI") and CoreGui:FindFirstChild("MinigameMenuGUI"):IsA("ScreenGui") then CoreGui.MinigameMenuGUI.Enabled = true; return end
    local DARK        = Color3.fromRGB(18, 18, 18)
    local SURFACE     = Color3.fromRGB(26, 26, 26)
    local BORDER      = Color3.fromRGB(50, 50, 50)
    local WHITE       = Color3.fromRGB(240, 240, 240)
    local MUTED       = Color3.fromRGB(140, 140, 140)
    local GAMES = {
        {
            key         = "memory",
            name        = "Memory Grid",
            sub         = "Memorize the pattern, then tap the tiles",
            desc        = "A 5x5 grid lights up several tiles briefly. Memorize their positions, then click every highlighted tile before making too many mistakes. Difficulty changes show time, mistake tolerance, and pattern size.",
            fn          = function() g.Memory_Mini_Game_GUI() end,
        },
        {
            key         = "reaction",
            name        = "Reaction Time",
            sub         = "Land the moving bar in the zone repeatedly",
            desc        = "A bar bounces left and right at increasing speed. Click when it overlaps the purple target zone. Difficulty changes required wins, miss tolerance, starting speed, and how tight a 'PERFECT' hit needs to be.",
            fn          = function() g.reaction_time_minigame() end,
        },
        {
            key         = "keypad",
            name        = "Keypad Hack",
            sub         = "Crack the digit code within your attempts",
            desc        = "A secret numeric code is generated. Enter your guess and receive hints — correct position vs. correct number. Difficulty changes code length and how many attempts you get before lockout.",
            fn          = function() g.keypad_minigame() end,
        },
        {
            key         = "hacking",
            name        = "Breach Protocol",
            sub         = "Input the target sequence from the grid",
            desc        = "A Cyberpunk-style matrix grid. Alternate selecting columns and rows to build a character sequence matching the target before time runs out. Difficulty changes sequence length, timer, and grid size.",
            fn          = function() g.hacking_minigame() end,
        },
        {
            key         = "safe",
            name        = "Safe Cracker",
            sub         = "Hit target notches on the spinning dial",
            desc        = "A dial spins at increasing speed across 20 notches. Click CRACK when the marker lands on the target notch for each step. Difficulty changes step count, dial speed, timer, and hit tolerance.",
            fn          = function() g.safe_cracker_minigame() end,
        },
        {
            key         = "wire",
            name        = "Wire Cutter",
            sub         = "Cut the correct wire using the intel clues",
            desc        = "Wires are presented with partial intel clues about which ones are dangerous. Deduce the safe wire and cut it before the timer runs out. Difficulty changes wire count, timer, and how many clues you're given.",
            fn          = function() g.wire_cutter_minigame() end,
        },
        {
            key         = "simon",
            name        = "Simon Says",
            sub         = "Repeat the growing color sequence",
            desc        = "Four colored buttons flash a growing sequence each round. Watch carefully then repeat it back in order. Difficulty changes rounds needed to win and how fast the sequence flashes.",
            fn          = function() g.simon_says_minigame() end,
        },
        {
            key = "lockpick", name = "Lockpick", sub = "Turn the pick into the sweet spot without snapping",
            desc = "A dial sweeps continuously around a pin lock. Hold to build tension while timing your click for when the pick lines up with the sweet spot. Too much tension and the pick snaps. Difficulty changes pin count, sweet spot size, and dial speed.",
            fn = function() g.lockpick_minigame() end,
        },
        {
            key = "laser", name = "Laser Grid", sub = "Advance through rows without tripping a beam",
            desc = "A moving laser sweeps across each row. Click Advance to move up one row when the beam isn't on your position. Difficulty changes row count, beam speed, and hazard margin.",
            fn = function() g.laser_grid_minigame() end,
        },
        {
            key = "signal", name = "Signal Triangulation", sub = "Drag the slider to find the hidden signal",
            desc = "Drag the handle along the bar and watch the signal strength readout to home in on a hidden target, then lock it in. Difficulty changes tolerance and whether the target drifts.",
            fn = function() g.signal_triangulation_minigame() end,
        },
        {
            key = "pipe", name = "Pipe Reroute", sub = "Rotate tiles to connect the circuit",
            desc = "A grid of pipe tiles needs rotating to form a connected path from top-left to bottom-right. Some tiles are locked in place. Difficulty changes grid size, locked tile count, and timer.",
            fn = function() g.pipe_reroute_minigame() end,
        },
        {
            key = "steady", name = "Steady Hand", sub = "Hold the needle in the zone",
            desc = "A needle drifts on its own. Hold Steady to counter the drift and keep it inside the target zone for a sustained duration. Difficulty changes drift force, zone width, and hold time.",
            fn = function() g.steady_hand_minigame() end,
        },
        {
            key = "rhythm", name = "Rhythm Splice", sub = "Hit the notes as they reach the line",
            desc = "Notes scroll toward a hit line. Click Hit when one lines up. Difficulty changes note count, speed, and hit window.",
            fn = function() g.rhythm_splice_minigame() end,
        },
        {
            key = "recall", name = "Vault Recall", sub = "Reproduce the flash order on the card grid",
            desc = "Cards flash in a hidden order. Watch closely, then click them back in the same sequence. Difficulty changes card count and flash speed.",
            fn = function() g.card_recall_minigame() end,
        },
        {
            key = "morse", name = "Morse Decoder", sub = "Decode the flashing morse sequence",
            desc = "A sequence of letters plays out in dots and dashes. Watch the flash, then input the correct morse code using the dot and dash buttons before time runs out. Difficulty changes sequence length and flash speed.",
            fn = function() g.morse_minigame() end,
        },
        {
            key = "frequency", name = "Frequency Tuner", sub = "Drag all bands into their green zones",
            desc = "Multiple signal bands drift on their own. Drag each handle into its green target zone then lock it in. All bands must be locked to win. Difficulty changes band count, drift speed, and tolerance.",
            fn = function() g.frequency_minigame() end,
        },
        {
            key = "overload", name = "Overload", sub = "Click surging nodes before they blow",
            desc = "Nodes randomly begin surging and fill up over time. Click them to vent the charge before they overload. Survive until the timer runs out. Difficulty changes node count, surge speed, and overload tolerance.",
            fn = function() g.overload_minigame() end,
        },
        {
            key = "terminal", name = "Terminal Hack", sub = "Find the correct access word",
            desc = "A list of words is shown. One is the correct password. Each wrong guess tells you how many characters match positionally. Use the feedback to narrow it down before attempts run out. Difficulty changes word length and attempt count.",
            fn = function() g.terminal_minigame() end,
        },
        {
            key = "voltage", name = "Voltage Regulator", sub = "Tap when the needle hits the target",
            desc = "A needle bounces back and forth at increasing speed. Hit REGULATE when it lines up with the green target zone each step. Difficulty changes step count, needle speed, and hit tolerance.",
            fn = function() g.voltage_minigame() end,
        },
        {
            key = "shadow", name = "Shadow Recall", sub = "Memorize and repeat the shape sequence",
            desc = "Shapes flash one by one in a sequence. After they disappear, click them back in the correct order from a shuffled pool. Difficulty changes shape count and how fast they flash.",
            fn = function() g.shadow_minigame() end,
        },
        {
            key = "bank_drill", name = "Vault Drill", sub = "Hold the drill in the heat sweet zone",
            desc = "Hold DRILL to raise the heat. Guide it into the green sweet zone on the heat-cam display for each drill point. Release to cool down. Overheat and the bit's gone. Difficulty changes zone count, overheat rate, and zone width.",
            fn = function() g.bank_drill_minigame() end,
        },
        {
            key = "fingerprint", name = "Fingerprint Scanner", sub = "Align the scan layers to the target print",
            desc = "Each layer shows a target fingerprint and a live scan. Drag the slider to align the scan pattern until the match percentage hits 100%, then lock it in. On harder difficulties the target drifts. All layers must be locked to win.",
            fn = function() g.fingerprint_minigame() end,
        },
        {
            key = "dead_drop", name = "Dead Drop", sub = "Spot the signal feed before it hops",
            desc = "A grid of surveillance camera feeds cycle through static. One camera briefly flickers a hidden signal pattern. Click it before the signal hops to another feed. Miss too many times and the transmission is lost. Hard difficulty adds decoy flickers on wrong cameras.",
            fn = function() g.dead_drop_minigame() end,
        },
    }

    local Is_Mobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    local gui = Instance.new("ScreenGui")
    gui.Name = "MinigameMenuGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    local outer = Instance.new("Frame")
    outer.AnchorPoint = Vector2.new(0.5, 0.5)
    outer.Position = UDim2.fromScale(0.5, 0.5)
    if not Is_Mobile then
        outer.Size = UDim2.new(0, 360, 0, 520)
    else
        outer.Size = UDim2.new(0, 360, 0, 350) -- mobile size since it needs to shrink on mobile screens.
    end
    outer.BackgroundColor3 = DARK
    outer.BorderSizePixel = 0
    outer.Parent = gui
    Instance.new("UICorner", outer).CornerRadius = UDim.new(0, 14)

    local stroke = Instance.new("UIStroke", outer)
    stroke.Color = BORDER
    stroke.Thickness = 1

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 42)
    header.BackgroundColor3 = SURFACE
    header.BorderSizePixel = 0
    header.Parent = outer

    local hcorner = Instance.new("UICorner", header)
    hcorner.CornerRadius = UDim.new(0, 14)

    local hfix = Instance.new("Frame")
    hfix.Size = UDim2.new(1, 0, 0.5, 0)
    hfix.Position = UDim2.fromScale(0, 0.5)
    hfix.BackgroundColor3 = SURFACE
    hfix.BorderSizePixel = 0
    hfix.Parent = header

    local title_lbl = Instance.new("TextLabel")
    title_lbl.Size = UDim2.new(1, -125, 1, 0)
    title_lbl.Position = UDim2.new(0, 14, 0, 0)
    title_lbl.BackgroundTransparency = 1
    title_lbl.Text = "Flames Hub | Mini-Games"
    title_lbl.TextScaled = false
    title_lbl.Font = Enum.Font.GothamBold
    title_lbl.TextSize = 14
    title_lbl.TextColor3 = WHITE
    title_lbl.TextXAlignment = Enum.TextXAlignment.Left
    title_lbl.Parent = header

    if g.dragify and typeof(g.dragify) == "function" then g.dragify(outer) end
    local minimized = false
    local content_frame
    local function make_header_btn(text, x_offset)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 34, 0, 24)
        btn.Position = UDim2.new(1, x_offset, 0.5, -12)
        btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
        btn.Text = text
        btn.TextColor3 = MUTED
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.BorderSizePixel = 0
        btn.Parent = header
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        return btn
    end

    local close_btn = make_header_btn("X", -45)
    local minimize_btn = make_header_btn("-", -80)
    local difficulty_btn = make_header_btn("⚙", -115)
    close_btn.MouseButton1Click:Connect(function() gui.Enabled = false end)
    difficulty_btn.MouseButton1Click:Connect(function() g.open_difficulty_editor() end)
    local function build_content()
        if content_frame then content_frame:Destroy() end
        content_frame = Instance.new("ScrollingFrame")
        content_frame.Size = UDim2.new(1, 0, 1, -42)
        content_frame.Position = UDim2.new(0, 0, 0, 42)
        content_frame.BackgroundTransparency = 1
        content_frame.BorderSizePixel = 0
        content_frame.ScrollBarThickness = 3
        content_frame.CanvasSize = UDim2.new(0, 0, 0, 0)
        content_frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        content_frame.Parent = outer

        local list = Instance.new("UIListLayout")
        list.Padding = UDim.new(0, 8)
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Parent = content_frame

        local pad = Instance.new("UIPadding")
        pad.PaddingTop = UDim.new(0, 10)
        pad.PaddingBottom = UDim.new(0, 10)
        pad.PaddingLeft = UDim.new(0, 10)
        pad.PaddingRight = UDim.new(0, 10)
        pad.Parent = content_frame

        for i, picked_game in ipairs(GAMES) do
            local difficulty = g.minigame_difficulty[picked_game.key] or "Medium"
            local diff_color = DIFFICULTY_COLOR[difficulty]
            local card = Instance.new("Frame")
            card.Size = UDim2.new(1, 0, 0, 110)
            card.BackgroundColor3 = SURFACE
            card.BorderSizePixel = 0
            card.LayoutOrder = i
            card.Parent = content_frame
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)

            local cstroke = Instance.new("UIStroke", card)
            cstroke.Color = BORDER
            cstroke.Thickness = 0.5

            local name_lbl = Instance.new("TextLabel")
            name_lbl.Size = UDim2.new(1, -110, 0, 20)
            name_lbl.Position = UDim2.new(0, 12, 0, 10)
            name_lbl.BackgroundTransparency = 1
            name_lbl.Text = picked_game.name
            name_lbl.Font = Enum.Font.GothamBold
            name_lbl.TextSize = 13
            name_lbl.TextColor3 = WHITE
            name_lbl.TextXAlignment = Enum.TextXAlignment.Left
            name_lbl.Parent = card

            local diff_lbl = Instance.new("TextLabel")
            diff_lbl.Size = UDim2.new(0, 60, 0, 18)
            diff_lbl.Position = UDim2.new(1, -72, 0, 11)
            diff_lbl.BackgroundColor3 = diff_color
            diff_lbl.BackgroundTransparency = 0.75
            diff_lbl.Text = difficulty
            diff_lbl.Font = Enum.Font.GothamBold
            diff_lbl.TextSize = 11
            diff_lbl.TextColor3 = diff_color
            diff_lbl.BorderSizePixel = 0
            diff_lbl.Parent = card
            Instance.new("UICorner", diff_lbl).CornerRadius = UDim.new(0, 5)

            local sub_lbl = Instance.new("TextLabel")
            sub_lbl.Size = UDim2.new(1, -24, 0, 16)
            sub_lbl.Position = UDim2.new(0, 12, 0, 30)
            sub_lbl.BackgroundTransparency = 1
            sub_lbl.Text = picked_game.sub
            sub_lbl.Font = Enum.Font.Gotham
            sub_lbl.TextSize = 11
            sub_lbl.TextColor3 = MUTED
            sub_lbl.TextXAlignment = Enum.TextXAlignment.Left
            sub_lbl.Parent = card

            local desc_open = false
            local desc_lbl = Instance.new("TextLabel")
            desc_lbl.Size = UDim2.new(1, -24, 0, 0)
            desc_lbl.Position = UDim2.new(0, 12, 0, 112)
            desc_lbl.BackgroundTransparency = 1
            desc_lbl.Text = picked_game.desc
            desc_lbl.Font = Enum.Font.Gotham
            desc_lbl.TextSize = 11
            desc_lbl.TextColor3 = MUTED
            desc_lbl.TextWrapped = true
            desc_lbl.TextXAlignment = Enum.TextXAlignment.Left
            desc_lbl.TextYAlignment = Enum.TextYAlignment.Top
            desc_lbl.Visible = false
            desc_lbl.Parent = card

            local desc_btn = Instance.new("TextButton")
            desc_btn.Size = UDim2.new(0, 100, 0, 24)
            desc_btn.Position = UDim2.new(0, 12, 0, 76)
            desc_btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            desc_btn.Text = "(i) Description"
            desc_btn.Font = Enum.Font.Gotham
            desc_btn.TextSize = 11
            desc_btn.TextColor3 = MUTED
            desc_btn.BorderSizePixel = 0
            desc_btn.Parent = card
            Instance.new("UICorner", desc_btn).CornerRadius = UDim.new(0, 6)

            local play_btn = Instance.new("TextButton")
            play_btn.Size = UDim2.new(0, 70, 0, 24)
            play_btn.Position = UDim2.new(1, -82, 0, 76)
            play_btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            play_btn.Text = "Play"
            play_btn.Font = Enum.Font.GothamBold
            play_btn.TextSize = 12
            play_btn.TextColor3 = WHITE
            play_btn.BorderSizePixel = 0
            play_btn.Parent = card
            Instance.new("UICorner", play_btn).CornerRadius = UDim.new(0, 6)

            desc_btn.MouseButton1Click:Connect(function()
                desc_open = not desc_open
                if desc_open then
                    local available_width = card.AbsoluteSize.X - 24
                    local text_bounds = TextService:GetTextSize(
                        picked_game.desc,
                        desc_lbl.TextSize,
                        desc_lbl.Font,
                        Vector2.new(available_width, math.huge)
                    )
                    desc_lbl.Size = UDim2.new(1, -24, 0, text_bounds.Y)
                    desc_lbl.Visible = true
                    card.Size = UDim2.new(1, 0, 0, 112 + text_bounds.Y + 16)
                    desc_btn.Text = "(X) Hide"
                else
                    desc_lbl.Visible = false
                    card.Size = UDim2.new(1, 0, 0, 110)
                    desc_btn.Text = "(i) Description"
                end
            end)

            play_btn.MouseButton1Click:Connect(function()
                gui:Destroy()
                task.wait(0.05)
                picked_game.fn()
            end)
        end
    end

    build_content()
    minimize_btn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            outer.Size = UDim2.new(0, 360, 0, 42)
            if content_frame then content_frame.Visible = false end
            minimize_btn.Text = "+"
        else
            outer.Size = UDim2.new(0, 360, 0, 520)
            if content_frame then content_frame.Visible = true end
            minimize_btn.Text = "-"
        end
    end)

    if getgenv().Keybind_Toggle_Initialized then pcall(function() getgenv().Keybind_Toggle_Initialized:Disconnect() end); task.wait(); getgenv().Keybind_Toggle_Initialized = nil end
    wait(0.25)
    if not Is_Mobile then
        getgenv().Keybind_Toggle_Initialized = UserInputService.InputBegan:Connect(function(Input, Game_Processed_Event)
            if Game_Processed_Event then return end
            if Input.KeyCode == Enum.KeyCode.RightControl and getgenv().Keybind_Input_Disabled_For_Mini_Game == false then if gui and gui:IsA("ScreenGui") then gui.Enabled = not gui.Enabled end end
        end)
    end
end

local ok = pcall(function() g.get_or_set("Terrain", g.findinstance("Terrain")) end)
if not ok and g.notify then g.notify("Warning", "Failed to resolve Terrain, some features may not work.", 5) end
g.get_or_set("Camera", workspace.CurrentCamera)
local lp = g.LocalPlayer or Players.LocalPlayer
g.get_or_set("LocalPlayer", lp)
g.get_or_set("Backpack", g.findplayerchild(lp, "Backpack"))
g.get_or_set("PlayerGui", g.findplayerchild(lp, "PlayerGui"))
g.get_or_set("PlayerScripts", g.findplayerchild(lp, "PlayerScripts"))
g.get_or_set("Character", nil)
g.get_or_set("get_player_gui", PlayerGui)
g.get_or_set("get_player_scripts", g.PlayerScripts)
g.get_or_set("get_player_backpack", g.Backpack or lp:FindFirstChildWhichIsA("Backpack"))
if not getgenv().Anti_Idle_Controller_Loaded then
    getgenv().Anti_Idle_Controller_Loaded = true
    if getconnections or get_signal_cons and typeof(getconnections) == "function" and typeof(get_signal_cons) == "function" then
        local gc = getconnections or get_signal_cons
        local idle = lp.Idled
        if gc and typeof(gc) == "function" and idle then
            idle:Connect(function()
                task.wait()
                for _,v in pairs(gc(idle)) do
                    if v.Disable then
                        v.Disable(v)
                    elseif v.Disconnect then
                        v.Disconnect(v)
                    end
                end
            end)
        end
    end
end

getgenv().getRoot = function(char)
	if not char or typeof(char) ~= "Instance" then return nil end
	if not char.Parent then return nil end
	local ok_name, name_of_char = pcall(function() return tostring(char.Name) end)
	if not ok_name or not name_of_char then return nil end
    local ok_hum, hum = pcall(function() return char:FindFirstChildOfClass("Humanoid") end)
    if ok_hum and hum and typeof(hum) == "Instance" then
        local humanoid = hum
        local ok_root, root_part = pcall(function() return humanoid.RootPart end)
        if ok_root and root_part and typeof(root_part) == "Instance" and root_part.Parent == char then return root_part end
    end

	local ok_hrp, hrp = pcall(function() return char:FindFirstChild("HumanoidRootPart") end)
	if ok_hrp and hrp and hrp.Parent == char then return hrp end
	local ok_ut, ut = pcall(function() return char:FindFirstChild("UpperTorso") end)
	if ok_ut and ut and ut.Parent == char then return ut end
	local ok_t, t = pcall(function() return char:FindFirstChild("Torso") end)
	if ok_t and t and t.Parent == char then return t end
	local player = Players:FindFirstChild(name_of_char)
	if player and typeof(player) == "Instance" then
		local ok_gr, gr = pcall(function() return g.get_root(player, Players.RespawnTime + 0.5) end)
		if ok_gr and gr then return gr end
	end

	return nil
end

getgenv().resolve_character = function(character, timeout)
	timeout = timeout or (Players.RespawnTime + 0.75)
	local start = os.clock()
	local deadline = start + timeout
	local get_player, humanoid, head, root
	while os.clock() < deadline do
		if not character or not character.Parent then return nil end
		local remaining = deadline - os.clock()
		if remaining <= 0 then break end
		get_player = get_player or Players:GetPlayerFromCharacter(character)
		humanoid = humanoid or character:FindFirstChildWhichIsA("Humanoid") or g.get_human(get_player, math.min(Players.RespawnTime + 0.75, remaining))
		head = head or character:FindFirstChild("Head") or g.get_head(get_player, math.min(Players.RespawnTime + 0.75, remaining))
		root = root or character:FindFirstChild("HumanoidRootPart") or g.get_root(get_player, math.min(Players.RespawnTime + 0.5, remaining)) or g.getRoot(character)
		if root and root.Parent ~= character then root = nil end
		if humanoid and humanoid.Parent and humanoid:IsDescendantOf(game) and humanoid.Health > 0 and head and head.Parent and head:IsDescendantOf(game) and root and root:IsDescendantOf(game) then
			return {
				character = character,
				humanoid  = humanoid,
				head      = head,
				root      = root,
				elapsed   = os.clock() - start,
			}
		end
		task.wait(math.min(0.03, remaining))
	end
	return nil
end

getgenv().register_character = function(character)
	if character and character.Parent and character:IsDescendantOf(game) and character:IsDescendantOf(workspace) then
		local hum = character:FindFirstChildWhichIsA("Humanoid")
		local head = character:FindFirstChild("Head")
		local root = character:FindFirstChild("HumanoidRootPart")
		if hum and hum.Health > 0 and head and root then
			getgenv().Character = character
			getgenv().Humanoid = hum
			getgenv().Head = head
			getgenv().HumanoidRootPart = root
			return
		end
	end
	local timeout = Players.RespawnTime + 0.75
	local data = g.resolve_character(character, timeout)
	if not data then return end
	getgenv().Character = data.character
	getgenv().Humanoid = data.humanoid
	getgenv().Head = data.head
	getgenv().HumanoidRootPart = data.root
end

getgenv().setup_local_character = function()
	FL.spawn("setup_local_character_init", "spawn", function()
		while LocalPlayer and LocalPlayer.Parent do
			local char = LocalPlayer.Character or g.get_char(LocalPlayer)
			if char then
				getgenv().register_character(char)
				local hum = char:FindFirstChildWhichIsA("Humanoid")
				if hum then hum.Died:Wait() end
			end
			LocalPlayer.CharacterAdded:Wait()
		end
	end)

	FL.connect("setup_local_character_added", LocalPlayer.CharacterAdded:Connect(function(character)
		FL.spawn("register_character_spawn", "spawn", function() getgenv().register_character(character) end)
	end))
end

getgenv().setup_local_character()