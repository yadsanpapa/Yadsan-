-- [[ ============================================ ]] --
-- [[   🌐 GODVERSE HUB UV1 + KEY SYSTEM [MAP DESTROYER]  ]] --
-- [[            MADE BY: YADSAN                   ]] --
-- [[ ============================================ ]] --

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

-- Purani GUI ko completely destroy karo taaki error na aaye
if CoreGui:FindFirstChild("YadSaNHub_MultiTab") then
    CoreGui.YadSaNHub_MultiTab:Destroy()
end
if PlayerGui:FindFirstChild("YadSaNHub_MultiTab") then
    PlayerGui.YadSaNHub_MultiTab:Destroy()
end
if CoreGui:FindFirstChild("YadSaNHub_KeySystem") then
    CoreGui.YadSaNHub_KeySystem:Destroy()
end
if PlayerGui:FindFirstChild("YadSaNHub_KeySystem") then
    PlayerGui.YadSaNHub_KeySystem:Destroy()
end

-- ============================================ --
--               KEY SYSTEM GUI                 --
-- ============================================ --
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "YadSaNHub_KeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() KeyGui.Parent = gethui() end)
if not KeyGui.Parent then pcall(function() KeyGui.Parent = CoreGui end) end
if not KeyGui.Parent then KeyGui.Parent = PlayerGui end

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 320, 0, 225)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -112)
KeyFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 2
KeyStroke.Color = Color3.fromRGB(255, 90, 0)
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "😌 MAP DESTROYER MADE BY YADSAN 🔱"
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 11
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 38)
KeyBox.Position = UDim2.new(0, 20, 0, 48)
KeyBox.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.GothamMedium
KeyBox.TextSize = 13
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 150)
KeyBox.Parent = KeyFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = KeyBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(1, -40, 0, 35)
SubmitBtn.Position = UDim2.new(0, 20, 0, 96)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
SubmitBtn.Text = "Submit Key"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitBtn

-- Key Link Button
local KeyLinkBtn = Instance.new("TextButton")
KeyLinkBtn.Size = UDim2.new(1, -40, 0, 32)
KeyLinkBtn.Position = UDim2.new(0, 20, 0, 145)
KeyLinkBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
KeyLinkBtn.Text = "📋 KEY LINK"
KeyLinkBtn.Font = Enum.Font.GothamBold
KeyLinkBtn.TextSize = 11
KeyLinkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyLinkBtn.Parent = KeyFrame

local KeyLinkCorner = Instance.new("UICorner")
KeyLinkCorner.CornerRadius = UDim.new(0, 8)
KeyLinkCorner.Parent = KeyLinkBtn

KeyLinkBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("YadsanPapa")
        KeyLinkBtn.Text = "✅ Key Link Copied!"
        task.delay(1.5, function()
            KeyLinkBtn.Text = "📋 KEY LINK"
        end)
    end
end)

