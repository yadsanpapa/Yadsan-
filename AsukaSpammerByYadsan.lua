-- [[ ASUKA SPAMMER : COMPACT EDITION (FIXED) ]] --
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
_G.ASUKA_SpamActive = false
_G.ASUKA_SessionID = 0

pcall(function()
    if CoreGui:FindFirstChild("ASUKA_SpammerGUI") then CoreGui.ASUKA_SpammerGUI:Destroy() end
    if CoreGui:FindFirstChild("ASUKA_Intro") then CoreGui.ASUKA_Intro:Destroy() end
    if CoreGui:FindFirstChild("ASUKA_CustomNotify") then CoreGui.ASUKA_CustomNotify:Destroy() end
end)

---------------------------------------------------
-- CHAT FIRE ENGINE (UPDATED FOR NEW UPDATE)
---------------------------------------------------
local function SendChat(msg)
    local finalMsg = msg

    local success = pcall(function()
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local general = channels:FindFirstChild("RBXGeneral") or channels:FindFirstChild("General")
            if general then 
                general:SendAsync(finalMsg) 
                return true 
            end
        end
    end)
    if success then return end

    pcall(function()
        local defaultEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if defaultEvents then
            local sayReq = defaultEvents:FindFirstChild("SayMessageRequest")
            if sayReq then sayReq:FireServer(finalMsg, "All") end
        end
    end)
end

local function ShowNotify(titleTextVal, descTextVal, duration)
    pcall(function()
        if CoreGui:FindFirstChild("ASUKA_CustomNotify") then CoreGui.ASUKA_CustomNotify:Destroy() end
        local notifyGui = Instance.new("ScreenGui", CoreGui)
        notifyGui.Name = "ASUKA_CustomNotify"
        notifyGui.IgnoreGuiInset = true
        notifyGui.DisplayOrder = 2000000

        local notifyFrame = Instance.new("Frame", notifyGui)
        notifyFrame.Size = UDim2.new(0, 240, 0, 60)
        notifyFrame.Position = UDim2.new(1, 10, 0.1, 0)
        notifyFrame.BackgroundColor3 = Color3.fromRGB(15, 3, 3)
        notifyFrame.BorderSizePixel = 0
        Instance.new("UICorner", notifyFrame).CornerRadius = UDim.new(0, 8)

        local stroke = Instance.new("UIStroke", notifyFrame)
        stroke.Color = Color3.fromRGB(100, 15, 15)
        stroke.Thickness = 1.8

        local tLabel = Instance.new("TextLabel", notifyFrame)
        tLabel.Size = UDim2.new(1, -10, 0, 22)
        tLabel.Position = UDim2.new(0, 10, 0, 6)
        tLabel.BackgroundTransparency = 1
        tLabel.Text = titleTextVal
        tLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        tLabel.TextSize = 11.5
        tLabel.Font = Enum.Font.Bodoni
        tLabel.TextXAlignment = Enum.TextXAlignment.Left

        local dLabel = Instance.new("TextLabel", notifyFrame)
        dLabel.Size = UDim2.new(1, -10, 0, 22)
        dLabel.Position = UDim2.new(0, 10, 0, 28)
        dLabel.BackgroundTransparency = 1
        dLabel.Text = descTextVal
        dLabel.TextColor3 = Color3.fromRGB(200, 150, 150)
        dLabel.TextSize = 9.5
        dLabel.Font = Enum.Font.GothamMedium
        dLabel.TextXAlignment = Enum.TextXAlignment.Left

        TweenService:Create(notifyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -255, 0.1, 0)
        }):Play()

        task.spawn(function()
            task.wait(duration or 4)
            local tw = TweenService:Create(notifyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 10, 0.1, 0)
            })
            tw:Play()
            tw.Completed:Connect(function() if notifyGui then notifyGui:Destroy() end end)
        end)
    end)
end

local Styles = {"XD", "~", "#~", "@", "%_", "(ASUKA)_"}
local SelectedSymbol = "~"

local Roasts = {
    "mdr XD🤡", "tui kh&9ki💀", "Tui xdna🤧", "TMKX M VENOM🤣", "Mora murgi🙄",
    "Ban14🥺", "polapain xdina☺️", "Nijere Aynay dekhsos🤡?", "papa dako😢",
    "Tui ASUKA k Voy pAs💀", "cuda kawa chele🥰", "Donles🤧", "Tor &ke xdi😫",
    "Tr aba ASUKA🤓", "Scripted by CYRAX🔥", "AMMUr Vuda kha8😛", "Er kata d0n😅",
    "JaWra mG🥰", "Jaya GhuMa😗", "Baper TK waste😢", "Tor Bia hbena😛",
    "Prithibir bojha🙁", "Bapmar Kolonko🐸", "Tor jonmanoi vulhoise😭", "Mora Xauda🔥",
    "Tmi amr Don🤡", "Ja pre&care kor😶", "Tmi amr otar shman😛", "Jao ludo kheloga🤡", "Morga☺️"
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ASUKA_SpammerGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999

---------------------------------------------------
-- ANYWHERE DRAG & DROP SYSTEM
---------------------------------------------------
local function MakeAnywhereDraggable(frame, onClickCallback)
    local dragging = false
    local mousePos, framePos, hasMoved, startTick = nil, nil, false, 0

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            hasMoved = false
            mousePos = input.Position
            framePos = frame.Position
            startTick = tick()
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    if dragging then
                        dragging = false
                        if not hasMoved and (tick() - startTick) < 0.3 and onClickCallback then
                            onClickCallback()
                        end
                    end
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - mousePos
            if math.abs(delta.X) > 4 or math.abs(delta.Y) > 4 then hasMoved = true end
            local targetPos = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
            TweenService:Create(frame, TweenInfo.new(0.04, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = targetPos}):Play()
        end
    end)
end

---------------------------------------------------
-- MOVIE CINEMATIC INTRO SYSTEM
---------------------------------------------------
local IntroGui = Instance.new("ScreenGui", CoreGui)
IntroGui.Name = "ASUKA_Intro"
IntroGui.IgnoreGuiInset = true
IntroGui.DisplayOrder = 1000000

local IntroBG = Instance.new("Frame", IntroGui)
IntroBG.Size = UDim2.new(1, 0, 1, 0)
IntroBG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroBG.BackgroundTransparency = 0.3

local TopBar = Instance.new("Frame", IntroGui)
TopBar.Size = UDim2.new(1, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.BorderSizePixel = 0

local BottomBar = Instance.new("Frame", IntroGui)
BottomBar.Size = UDim2.new(1, 0, 0, 0)
BottomBar.Position = UDim2.new(0, 0, 1, 0)
BottomBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BottomBar.BorderSizePixel = 0

TweenService:Create(TopBar, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 85)}):Play()
TweenService:Create(BottomBar, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 85), Position = UDim2.new(0, 0, 1, -85)}):Play()

local MovieText = Instance.new("TextLabel", IntroGui)
MovieText.Size = UDim2.new(0, 700, 0, 50)
MovieText.Position = UDim2.new(0.5, -350, 0.45, -25)
MovieText.BackgroundTransparency = 1
MovieText.Text = ""
MovieText.TextColor3 = Color3.fromRGB(255, 30, 30)
MovieText.TextSize = 20
MovieText.Font = Enum.Font.Bodoni
MovieText.TextWrapped = true

local movieTextStroke = Instance.new("UIStroke", MovieText)
movieTextStroke.Color = Color3.fromRGB(120, 10, 10)
movieTextStroke.Thickness = 2.2

local typeSound = Instance.new("Sound", SoundService)
typeSound.SoundId = "rbxassetid://9116149587"
typeSound.Volume = 1.5
typeSound.PlaybackSpeed = 1.1

local function PlayLine(text, delayTime)
    MovieText.Text = ""
    for i = 1, #text do
        MovieText.Text = string.sub(text, 1, i)
        if string.sub(text, i, i) ~= " " then
            pcall(function()
                typeSound.TimePosition = 0.12
                typeSound:Play()
            end)
        end
        task.wait(0.035)
    end
    task.wait(delayTime)
end