-- Main Hub function jo key verify hone ke baad chalegi
local function LoadMainHub()
    KeyGui:Destroy()

    -- Send Chat Messages Automatically on Load
    task.spawn(function()
        local function SendChat(msg)
            pcall(function()
                if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
                    local sayEvent = ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
                    if sayEvent then
                        sayEvent:FireServer(msg, "All")
                    end
                elseif TextChatService then
                    local channels = TextChatService:FindFirstChild("TextChannels")
                    if channels and channels:FindFirstChild("RBXGeneral") then
                        channels.RBXGeneral:SendAsync(msg)
                    end
                end
            end)
        end

        SendChat("💀 MAP DESTROYER LOAD...💀")
        task.wait(1)
        SendChat("🏠THIS SCRIPT FOR LIFE TOGETHER🏠")
        task.wait(1)
        SendChat("😌 MADE BY YADSAN 🔱")
    end)

    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AYANHub_MultiTab"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    pcall(function() ScreenGui.Parent = gethui() end)
    if not ScreenGui.Parent then pcall(function() ScreenGui.Parent = CoreGui end) end
    if not ScreenGui.Parent then ScreenGui.Parent = PlayerGui end

    -- Floating Open/Close Circle Button with 🌪️ Emoji
    local FloatBtn = Instance.new("TextButton")
    FloatBtn.Size = UDim2.new(0, 50, 0, 50)
    FloatBtn.Position = UDim2.new(0, 20, 0.5, -25)
    FloatBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    FloatBtn.Text = "🌪️"
    FloatBtn.TextSize = 24
    FloatBtn.Active = true
    FloatBtn.Draggable = true
    FloatBtn.Parent = ScreenGui

    local FloatCorner = Instance.new("UICorner")
    FloatCorner.CornerRadius = UDim.new(1, 0) -- Perfect Circle
    FloatCorner.Parent = FloatBtn

    local FloatStroke = Instance.new("UIStroke")
    FloatStroke.Thickness = 2
    FloatStroke.Color = Color3.fromRGB(255, 90, 0)
    FloatStroke.Parent = FloatBtn

    -- Main Window Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 440, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -220, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Thickness = 2
    MainStroke.Color = Color3.fromRGB(255, 90, 0)
    MainStroke.Parent = MainFrame

    -- Toggle Hub Visibility on Clicking Floating Circle
    local hubVisible = true
    FloatBtn.MouseButton1Click:Connect(function()
        hubVisible = not hubVisible
        MainFrame.Visible = hubVisible
    end)

    -- Top Bar Header
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 12)
    TopBar.Parent = MainFrame

    -- Title Text
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -50, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🌐MAP DESTROYER [MADE BY YADSAN] FOR LIFETOGETHER🏠"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    -- Close Button ('X')
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.Position = UDim2.new(1, -34, 0, 7)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.Text = "✕"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 12
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Parent = TopBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Tab Switcher Buttons Holder
    local TabHeader = Instance.new("Frame")
    TabHeader.Size = UDim2.new(1, -20, 0, 35)
    TabHeader.Position = UDim2.new(0, 10, 0, 48)
    TabHeader.BackgroundTransparency = 1
    TabHeader.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 8)
    TabListLayout.Parent = TabHeader

    -- Pages Container Holder
    local PagesContainer = Instance.new("Folder")
    PagesContainer.Name = "PagesContainer"
    PagesContainer.Parent = MainFrame

    -- Function to create Tabs & Pages
    local Tabs = {}
    local Pages = {}
    local firstTab = true

    local function CreateTab(tabName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 130, 1, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        TabBtn.Text = tabName
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 12
        TabBtn.TextColor3 = Color3.fromRGB(170, 170, 170)
        TabBtn.Parent = TabHeader

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabBtn

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, -20, 1, -95)
        Page.Position = UDim2.new(0, 10, 0, 88)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 4
        Page.Visible = false
        Page.Parent = PagesContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = Page
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 8)

        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(Pages) do p.Visible = false end
            for _, t in pairs(Tabs) do 
                t.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
                t.TextColor3 = Color3.fromRGB(170, 170, 170)
            end
            
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        table.insert(Tabs, TabBtn)
        table.insert(Pages, Page)

        if firstTab then
            firstTab = false
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end

        return Page
    end

    -- Create 3 Tabs
    local Tab1_Page = CreateTab("Tab 1")
    local Tab2_Page = CreateTab("Tab 2")
    local Tab3_Page = CreateTab("Tab 3")

    -- Helper Function to add Info Box at top of a Page
    local function AddInfoBox(parentPage, infoText)
        local InfoFrame = Instance.new("Frame")
        InfoFrame.Size = UDim2.new(1, -10, 0, 36)
        InfoFrame.BackgroundColor3 = Color3.fromRGB(35, 30, 25)
        InfoFrame.Parent = parentPage

        local InfoCorner = Instance.new("UICorner")
        InfoCorner.CornerRadius = UDim.new(0, 8)
        InfoCorner.Parent = InfoFrame

        local InfoStroke = Instance.new("UIStroke")
        InfoStroke.Thickness = 1
        InfoStroke.Color = Color3.fromRGB(255, 140, 0)
        InfoStroke.Parent = InfoFrame

        local InfoLabel = Instance.new("TextLabel")
        InfoLabel.Size = UDim2.new(1, -10, 1, 0)
        InfoLabel.Position = UDim2.new(0, 5, 0, 0)
        InfoLabel.BackgroundTransparency = 1
        InfoLabel.Text = infoText
        InfoLabel.Font = Enum.Font.GothamBold
        InfoLabel.TextSize = 10
        InfoLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
        InfoLabel.TextWrapped = true
        InfoLabel.Parent = InfoFrame
    end

    -- Helper Function for Tab 1 with Copy Button
    local function AddItemWithCopy(parentPage, name, codeStr, executeCallback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -10, 0, 42)
        Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        Frame.Parent = parentPage

        local FrameCorner = Instance.new("UICorner")
        FrameCorner.CornerRadius = UDim.new(0, 8)
        FrameCorner.Parent = Frame

        local FrameStroke = Instance.new("UIStroke")
        FrameStroke.Thickness = 1
        FrameStroke.Color = Color3.fromRGB(50, 50, 70)
        FrameStroke.Parent = Frame

        local MainBtn = Instance.new("TextButton")
        MainBtn.Size = UDim2.new(1, -95, 1, 0)
        MainBtn.Position = UDim2.new(0, 0, 0, 0)
        MainBtn.BackgroundTransparency = 1
        MainBtn.Text = "  🪩 " .. name
        MainBtn.Font = Enum.Font.GothamMedium
        MainBtn.TextSize = 13
        MainBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
        MainBtn.TextXAlignment = Enum.TextXAlignment.Left
        MainBtn.Parent = Frame

        MainBtn.MouseButton1Click:Connect(function()
            pcall(executeCallback)
        end)

        local CopyBtn = Instance.new("TextButton")
        CopyBtn.Size = UDim2.new(0, 80, 0, 28)
        CopyBtn.Position = UDim2.new(1, -86, 0.5, -14)
        CopyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        CopyBtn.Text = "📋 Copy"
        CopyBtn.Font = Enum.Font.GothamBold
        CopyBtn.TextSize = 11
        CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CopyBtn.Parent = Frame

        local CopyCorner = Instance.new("UICorner")
        CopyCorner.CornerRadius = UDim.new(0, 6)
        CopyCorner.Parent = CopyBtn

        CopyBtn.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard(codeStr)
                CopyBtn.Text = "✅ Copied!"
                task.delay(1.5, function()
                    CopyBtn.Text = "📋 Copy"
                end)
            end
        end)
    end

    -- Helper Function for Tab 2 Emote Script Remote Item
    local function AddRemoteScriptItem(parentPage, name, scriptUrl)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -10, 0, 42)
        Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        Frame.Parent = parentPage

        local FrameCorner = Instance.new("UICorner")
        FrameCorner.CornerRadius = UDim.new(0, 8)
        FrameCorner.Parent = Frame

        local FrameStroke = Instance.new("UIStroke")
        FrameStroke.Thickness = 1
        FrameStroke.Color = Color3.fromRGB(50, 50, 70)
        FrameStroke.Parent = Frame

        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -115, 1, 0)
        NameLabel.Position = UDim2.new(0, 12, 0, 0)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = "🌀 " .. name
        NameLabel.Font = Enum.Font.GothamMedium
        NameLabel.TextSize = 13
        NameLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = Frame

        local LoadBtn = Instance.new("TextButton")
        LoadBtn.Size = UDim2.new(0, 100, 0, 28)
        LoadBtn.Position = UDim2.new(1, -106, 0.5, -14)
        LoadBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
        LoadBtn.Text = "▶ Load Emotes"
        LoadBtn.Font = Enum.Font.GothamBold
        LoadBtn.TextSize = 11
        LoadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        LoadBtn.Parent = Frame

        local LoadCorner = Instance.new("UICorner")
        LoadCorner.CornerRadius = UDim.new(0, 6)
        LoadCorner.Parent = LoadBtn

        LoadBtn.MouseButton1Click:Connect(function()
            pcall(function()
                loadstring(game:HttpGet(scriptUrl))()
            end)
            LoadBtn.Text = "✅ Loaded"
            task.delay(1.5, function()
                LoadBtn.Text = "▶ Load Emotes"
            end)
        end)
    end

    -- Helper Function for Step Items in Tab 3
    local function AddStepItem(parentPage, stepText)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -10, 0, 36)
        Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        Frame.Parent = parentPage

        local FrameCorner = Instance.new("UICorner")
        FrameCorner.CornerRadius = UDim.new(0, 8)
        FrameCorner.Parent = Frame

        local FrameStroke = Instance.new("UIStroke")
        FrameStroke.Thickness = 1
        FrameStroke.Color = Color3.fromRGB(50, 50, 70)
        FrameStroke.Parent = Frame

        local StepLabel = Instance.new("TextLabel")
        StepLabel.Size = UDim2.new(1, -16, 1, 0)
        StepLabel.Position = UDim2.new(0, 8, 0, 0)
        StepLabel.BackgroundTransparency = 1
        StepLabel.Text = stepText
        StepLabel.Font = Enum.Font.GothamMedium
        StepLabel.TextSize = 11
        StepLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
        StepLabel.TextXAlignment = Enum.TextXAlignment.Left
        StepLabel.TextWrapped = true
        StepLabel.Parent = Frame
    end

    -- Helper Function for Video Link Copy Item in Tab 3
    local function AddVideoLinkCopy(parentPage, name, linkStr)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -10, 0, 42)
        Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        Frame.Parent = parentPage

        local FrameCorner = Instance.new("UICorner")
        FrameCorner.CornerRadius = UDim.new(0, 8)
        FrameCorner.Parent = Frame

        local FrameStroke = Instance.new("UIStroke")
        FrameStroke.Thickness = 1
        FrameStroke.Color = Color3.fromRGB(50, 50, 70)
        FrameStroke.Parent = Frame

        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -95, 1, 0)
        NameLabel.Position = UDim2.new(0, 12, 0, 0)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = "📺 " .. name
        NameLabel.Font = Enum.Font.GothamMedium
        NameLabel.TextSize = 12
        NameLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = Frame

        local CopyBtn = Instance.new("TextButton")
        CopyBtn.Size = UDim2.new(0, 80, 0, 28)
        CopyBtn.Position = UDim2.new(1, -86, 0.5, -14)
        CopyBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
        CopyBtn.Text = "📋 Copy Link"
        CopyBtn.Font = Enum.Font.GothamBold
        CopyBtn.TextSize = 11
        CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CopyBtn.Parent = Frame

        local CopyCorner = Instance.new("UICorner")
        CopyCorner.CornerRadius = UDim.new(0, 6)
        CopyCorner.Parent = CopyBtn

        CopyBtn.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard(linkStr)
                CopyBtn.Text = "✅ Copied!"
                task.delay(1.5, function()
                    CopyBtn.Text = "📋 Copy Link"
                end)
            end
        end)
    end

    -- ============================================ --
    --               TAB 1 CONTENT                  --
    -- ============================================ --
    AddInfoBox(Tab1_Page, "YE CODE COPY KARKE APNE PHONE MA DALO OUTFIT MA")

    local discoCode = "31CF3D9"
    AddItemWithCopy(Tab1_Page, "disco full map", discoCode, function()
        if game:GetService("ReplicatedStorage"):FindFirstChild("Network") then
            local remote = game:GetService("ReplicatedStorage").Network:FindFirstChild("RemoteEvent")
            if remote then remote:FireServer("disco", discoCode) end
        end
    end)


    -- ============================================ --
    --               TAB 2 CONTENT                  --
    -- ============================================ --
    AddInfoBox(Tab2_Page, "YE SCRIPT INIFINITE YIELD LOAD KARNA ANTIFLING OR WALKFLING LAGA LENA")

    AddRemoteScriptItem(Tab2_Page, "Yadsan Infinite Yield", "loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()")


    -- ============================================ --
    --               TAB 3 CONTENT                  --
    -- ============================================ --
    AddStepItem(Tab3_Page, "1 : PHELE CODE COPY KARLO")
    AddStepItem(Tab3_Page, "2 : PHIR PHONE KHOLO ITEM MA JAO AND SEARCH KRO CHAIR WHEELCHAIR NIKAALO PHIR OS PER BETH JAO")
    AddStepItem(Tab3_Page, "3 : PHIR PHONE KHOLO AND AVATAR PAR CLICK KRO AND CODE DALDO BAS")
    AddStepItem(Tab3_Page, "4 : PHIR MERA EMOTE HUB LOAD KARLO AND EMOTE MA SEARCH KARNA SPIN BAS")
    AddStepItem(Tab3_Page, "5 : BAS PHIR USE KRO AB OR INIFINITE YIELD LOAD KARNA ANTIFLING OR WALKFLING LAGA LENA ")
    AddStepItem(Tab3_Page, "1 : AGAR SAMAJ NI AYE TO BAAD MA VIDEO BANA DU GYA👽")

    AddVideoLinkCopy(Tab3_Page, "Copy Video Link", "https://youtube.com/your-video-link-here")

    print("YADSAN HUB Loaded Successfully with Infinite Yield Script & Info!")
end

-- Key check logic
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "MAP DESTROYER" then
        SubmitBtn.Text = "✅ Success!"
        task.delay(0.5, function()
            LoadMainHub()
        end)
    else
        SubmitBtn.Text = "❌ Wrong Key!"
        task.delay(1.5, function()
            SubmitBtn.Text = "Submit Key"
        end)
    end
end)