task.spawn(function()
    task.wait(0.6)
    PlayLine("WE ARE ASUKA 💢...", 0.6)
    PlayLine("...ASUKA — THE POWER THAT CANNOT BE MATCHED 💪", 0.6)
    PlayLine("『ASUKA』 — NOT BORN TO FOLLOW, BORN TO LEAD NO COMPARISON, NO COMPETITION — ONLY ASUKA 🤩", 1.0)
    Playline("『ASUKA』 — THE STANDARD THAT OTHERS STRIVE TO REACH ASUKA — LEGENDS ARE REMEMBERED, SUPREMACY IS FOREVER ♾️ ", 1.0)
    
    pcall(function()
        typeSound:Stop()
        typeSound:Destroy()
    end)
    
    local fadeInfo = TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(IntroBG, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(MovieText, fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(movieTextStroke, fadeInfo, {Transparency = 1}):Play()
    TweenService:Create(TopBar, fadeInfo, {Size = UDim2.new(1, 0, 0, 0)}):Play()
    TweenService:Create(BottomBar, fadeInfo, {Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0)}):Play()
    
    task.wait(0.7)
    IntroGui:Destroy()

    ShowNotify("👑 ASUKA ELITE YADSAN POWERFUL 🚩", "System fully loaded & ready.", 5)
    
    task.wait(0.5)
    local announceCore = " 💀⚡ 🔥 > ! CAREFUL ASUKA SPAMMER REAWAKENED ! < 🔥 ⚡💀"
    local maxLimit2 = 190
    local spaceLeft2 = math.max(5, maxLimit2 - #announceCore)
    local tildeCount2 = math.floor(spaceLeft2 / # "~")
    SendChat(string.rep("~", tildeCount2) .. announceCore)

    task.wait(1.5)
    SendChat("•Made by Yadsan•")
end)

---------------------------------------------------
-- COMPACT MAIN UI COMPONENTS
---------------------------------------------------
local logoBtn = Instance.new("ImageButton", ScreenGui)
logoBtn.Name = "WatermarkLogo"
logoBtn.Size = UDim2.new(0, 45, 0, 45)
logoBtn.Position = UDim2.new(0, 15, 0.68, 0)
logoBtn.BackgroundColor3 = Color3.fromRGB(15, 3, 3)
logoBtn.Image = "rbxassetid://124757009341236"
logoBtn.AutoButtonColor = false
logoBtn.BorderSizePixel = 0
logoBtn.ZIndex = 10
Instance.new("UICorner", logoBtn).CornerRadius = UDim.new(0, 8)

local logoStroke = Instance.new("UIStroke", logoBtn)
logoStroke.Color = Color3.fromRGB(80, 20, 20)
logoStroke.Thickness = 1.5

local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, 330)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -165)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 3, 3)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ZIndex = 5
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Color = Color3.fromRGB(80, 20, 20)
uiStroke.Thickness = 1.8

MakeAnywhereDraggable(mainFrame)
MakeAnywhereDraggable(logoBtn, function()
    mainFrame.Visible = not mainFrame.Visible
end)

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 46)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 4, 4)
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 6
local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 8)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(1, 0, 0, 18)
titleText.Position = UDim2.new(0, 0, 0, 6)
titleText.BackgroundTransparency = 1
titleText.Text = "🔥 ASUKA SPAMMER REVENGE 👑"
titleText.TextColor3 = Color3.fromRGB(255, 40, 40)
titleText.TextSize = 7.5
titleText.Font = Enum.Font.Bodoni
titleText.ZIndex = 7

local playerInfoText = Instance.new("TextLabel", titleBar)
playerInfoText.Size = UDim2.new(1, 0, 0, 14)
playerInfoText.Position = UDim2.new(0, 0, 0, 24)
playerInfoText.BackgroundTransparency = 1
playerInfoText.Text = "Yadsan_Godverse (@" .. player.Name .. ")"
playerInfoText.TextColor3 = Color3.fromRGB(255, 120, 120)
playerInfoText.TextSize = 8
playerInfoText.Font = Enum.Font.GothamMedium
playerInfoText.ZIndex = 7

local targetBox = Instance.new("TextBox", mainFrame)
targetBox.Size = UDim2.new(0.9, 0, 0, 24)
targetBox.Position = UDim2.new(0.05, 0, 0, 54)
targetBox.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
targetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
targetBox.PlaceholderText = "Target Name..."
targetBox.PlaceholderColor3 = Color3.fromRGB(140, 90, 90)
targetBox.Text = ""
targetBox.TextSize = 9
targetBox.Font = Enum.Font.GothamSemibold
targetBox.ZIndex = 6
Instance.new("UICorner", targetBox).CornerRadius = UDim.new(0, 5)

local targetStroke = Instance.new("UIStroke", targetBox)
targetStroke.Color = Color3.fromRGB(70, 70, 70)
targetStroke.Thickness = 1.2

local delayBox = Instance.new("TextBox", mainFrame)
delayBox.Size = UDim2.new(0.9, 0, 0, 24)
delayBox.Position = UDim2.new(0.05, 0, 0, 82)
delayBox.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
delayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
delayBox.PlaceholderText = "Delay..."
delayBox.PlaceholderColor3 = Color3.fromRGB(140, 90, 90)
delayBox.Text = "2"
delayBox.TextSize = 9
delayBox.Font = Enum.Font.GothamSemibold
delayBox.ZIndex = 6
Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0, 5)

local delayStroke = Instance.new("UIStroke", delayBox)
delayStroke.Color = Color3.fromRGB(70, 70, 70)
delayStroke.Thickness = 1.2

local symbolLabel = Instance.new("TextLabel", mainFrame)
symbolLabel.Size = UDim2.new(0.9, 0, 0, 14)
symbolLabel.Position = UDim2.new(0.05, 0, 0, 110)
symbolLabel.BackgroundTransparency = 1
symbolLabel.Text = "Style/Symbol: [ ~ ]"
symbolLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
symbolLabel.TextSize = 9
symbolLabel.Font = Enum.Font.Bodoni
symbolLabel.ZIndex = 6

local SymbolContainer = Instance.new("Frame", mainFrame)
SymbolContainer.Size = UDim2.new(0.9, 0, 0, 68)
SymbolContainer.Position = UDim2.new(0.05, 0, 0, 126)
SymbolContainer.BackgroundTransparency = 1

local symbolListLayout = Instance.new("UIListLayout", SymbolContainer)
symbolListLayout.SortOrder = Enum.SortOrder.LayoutOrder
symbolListLayout.Padding = UDim.new(0, 4)

local gridFrame = Instance.new("Frame", SymbolContainer)
gridFrame.Size = UDim2.new(1, 0, 0, 42)
gridFrame.BackgroundTransparency = 1
gridFrame.LayoutOrder = 1

local gridLayout = Instance.new("UIGridLayout", gridFrame)
gridLayout.CellSize = UDim2.new(0.31, 0, 0, 19)
gridLayout.CellPadding = UDim2.new(0.035, 0, 0, 4)

for i = 1, 6 do
    local sym = Styles[i]
    local sBtn = Instance.new("TextButton", gridFrame)
    sBtn.BackgroundColor3 = (sym == SelectedSymbol) and Color3.fromRGB(140, 15, 15) or Color3.fromRGB(20, 8, 8)
    sBtn.Text = sym
    sBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    sBtn.TextSize = 8
    sBtn.Font = Enum.Font.GothamBold
    sBtn.ZIndex = 7
    Instance.new("UICorner", sBtn).CornerRadius = UDim.new(0, 5)
    
    sBtn.MouseButton1Click:Connect(function()
        SelectedSymbol = sym
        symbolLabel.Text = "Style/Symbol: [ " .. sym .. " ]"
        for _, child in ipairs(gridFrame:GetChildren()) do
            if child:IsA("TextButton") then child.BackgroundColor3 = Color3.fromRGB(20, 8, 8) end
        end
        for _, child in ipairs(SymbolContainer:GetChildren()) do
            if child:IsA("TextButton") then child.BackgroundColor3 = Color3.fromRGB(20, 8, 8) end
        end
        sBtn.BackgroundColor3 = Color3.fromRGB(140, 15, 15)
    end)
end

local awfulBtn = Instance.new("TextButton", SymbolContainer)
awfulBtn.Size = UDim2.new(1, 0, 0, 19)
awfulBtn.BackgroundColor3 = (SelectedSymbol == "Awful") and Color3.fromRGB(140, 15, 15) or Color3.fromRGB(20, 8, 8)
awfulBtn.Text = "Awful"
awfulBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
awfulBtn.TextSize = 8
awfulBtn.Font = Enum.Font.GothamBold
awfulBtn.ZIndex = 7
awfulBtn.LayoutOrder = 2
Instance.new("UICorner", awfulBtn).CornerRadius = UDim.new(0, 5)

awfulBtn.MouseButton1Click:Connect(function()
    SelectedSymbol = "Awful"
    symbolLabel.Text = "Style/Symbol: [ Awful ]"
    for _, child in ipairs(gridFrame:GetChildren()) do
        if child:IsA("TextButton") then child.BackgroundColor3 = Color3.fromRGB(20, 8, 8) end
    end
    awfulBtn.BackgroundColor3 = Color3.fromRGB(140, 15, 15)
end)

local onBtn = Instance.new("TextButton", mainFrame)
onBtn.Size = UDim2.new(0.9, 0, 0, 25)
onBtn.Position = UDim2.new(0.05, 0, 0, 200)
onBtn.BackgroundColor3 = Color3.fromRGB(160, 20, 20)
onBtn.Text = "SPAM ON"
onBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
onBtn.TextSize = 10
onBtn.Font = Enum.Font.Bodoni
onBtn.BorderSizePixel = 0
onBtn.ZIndex = 6
Instance.new("UICorner", onBtn).CornerRadius = UDim.new(0, 5)

local offBtn = Instance.new("TextButton", mainFrame)
offBtn.Size = UDim2.new(0.9, 0, 0, 25)
offBtn.Position = UDim2.new(0.05, 0, 0, 229)
offBtn.BackgroundColor3 = Color3.fromRGB(50, 10, 10)
offBtn.Text = "SPAM OFF"
offBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
offBtn.TextSize = 10
offBtn.Font = Enum.Font.Bodoni
offBtn.BorderSizePixel = 0
offBtn.ZIndex = 6
Instance.new("UICorner", offBtn).CornerRadius = UDim.new(0, 5)

local statusText = Instance.new("TextLabel", mainFrame)
statusText.Size = UDim2.new(1, 0, 0, 14)
statusText.Position = UDim2.new(0, 0, 0, 258)
statusText.BackgroundTransparency = 1
statusText.Text = "Status: IDLE"
statusText.TextColor3 = Color3.fromRGB(180, 140, 140)
statusText.TextSize = 9
statusText.Font = Enum.Font.GothamMedium
statusText.ZIndex = 6

local timeText = Instance.new("TextLabel", mainFrame)
timeText.Size = UDim2.new(1, 0, 0, 12)
timeText.Position = UDim2.new(0, 0, 0, 274)
timeText.BackgroundTransparency = 1
timeText.Text = "Active Time: 0s"
timeText.TextColor3 = Color3.fromRGB(255, 100, 100)
timeText.TextSize = 8
timeText.Font = Enum.Font.GothamBold
timeText.ZIndex = 6

local footerText = Instance.new("TextLabel", mainFrame)
footerText.Size = UDim2.new(1, 0, 0, 12)
footerText.Position = UDim2.new(0, 0, 0, 302)
footerText.BackgroundTransparency = 1
footerText.Text = "Scripted by CYRAX"
footerText.TextColor3 = Color3.fromRGB(255, 50, 50)
footerText.TextSize = 8
footerText.Font = Enum.Font.Bodoni
footerText.ZIndex = 6

task.spawn(function()
    local startTime = os.time()
    while true do
        local elapsed = os.time() - startTime
        local mins = math.floor(elapsed / 60)
        local secs = elapsed % 60
        timeText.Text = string.format("Active Time: %02d:%02d", mins, secs)
        task.wait(1)
    end
end)

---------------------------------------------------
-- SPAM BUTTON CONTROLS
---------------------------------------------------
onBtn.Activated:Connect(function()
    local target = targetBox.Text
    if target == "" then
        statusText.Text = "Enter Target First!"
        statusText.TextColor3 = Color3.fromRGB(255, 80, 80)
        return
    end
    
    local delay = tonumber(delayBox.Text) or 2
    if delay < 0.2 then delay = 0.2 end

    _G.ASUKA_SessionID = (_G.ASUKA_SessionID or 0) + 1
    local currentSession = _G.ASUKA_SessionID

    _G.ASUKA_SpamActive = true
    onBtn.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
    offBtn.BackgroundColor3 = Color3.fromRGB(70, 15, 15)
    statusText.Text = "Status: SPAMMING"
    statusText.TextColor3 = Color3.fromRGB(255, 60, 60)

    task.spawn(function()
        math.randomseed(tick())
        while _G.ASUKA_SpamActive and _G.ASUKA_SessionID == currentSession do
            local randomRoast = Roasts[math.random(1, #Roasts)]
            local roastCore = " [" .. target .. "] " .. randomRoast
            local filledSymbols = ""
            
            if SelectedSymbol == "(ASUKA)_" then
                filledSymbols = string.rep(SelectedSymbol, 9)
            elseif SelectedSymbol == "@" then
                filledSymbols = string.rep("@", 130)
            elseif SelectedSymbol == "Awful" then
                local awfulMix = "~-_=+=*#@!^&%|/\\"
                local maxLimit = 135 
                local remainingSpace = math.max(5, maxLimit - #roastCore)
                local repeatCount = math.floor(remainingSpace / #awfulMix)
                filledSymbols = string.rep(awfulMix, repeatCount)
            else
                local maxLimit = 185 
                local remainingSpace = math.max(5, maxLimit - #roastCore)
                local repeatCount = math.floor(remainingSpace / #SelectedSymbol)
                filledSymbols = string.rep(SelectedSymbol, repeatCount)
            end
            
            local rawMsg = filledSymbols .. roastCore
            SendChat(rawMsg)
            task.wait(delay)
        end
    end)
end)

offBtn.Activated:Connect(function()
    _G.ASUK_SpamActive = false
    _G.ASUKA_SessionID = (_G.ASUKA_SessionID or 0) + 1
    onBtn.BackgroundColor3 = Color3.fromRGB(160, 20, 20)
    offBtn.BackgroundColor3 = Color3.fromRGB(50, 10, 10)
    statusText.Text = "Status: STOPPED"
    statusText.TextColor3 = Color3.fromRGB(200, 100, 100)
end)
