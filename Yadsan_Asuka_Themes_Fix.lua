local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local SoundService = game:GetService("SoundService")
game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 10)

if not identifyexecutor or not identifyexecutor() then
	if getexecutorname then
		getexecutorname()
	end
end

local v1 = Color3.fromRGB(255, 0, 0)
local v2 = Color3.fromRGB(255, 0, 30)
local flag = false
local flag1 = true
local v3 = Color3.fromRGB(255, 0, 30)
local v4 = Color3.fromRGB(15, 15, 15)

task.spawn(function()
	local num = 0
	while task.wait(0.03) do
		num = (num + 0.008) % 1
		v1 = Color3.fromHSV(num, 0.85, 1)
	end
end)

local function func()
	if flag then
		return v1
	end

	if flag1 then
		local v5 = (math.sin(tick() * 3) + 1) / 2
		return v3:Lerp(v4, v5)
	end

	return v2
end

local sound = Instance.new("Sound")
sound.Name = "AsukaExecutionPhonk"
sound.SoundId = "rbxassetid://9043887091"
sound.Volume = 1
sound.Looped = true
sound.Parent = SoundService
sound:Play()

task.delay(10, function()
	if sound then
		sound:Stop()
		sound:Destroy()
	end
end)

local RE = ReplicatedStorage:WaitForChild("RE", 5)
local v5 = RE and RE:WaitForChild("1RPNam1eTex1t", 2)
local v6 = RE and RE:WaitForChild("1RPNam1eColo1r", 2)

local function func1()
	if v5 then
		pcall(function()
			v5:FireServer("RolePlayName", "♧-🔥- [Asuka Spammer V2 🚩]- ♧-🔥")
			v5:FireServer("RolePlayBio", "♤-[Yadsan_Godverse] ❄️💢 Asuka Spammer V2 🚩 ❄️💢 //  VS AFRAID 😂 -♤")
		end)
	end
end

task.spawn(function()
	if not v5 then
		return
	end
	func1()
end)

task.spawn(function()
	if not v6 then
		return
	end
	while task.wait(0.15) do
		pcall(function()
			local v1 = func()
			v6:FireServer("PickingRPNameColor", v1)
			v6:FireServer("PickingRPBioColor", v1)
		end)
	end
end)

local num = 3

local tbl = {
	"TMX MEH FIRE 🔥",
	"TMX MEH POWER ⚡",
	"TMX MEH DOMINANCE 👑",
	"TMX MEH BLAST 💥",
	"TMX MEH SHADOW 🌑",
	"TMX MEH OVERLOAD 💎",
	"TMX MEH TITAN 🛡️",
	"TMX MEH SUPREMACY 🔱",
	"TMX MEH VENOM 🐍",
	"TMX MEH STORM 🌀",
	"TMX MEH REIGN 👑",
	"TMX MEH APEX ⚡",
	"TMX MEH DESTROY 💥",
	"TMX MEH PHANTOM 🌑",
	"TMX MEH ECLIPSE 🔮",
	"TMX MEH THUNDER ⚡",
	"TMX MEH INFERNO 🔥",
	"TMX MEH WARLORD ⚔️",
	"TMX MEH DYNASTY 🔱",
	"TMX MEH CYBER 💎",
	"TMX MEH MATRIX 🌌",
	"TMX MEH OMEGA 🛡️",
	"TMX MEH HAVOC ☣️",
	"TMX MEH GODMODE 🏆",
	"TMX MEH IMPERIAL 👑",
}

local tbl1 = {
	"TMX KUDAI BY LION INDIA ELEPHANT USA ⚡",
	"TMX KUDAI BY TIGER JAPAN WOLF UK 💥",
	"TMX KUDAI BY SNAKE BRAZIL CROCODILE AUSTRALIA 🔥",
	"TMX KUDAI BY BEAR RUSSIA BISON CANADA 👑",
	"TMX KUDAI BY EAGLE GERMANY LEOPARD SOUTH AFRICA 💫",
	"TMX KUDAI BY GORILLA FRANCE SHARK MEXICO ⚡",
	"TMX KUDAI BY RHINO ITALY HIPPO SPAIN 👑",
	"TMX KUDAI BY PANTHER ARGENTINA SCORPION EGYPT 💥",
	"TMX KUDAI BY DRAGON CHINA HAWK SOUTH KOREA ⚡",
	"TMX KUDAI BY MAMMOTH SWEDEN CHEETAH NIGERIA 🔥",
	"TMX KUDAI BY WOLF NETHERLANDS BOAR TURKEY 🎭",
}

local tbl2 = {
	"TMX MARE LION INDIA 👑",
	"TMX MARE TIGER USA 🔥",
	"TMX MARE GORILLA UK 💥",
	"TMX MARE WOLF JAPAN 🎭",
	"TMX MARE EAGLE CANADA 💫",
	"TMX MARE BEAR RUSSIA 🏆",
	"TMX MARE RHINO BRAZIL 💎",
	"TMX MARE HIPPO SPAIN 🔱",
	"TMX MARE PANTHER ARGENTINA 🐉",
	"TMX MARE WOLF NETHERLANDS ⚔️",
	"TMX MARE SCORPION EGYPT 🌑",
	"TMX MARE HAWK SOUTH KOREA 🚀",
}

local function func2()
	local v1 = string.upper(LocalPlayer.Name)
	return {
		v1 .. " ON TOP 👑",
		"UNLEASHED BY " .. v1 .. " ⚡",
		"ASUKA SUPREMACY WITH " .. v1 .. " 🔥",
		"ALL FAIL BEFORE " .. v1 .. " 🔱",
		v1 .. " RUNS THIS SERVER ⚔️",
		v1 .. " ON TOP ALWAYS 💎",
		v1 .. " DOMINATING EVERYONE ☠️",
		v1 .. " IS UNSTOPPABLE 🩸",
		"SYSTEM OVERRIDDEN BY " .. v1 .. " 🌌",
		v1 .. " HAS NO MATCH 🏆",
	}
end

local tbl3 = {
	"@@@@@@_______++++",
	"@@@@@@@@-----/////",
	"//--//--//--//--//",
	"====////====////==",
	"/\\/\\/\\/\\/\\/\\/\\/\\",
	"@+----+----+----+",
	"<=>=<=>=<=>=<=>=",
	"\\\\////\\\\////\\\\////",
	"===---===---===---",
}

local num1 = 1
local str = "TMX MEH"
local tbl4 = {"TMX MEH", "ANIMAL", "MARE", "FOR U"}

local function func3(arg1)
	local v1 = str

	if v1 == "SHUFFLE" then
		v1 = tbl4[(arg1 - 1) % #tbl4 + 1]
	end

	if v1 == "ANIMAL" then
		return tbl1
	end

	if v1 == "MARE" then
		return tbl2
	end

	if v1 == "FOR U" then
		return (func2())
	end

	return tbl
end

local function func4(arg1)
	return utf8.len(arg1) or #arg1
end

local function func5(arg1, arg2, arg3)
	local v1 = math.clamp(arg3 or 120, 5, 140)
	local v2 = arg1 and arg1 ~= "" and arg1 or "@@@@@@_______++++"
	local v3 = string.upper(string.gsub(v2, "%s+", ""))

	if v3 == "" then
		v3 = "@@@@@@_______++++"
	end

	if v3 == "MIXED" or v3 == "=/" or v3 == "/=" then
		local str = ""
		local tbl = {"=", "/"}
		local v4 = arg2

		while func4(str) < v1 do
			local v5 = tbl[v4 % #tbl + 1]

			if func4(str) + func4(v5) > v1 then
				break
			end

			str = str .. v5
			v4 = v4 + 1
		end

		return str
	end

	if v3 == "HIDE" or v3 == "INVISIBLE" or v3 == "INV" or v3 == "ZWS" or v3 == "NONE" then
		local str1 = ""

		for _ = 1, v1 do
			str1 = str1 .. "​"
		end

		return str1
	end

	local v6 = string.gsub(v2, "^%s*(.-)%s*$", "%1")

	if v6 == "" then
		v6 = "@@@@@@_______++++"
	end

	local str2 = ""
	local num = 0
	local v7 = func4(v6)

	if v7 == 0 then
		v6 = "@@@@@@_______++++"
		v7 = func4("@@@@@@_______++++")
	end

	while num + v7 <= v1 do
		str2 = str2 .. v6
		num = num + v7
	end

	return str2
end

local function func6(arg1)
	task.spawn(function()
		pcall(function()
			if TextChatService and TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
				local TextChannels = TextChatService:FindFirstChild("TextChannels")
				if TextChannels then
					local v1 = TextChannels:FindFirstChild("RBXGeneral") or TextChannels:FindFirstChildOfClass("TextChannel")
					if v1 then
						v1:SendAsync(arg1)
					end
				end
			end
		end)
		pcall(function()
			local v1 = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
			if v1 then
				v1:FireServer(arg1, "All")
			end
		end)
	end)
end

local function func7(parent, arg2)
	local frame = Instance.new("Frame")
	frame.Name = "ParticleContainer"
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.ZIndex = 1
	frame.Active = false
	frame.Parent = parent
	local tbl = {}
	local tbl1 = {"✦", "★", "✨", "✧", "❖", "░▒▓█", "🎭", "⚡", "👑", "💥", "🐍", "💎", "💔", "⚔️", "🔥", "🔮", "🌑"}

	for i = 1, arg2 do
		local v1 = i % 4
		local v2

		if v1 == 1 or v1 == 3 then
			local textLabel = Instance.new("TextLabel")
			textLabel.Text = tbl1[math.random(1, #tbl1)]
			textLabel.Size = UDim2.new(0, math.random(10, 18), 0, math.random(10, 18))
			textLabel.TextColor3 = Color3.fromRGB(255, math.random(40, 120), math.random(40, 120))
			textLabel.Font = Enum.Font.Code
			textLabel.TextSize = math.random(9, 14)
			textLabel.BackgroundTransparency = 1
			v2 = textLabel
		else
			local frame1 = Instance.new("Frame")
			frame1.Size = UDim2.new(0, math.random(3, 6), 0, math.random(3, 6))
			frame1.BackgroundColor3 = Color3.fromRGB(math.random(200, 255), math.random(20, 80), math.random(20, 80))
			frame1.BorderSizePixel = 0
			Instance.new("UICorner", frame1).CornerRadius = UDim.new(i % 2, 0)
			v2 = frame1
		end

		v2.Position = UDim2.new(math.random(2, 98) / 100, 0, math.random(2, 98) / 100, 0)
		v2.ZIndex = 1
		v2.Parent = frame
		local insert = table.insert

		local tbl2 = {
			element = v2,
			speedY = math.random(6, 22) / 10,
			speedX = math.random(-6, 6) / 10,
			dirY = i % 2 == 0 and 1 or -1,
		}

		tbl2.phase = math.random() * math.pi * 2
		insert(tbl, tbl2)
	end

	RunService.RenderStepped:Connect(function(deltaTime)
		for _, v1 in ipairs(tbl) do
			if v1.element and v1.element.Parent then
				local element = v1.element
				local Scale = element.Position.X.Scale
				local v2 = element.Position.Y.Scale + v1.speedY * deltaTime * 0.05 * v1.dirY
				local v3 = Scale + math.sin(tick() * 2 + v1.phase) * 0.002 + v1.speedX * deltaTime * 0.015

				if v2 > 0.95 then
					v1.dirY = -1
				elseif v2 < 0.03 then
					v1.dirY = 1
				end

				if v3 > 0.96 or v3 < 0.02 then
					v1.speedX = -v1.speedX
				end

				element.Position = UDim2.new(v3, 0, v2, 0)
			end
		end
	end)
end

local function func8(arg1, arg2, arg3)
	arg1.MouseEnter:Connect(function()
		TweenService:Create(arg1, TweenInfo.new(0.2), {BackgroundColor3 = arg2}):Play()
	end)
	arg1.MouseLeave:Connect(function()
		TweenService:Create(arg1, TweenInfo.new(0.2), {BackgroundColor3 = arg3}):Play()
	end)
end

local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "Asuka_Spammer_Landscape_Edition"
screenGui.ResetOnSpawn = false
local frame4 = Instance.new("Frame", screenGui)
frame4.Size = UDim2.new(0, 450, 0, 260)
frame4.Position = UDim2.new(0.5, -225, 0.5, -130)
frame4.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
frame4.BorderSizePixel = 0
frame4.ClipsDescendants = true
frame4.Visible = true
Instance.new("UICorner", frame4).CornerRadius = UDim.new(0, 12)
local uIStroke3 = Instance.new("UIStroke", frame4)
uIStroke3.Thickness = 2
uIStroke3.Color = func()
func7(frame4, 24)
local frame5 = Instance.new("Frame", frame4)
frame5.Size = UDim2.new(0, 65, 0, 65)
frame5.Position = UDim2.new(0.5, -32, 0.12, 0)
frame5.BackgroundTransparency = 1
frame5.ZIndex = 3
local imageLabel1 = Instance.new("ImageLabel", frame5)
imageLabel1.Size = UDim2.new(1, 0, 1, 0)
imageLabel1.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
imageLabel1.ZIndex = 3
Instance.new("UICorner", imageLabel1).CornerRadius = UDim.new(1, 0)
local uIStroke4 = Instance.new("UIStroke", imageLabel1)
uIStroke4.Thickness = 2
uIStroke4.Color = func()

pcall(function()
	imageLabel1.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
end)

local textLabel4 = Instance.new("TextLabel", frame4)
textLabel4.Size = UDim2.new(1, 0, 0, 22)
textLabel4.Position = UDim2.new(0, 0, 0.42, 0)
textLabel4.Text = "WELCOME, " .. string.upper(LocalPlayer.DisplayName) .. " 👑"
textLabel4.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel4.Font = Enum.Font.Code
textLabel4.TextSize = 12
textLabel4.BackgroundTransparency = 1
textLabel4.ZIndex = 3
local textLabel5 = Instance.new("TextLabel", frame4)
textLabel5.Size = UDim2.new(1, 0, 0, 18)
textLabel5.Position = UDim2.new(0, 0, 0.52, 0)
textLabel5.Text = "🎭 ASUKA SPAMMER V2 🚩 RECTANGULAR CYBER ENGINE ⚡"
textLabel5.TextColor3 = Color3.fromRGB(180, 190, 220)
textLabel5.Font = Enum.Font.Code
textLabel5.TextSize = 9
textLabel5.BackgroundTransparency = 1
textLabel5.ZIndex = 3
local textButton1 = Instance.new("TextButton", frame4)
textButton1.Size = UDim2.new(0, 200, 0, 34)
textButton1.Position = UDim2.new(0.5, -100, 0.72, 0)
textButton1.Text = "🚀 LAUNCH CYBER CORE 🚩"
textButton1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textButton1.TextColor3 = Color3.fromRGB(12, 12, 18)
textButton1.Font = Enum.Font.Code
textButton1.TextSize = 10
textButton1.ZIndex = 3
Instance.new("UICorner", textButton1).CornerRadius = UDim.new(0, 8)
func8(textButton1, Color3.fromRGB(220, 220, 255), Color3.fromRGB(255, 255, 255))
local frame6 = Instance.new("Frame", screenGui)
frame6.Size = UDim2.new(0, 620, 0, 375)
frame6.Position = UDim2.new(0.5, -310, 0.5, -187)
frame6.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
frame6.Active = true
frame6.Draggable = true
frame6.Visible = false
Instance.new("UICorner", frame6).CornerRadius = UDim.new(0, 10)
local uIStroke5 = Instance.new("UIStroke", frame6)
uIStroke5.Thickness = 2
uIStroke5.Color = func()
func7(frame6, 22)
local frame7 = Instance.new("Frame", screenGui)
frame7.Name = "AsukaFloatingLogo"
frame7.Size = UDim2.new(0, 54, 0, 54)
frame7.Position = UDim2.new(0, 15, 0.45, 0)
frame7.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
frame7.Visible = false
frame7.Active = true
frame7.ZIndex = 10
Instance.new("UICorner", frame7).CornerRadius = UDim.new(1, 0)
local uIStroke6 = Instance.new("UIStroke", frame7)
uIStroke6.Thickness = 2
uIStroke6.Color = func()
func7(frame7, 14)
local textLabel6 = Instance.new("TextLabel", frame7)
textLabel6.Size = UDim2.new(1, 0, 1, 0)
textLabel6.BackgroundTransparency = 1
textLabel6.Text = "𝖁"
textLabel6.Font = Enum.Font.Code
textLabel6.TextSize = 28
textLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel6.ZIndex = 11
local textLabel7 = Instance.new("TextLabel", frame7)
textLabel7.Size = UDim2.new(1, 0, 1, 0)
textLabel7.Position = UDim2.new(0, 0, 0, 0)
textLabel7.BackgroundTransparency = 1
textLabel7.Text = "YS"
textLabel7.Font = Enum.Font.Code
textLabel7.TextSize = 36
textLabel7.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel7.ZIndex = 13
local textButton2 = Instance.new("TextButton", frame7)
textButton2.Size = UDim2.new(1, 0, 1, 0)
textButton2.BackgroundTransparency = 1
textButton2.Text = ""
textButton2.ZIndex = 14

local function func9(arg1, arg2, arg3)
	local flag = false
	local v1
	local Position
	local Position1
	local flag1 = false

	arg2.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag = true
			flag1 = false
			Position = input.Position
			Position1 = arg1.Position
			local connection

			connection = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag = false

					if connection then
						connection:Disconnect()
					end

					if not flag1 and arg3 then
						arg3()
					end
				end
			end)
		end
	end)

	arg2.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			v1 = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == v1 and flag then
			local v2 = input.Position - Position

			if v2.Magnitude > 6 then
				flag1 = true
			end

			if flag1 then
				arg1.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v2.X, Position1.Y.Scale, Position1.Y.Offset + v2.Y)
			end
		end
	end)
end

local textButton3 = Instance.new("TextButton", frame6)
textButton3.Size = UDim2.new(0, 26, 0, 26)
textButton3.Position = UDim2.new(1, -32, 0, 6)
textButton3.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
textButton3.Text = "−"
textButton3.TextColor3 = func()
textButton3.Font = Enum.Font.Code
textButton3.TextSize = 22
textButton3.ZIndex = 6
Instance.new("UICorner", textButton3).CornerRadius = UDim.new(0, 6)

local function func10()
	if frame6.Visible then
		frame6.Visible = false
		frame7.Visible = true
	else
		frame6.Visible = true
		frame7.Visible = false
	end
end

func9(frame7, textButton2, func10)
textButton3.MouseButton1Click:Connect(func10)
local frame8 = Instance.new("Frame", frame6)
frame8.Size = UDim2.new(0, 165, 1, -12)
frame8.Position = UDim2.new(0, 6, 0, 6)
frame8.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
frame8.ZIndex = 3
Instance.new("UICorner", frame8).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", frame8).Color = Color3.fromRGB(45, 45, 60)
local frame9 = Instance.new("Frame", frame8)
frame9.Size = UDim2.new(0, 34, 0, 34)
frame9.Position = UDim2.new(0, 10, 0, 9)
frame9.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
frame9.ZIndex = 4
Instance.new("UICorner", frame9).CornerRadius = UDim.new(1, 0)
local uIStroke7 = Instance.new("UIStroke", frame9)
uIStroke7.Thickness = 2
uIStroke7.Color = func()
local textLabel8 = Instance.new("TextLabel", frame9)
textLabel8.Size = UDim2.new(1, 0, 1, 0)
textLabel8.Text = "𝖁"
textLabel8.Font = Enum.Font.Code
textLabel8.TextSize = 20
textLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel8.BackgroundTransparency = 1
textLabel8.ZIndex = 5
local textLabel9 = Instance.new("TextLabel", frame9)
textLabel9.Size = UDim2.new(1, 0, 1, 0)
textLabel9.Position = UDim2.new(0, 0, 0, 0)
textLabel9.BackgroundTransparency = 1
textLabel9.Text = "ASUKA"
textLabel9.Font = Enum.Font.Code
textLabel9.TextSize = 24
textLabel9.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel9.ZIndex = 6
local textLabel10 = Instance.new("TextLabel", frame8)
textLabel10.Size = UDim2.new(1, -52, 0, 34)
textLabel10.Position = UDim2.new(0, 48, 0, 9)
textLabel10.Text = "ASUKA V3 🎭"
textLabel10.TextColor3 = func()
textLabel10.TextSize = 11
textLabel10.Font = Enum.Font.Code
textLabel10.BackgroundTransparency = 1
textLabel10.TextXAlignment = Enum.TextXAlignment.Left
textLabel10.ZIndex = 4
local frame10 = Instance.new("Frame", frame8)
frame10.Size = UDim2.new(1, -16, 0, 110)
frame10.Position = UDim2.new(0, 8, 0, 50)
frame10.BackgroundTransparency = 1
frame10.ZIndex = 4
-- Stack Spam / Themes / Dev buttons vertically instead of overlapping.
local frame10Layout = Instance.new("UIListLayout", frame10)
frame10Layout.FillDirection = Enum.FillDirection.Vertical
frame10Layout.SortOrder = Enum.SortOrder.LayoutOrder
frame10Layout.Padding = UDim.new(0, 6)
Instance.new("UIListLayout", frame10).Padding = UDim.new(0, 6)
local frame11 = Instance.new("Frame", frame6)
frame11.Size = UDim2.new(1, -183, 1, -12)
frame11.Position = UDim2.new(0, 177, 0, 6)
frame11.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
frame11.ZIndex = 3
Instance.new("UICorner", frame11).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", frame11).Color = Color3.fromRGB(45, 45, 60)
local frame12 = Instance.new("Frame", frame11)
frame12.Size = UDim2.new(1, -12, 1, -12)
frame12.Position = UDim2.new(0, 6, 0, 6)
frame12.BackgroundTransparency = 1
frame12.ZIndex = 3



local function func11(name)
	local scrollingFrame = Instance.new("ScrollingFrame", frame12)
	scrollingFrame.Name = name
	scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	scrollingFrame.BackgroundTransparency = 1
	scrollingFrame.Visible = false
	scrollingFrame.ScrollBarThickness = 3
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
	scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 140)
	scrollingFrame.ZIndex = 3
	return scrollingFrame
end

local v7 = func11("Spam")
local v8 = func11("Themes")
local v9 = func11("Dev")
v7.Visible = true

local function func12(arg1)
	for _, child in pairs(frame12:GetChildren()) do
		child.Visible = child.Name == arg1
	end
end

local tbl5 = {}

local function func13(arg1)
	local textButton = Instance.new("TextButton", frame10)
	textButton.Size = UDim2.new(1, 0, 0, 30)
	textButton.Text = "❖" .. string.upper(arg1)
	textButton.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
	textButton.TextColor3 = func()
	textButton.TextSize = 10
	textButton.Font = Enum.Font.Code
	textButton.TextXAlignment = Enum.TextXAlignment.Left
	textButton.ZIndex = 5
	Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)
	Instance.new("UIPadding", textButton).PaddingLeft = UDim.new(0, 10)

	textButton.MouseButton1Click:Connect(function()
		func12(arg1)
	end)

	table.insert(tbl5, textButton)
end

func13("Spam")
func13("Themes")
func13("Dev")
local frame13 = Instance.new("Frame", frame8)
frame13.Size = UDim2.new(1, -16, 0, 135)
frame13.Position = UDim2.new(0, 8, 0, 168)
frame13.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
frame13.ZIndex = 4
Instance.new("UICorner", frame13).CornerRadius = UDim.new(0, 6)
local textLabel11 = Instance.new("TextLabel", frame13)
textLabel11.Size = UDim2.new(1, 0, 0, 20)
textLabel11.Text = "⚙️ MODE SELECTOR"
textLabel11.TextColor3 = Color3.fromRGB(180, 180, 200)
textLabel11.Font = Enum.Font.Code
textLabel11.TextSize = 8
textLabel11.BackgroundTransparency = 1
textLabel11.ZIndex = 5
local scrollingFrame = Instance.new("ScrollingFrame", frame13)
scrollingFrame.Size = UDim2.new(1, -6, 1, -24)
scrollingFrame.Position = UDim2.new(0, 3, 0, 20)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ScrollBarThickness = 2
scrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
scrollingFrame.ZIndex = 5
Instance.new("UIListLayout", scrollingFrame).Padding = UDim.new(0, 3)
local tbl6 = {}

local function func14(arg1)
	str = arg1
	for k, v1 in pairs(tbl6) do
		if k == arg1 then
			v1.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
			v1.TextColor3 = func()
		else
			v1.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
			v1.TextColor3 = Color3.fromRGB(200, 200, 200)
		end
	end
end

local function func15(arg1, text)
	local textButton = Instance.new("TextButton", scrollingFrame)
	textButton.Size = UDim2.new(1, -4, 0, 22)
	textButton.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
	textButton.Text = text
	textButton.TextColor3 = Color3.fromRGB(200, 200, 200)
	textButton.Font = Enum.Font.Code
	textButton.TextSize = 8
	textButton.ZIndex = 6
	Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 4)

	textButton.MouseButton1Click:Connect(function()
		func14(arg1)
	end)

	tbl6[arg1] = textButton
end

func15("TMX MEH", "💠 TMX MEH MODE")
func15("ANIMAL", "🗽 ANIMAL MODE")
func15("MARE", "👑 MARE MODE")
func15("FOR U", "⚡️FOR U MODE")
func15("SHUFFLE", "🔀 SHUFFLE ALL")
func14("TMX MEH")
Instance.new("UIListLayout", v7).Padding = UDim.new(0, 8)
local frame14 = Instance.new("Frame", v7)
frame14.Size = UDim2.new(0.98, 0, 0, 105)
frame14.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
frame14.ZIndex = 4
Instance.new("UICorner", frame14).CornerRadius = UDim.new(0, 8)
local uIStroke8 = Instance.new("UIStroke", frame14)
uIStroke8.Color = Color3.fromRGB(55, 55, 75)
func7(frame14, 10)
local textLabel12 = Instance.new("TextLabel", frame14)
textLabel12.Size = UDim2.new(1, -12, 0, 20)
textLabel12.Position = UDim2.new(0, 8, 0, 4)
textLabel12.Text = "🎯 TARGET MATRIX CONFIGURATION (4 SLOTS) ⚡"
textLabel12.TextColor3 = Color3.fromRGB(255, 200, 100)
textLabel12.Font = Enum.Font.Code
textLabel12.TextSize = 9
textLabel12.TextXAlignment = Enum.TextXAlignment.Left
textLabel12.BackgroundTransparency = 1
textLabel12.ZIndex = 5
local frame15 = Instance.new("Frame", frame14)
frame15.Size = UDim2.new(1, -12, 0, 72)
frame15.Position = UDim2.new(0, 6, 0, 26)
frame15.BackgroundTransparency = 1
frame15.ZIndex = 5
local tbl7 = {}

local function func16(arg1, position)
	local frame = Instance.new("Frame", frame15)
	frame.Size = UDim2.new(0.485, 0, 0, 32)
	frame.Position = position
	frame.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
	frame.ZIndex = 5
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
	Instance.new("UIStroke", frame).Color = Color3.fromRGB(45, 45, 65)
	local textBox = Instance.new("TextBox", frame)
	textBox.Size = UDim2.new(1, 0, 1, 0)
	textBox.BackgroundTransparency = 1
	textBox.PlaceholderText = "🎯 TARGET " .. arg1 .. "..."
	textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
	textBox.Text = ""
	textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	textBox.Font = Enum.Font.Code
	textBox.TextSize = 9
	textBox.ClearTextOnFocus = false
	textBox.ZIndex = 6
	Instance.new("UIPadding", textBox).PaddingLeft = UDim.new(0, 8)
	table.insert(tbl7, textBox)
end

func16(1, UDim2.new(0, 0, 0, 0))
func16(2, UDim2.new(0.515, 0, 0, 0))
func16(3, UDim2.new(0, 0, 0, 38))
func16(4, UDim2.new(0.515, 0, 0, 38))
local frame16 = Instance.new("Frame", v7)
frame16.Size = UDim2.new(0.98, 0, 0, 30)
frame16.BackgroundTransparency = 1
frame16.ZIndex = 4
local frame17 = Instance.new("Frame", frame16)
frame17.Size = UDim2.new(0.38, 0, 1, 0)
frame17.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
frame17.ZIndex = 4
Instance.new("UICorner", frame17).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", frame17).Color = Color3.fromRGB(55, 55, 70)
local textBox1 = Instance.new("TextBox", frame17)
textBox1.Size = UDim2.new(1, 0, 1, 0)
textBox1.BackgroundTransparency = 1
textBox1.Text = "@@@@@@_______++++"
textBox1.PlaceholderText = "// 🏷️ TAG"
textBox1.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
textBox1.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox1.Font = Enum.Font.Code
textBox1.TextSize = 9
textBox1.ZIndex = 5
textBox1.ClearTextOnFocus = false
Instance.new("UIPadding", textBox1).PaddingLeft = UDim.new(0, 8)
local textButton4 = Instance.new("TextButton", frame16)
textButton4.Size = UDim2.new(0.24, 0, 1, 0)
textButton4.Position = UDim2.new(0.4, 0, 0, 0)
textButton4.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
textButton4.Text = "🏷️ PRESET"
textButton4.TextColor3 = Color3.fromRGB(200, 220, 255)
textButton4.Font = Enum.Font.Code
textButton4.TextSize = 8.5
textButton4.ZIndex = 5
Instance.new("UICorner", textButton4).CornerRadius = UDim.new(0, 6)

textButton4.MouseButton1Click:Connect(function()
	num1 = num1 % #tbl3 + 1
	textBox1.Text = tbl3[num1]
end)

local frame18 = Instance.new("Frame", frame16)
frame18.Size = UDim2.new(0.34, 0, 1, 0)
frame18.Position = UDim2.new(0.66, 0, 0, 0)
frame18.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
frame18.ZIndex = 4
Instance.new("UICorner", frame18).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", frame18).Color = Color3.fromRGB(55, 55, 70)
local textBox2 = Instance.new("TextBox", frame18)
textBox2.Size = UDim2.new(1, 0, 1, 0)
textBox2.BackgroundTransparency = 1
textBox2.Text = "3.0"
textBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox2.Font = Enum.Font.Code
textBox2.TextSize = 9.5
textBox2.ZIndex = 5
textBox2.ClearTextOnFocus = false
Instance.new("UIPadding", textBox2).PaddingLeft = UDim.new(0, 8)

textBox2.FocusLost:Connect(function()
	local num1 = tonumber(textBox2.Text)
	if num1 and num1 >= 0 then
		num = num1
	else
		textBox2.Text = tostring(num)
	end
end)

local textButton5 = Instance.new("TextButton", v7)
textButton5.Size = UDim2.new(0.98, 0, 0, 36)
textButton5.Text = "💻 INITIALIZE TERMINAL // SPAM PIPELINE ⚡"
textButton5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textButton5.TextColor3 = Color3.fromRGB(14, 14, 20)
textButton5.Font = Enum.Font.Code
textButton5.TextSize = 10
textButton5.ZIndex = 4
Instance.new("UICorner", textButton5).CornerRadius = UDim.new(0, 6)
func8(textButton5, Color3.fromRGB(220, 220, 255), Color3.fromRGB(255, 255, 255))
local frame19 = Instance.new("Frame", v7)
frame19.Size = UDim2.new(0.98, 0, 0, 88)
frame19.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
frame19.ZIndex = 4
Instance.new("UICorner", frame19).CornerRadius = UDim.new(0, 8)
local uIStroke9 = Instance.new("UIStroke", frame19)
uIStroke9.Color = Color3.fromRGB(45, 45, 65)
func7(frame19, 12)
local frame20 = Instance.new("Frame", frame19)
frame20.Size = UDim2.new(0, 48, 0, 48)
frame20.Position = UDim2.new(0, 10, 0.5, -24)
frame20.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
frame20.ZIndex = 5
Instance.new("UICorner", frame20).CornerRadius = UDim.new(1, 0)
local uIStroke10 = Instance.new("UIStroke", frame20)
uIStroke10.Thickness = 2
uIStroke10.Color = func()
local textLabel13 = Instance.new("TextLabel", frame20)
textLabel13.Size = UDim2.new(1, 0, 1, 0)
textLabel13.Text = "𝖁"
textLabel13.Font = Enum.Font.Code
textLabel13.TextSize = 26
textLabel13.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel13.BackgroundTransparency = 1
textLabel13.ZIndex = 6
local textLabel14 = Instance.new("TextLabel", frame20)
textLabel14.Size = UDim2.new(1, 0, 1, 0)
textLabel14.Position = UDim2.new(0, 0, 0, 0)
textLabel14.BackgroundTransparency = 1
textLabel14.Text = "ASUKA"
textLabel14.Font = Enum.Font.Code
textLabel14.TextSize = 32
textLabel14.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel14.ZIndex = 7
local textLabel15 = Instance.new("TextLabel", frame19)
textLabel15.Size = UDim2.new(1, -70, 0, 20)
textLabel15.Position = UDim2.new(0, 66, 0, 8)
textLabel15.Text = "⚡ ENGINE STATUS: STANDBY // READY FOR PIPELINE"
textLabel15.TextColor3 = Color3.fromRGB(100, 255, 180)
textLabel15.Font = Enum.Font.Code
textLabel15.TextSize = 8.5
textLabel15.TextXAlignment = Enum.TextXAlignment.Left
textLabel15.BackgroundTransparency = 1
textLabel15.ZIndex = 5
local textLabel16 = Instance.new("TextLabel", frame19)
textLabel16.Size = UDim2.new(1, -70, 0, 48)
textLabel16.Position = UDim2.new(0, 66, 0, 28)
textLabel16.Text = "🎯 TARGET FORMAT: [TARGET] | 💥 PARTICLES: DYNAMIC\n🐍 MODE: SYNCHRONIZED | 💔 ASUKA CORE V3\n📡 BROADCAST: SERVER GLOBAL REPLICATED"
textLabel16.TextColor3 = Color3.fromRGB(180, 180, 210)
textLabel16.Font = Enum.Font.Code
textLabel16.TextSize = 8
textLabel16.TextXAlignment = Enum.TextXAlignment.Left
textLabel16.BackgroundTransparency = 1
textLabel16.ZIndex = 5
local flag3 = false
local v11

textButton5.MouseButton1Click:Connect(function()
	flag3 = not flag3
	if flag3 then
		if v11 then
			task.cancel(v11)
			v11 = nil
		end

		textButton5.Text = "🛑 HALT TERMINAL PIPELINE 🛑"
		textButton5.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
		textButton5.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel15.Text = "🔥 ENGINE STATUS: ACTIVE // SPAMMING TARGET PIPELINE..."
		textLabel15.TextColor3 = Color3.fromRGB(255, 100, 100)

		v11 = task.spawn(function()
			local num1 = 0
			while flag3 do
				num1 = num1 + 1
				local tbl = {}

				for _, v1 in ipairs(tbl7) do
					if v1.Text and v1.Text ~= "" then
						local v2 = string.gsub(v1.Text, "^%s*(.-)%s*$", "%1")
						if v2 ~= "" then
							table.insert(tbl, v2)
						end
					end
				end

				local str = ""

				if #tbl > 0 then
					str = "[" .. tbl[(num1 - 1) % #tbl + 1] .. "] "
				end

				local v3 = func3(num1)
				local v4 = str .. v3[(num1 - 1) % #v3 + 1]
				local v5 = func4(v4)
				local v6 = math.clamp(180 - v5 - 1, 5, 140)
				local v7 = func5(textBox1.Text, num1, v6)
				func6((v7 ~= "" and v7 .. " " or "") .. v4)
				task.wait(num)
			end
		end)
	else
		if v11 then
			task.cancel(v11)
			v11 = nil
		end

		textButton5.Text = "💻 INITIALIZE TERMINAL // SPAM PIPELINE ⚡"
		textButton5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		textButton5.TextColor3 = Color3.fromRGB(14, 14, 20)
		textLabel15.Text = "⚡ ENGINE STATUS: STANDBY // READY FOR PIPELINE"
		textLabel15.TextColor3 = Color3.fromRGB(100, 255, 180)
	end
end)

v8.CanvasSize = UDim2.new(0, 0, 0, 0)
local uIListLayout = Instance.new("UIListLayout", v8)
uIListLayout.Padding = UDim.new(0, 6)
uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
-- Keep all theme buttons reachable on short/mobile screens.
v8.AutomaticCanvasSize = Enum.AutomaticSize.Y
local tbl8 = {}

local function func17(backgroundColor3, arg2, backgroundColor31, arg4, arg5, arg6)
	flag = arg4 or false
	flag1 = arg5 or false
	v2 = arg2
	v3 = arg2
	v4 = arg6 or arg2
	frame6.BackgroundColor3 = backgroundColor3
	uIStroke5.Color = func()
	textLabel10.TextColor3 = func()
	uIStroke7.Color = func()
	uIStroke10.Color = func()

	for _, v1 in ipairs(tbl8) do
		if v1 then
			v1.BackgroundColor3 = backgroundColor31
		end
	end
end

local function func18(arg1, arg2, textColor3, backgroundColor3, arg5, arg6, arg7)
	local textButton = Instance.new("TextButton", v8)
	textButton.Size = UDim2.new(0.98, 0, 0, 32)
	textButton.Text = "❖ " .. string.upper(arg1)
	textButton.TextColor3 = textColor3
	textButton.BackgroundColor3 = backgroundColor3
	textButton.Font = Enum.Font.Code
	textButton.TextSize = 11
	textButton.TextWrapped = false
	textButton.TextXAlignment = Enum.TextXAlignment.Left
	textButton.ZIndex = 4
	Instance.new("UIPadding", textButton).PaddingLeft = UDim.new(0, 8)
	Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)
	local uIStroke = Instance.new("UIStroke", textButton)
	uIStroke.Color = textColor3
	uIStroke.Thickness = 1.5
	table.insert(tbl8, textButton)

	textButton.MouseButton1Click:Connect(function()
		func17(arg2, textColor3, backgroundColor3, arg5, arg6, arg7)
	end)
end

local tbl9 = {
	"⚡ Crimson + Obsidian (Default Asuka)",
	Color3.fromRGB(10, 10, 14),
	Color3.fromRGB(255, 0, 30),
	Color3.fromRGB(18, 14, 18),
	false,
	true,
	Color3.fromRGB(15, 15, 15),
}

local tbl10 = {
	"🌈 RGB Dynamic Chroma Cycle",
	Color3.fromRGB(12, 12, 18),
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(18, 18, 26),
	true,
	false,
}

local tbl11 = {
	"⚡ Cyber Neon (Cyan + Pink)",
	Color3.fromRGB(10, 10, 16),
	Color3.fromRGB(0, 240, 255),
	Color3.fromRGB(16, 16, 24),
	false,
	true,
	Color3.fromRGB(255, 0, 150),
}

local tbl12 = {
	"🔥 Inferno Frost (Red + Blue)",
	Color3.fromRGB(14, 10, 14),
	Color3.fromRGB(255, 50, 50),
	Color3.fromRGB(22, 14, 20),
	false,
	true,
	Color3.fromRGB(50, 180, 255),
}

local tbl13 = {
	"🧪 Toxic Venom (Lime + Purple)",
	Color3.fromRGB(10, 14, 10),
	Color3.fromRGB(50, 255, 100),
	Color3.fromRGB(16, 22, 16),
	false,
	true,
	Color3.fromRGB(170, 0, 255),
}

local tbl14 = {
	"💜 Midnight Violet (Electric Purple + Midnight)",
	Color3.fromRGB(12, 8, 18),
	Color3.fromRGB(180, 50, 255),
	Color3.fromRGB(20, 14, 28),
	false,
	true,
	Color3.fromRGB(20, 10, 40),
}

local tbl15 = {
	"👑 Royal Gold (Gold + Onyx)",
	Color3.fromRGB(14, 12, 8),
	Color3.fromRGB(255, 200, 40),
	Color3.fromRGB(22, 18, 12),
	false,
	true,
	Color3.fromRGB(20, 20, 20),
}

local tbl16 = {
	"🌊 Abyssal Aqua (Turquoise + Navy)",
	Color3.fromRGB(8, 14, 18),
	Color3.fromRGB(0, 220, 200),
	Color3.fromRGB(12, 20, 26),
	false,
	true,
	Color3.fromRGB(10, 30, 60),
}

local tbl17 = {
	"🌅 Sunset Flare (Orange + Magenta)",
	Color3.fromRGB(16, 10, 10),
	Color3.fromRGB(255, 120, 0),
	Color3.fromRGB(24, 14, 16),
	false,
	true,
	Color3.fromRGB(200, 0, 100),
}

local tbl18 = {
	"🌸 Sakura Drift (Pink + Charcoal)",
	Color3.fromRGB(16, 12, 16),
	Color3.fromRGB(255, 110, 180),
	Color3.fromRGB(24, 16, 22),
	false,
	true,
	Color3.fromRGB(30, 30, 35),
}

local tbl19 = {
	"⚡ Solar Plasma (Yellow + Graphite)",
	Color3.fromRGB(14, 14, 8),
	Color3.fromRGB(255, 240, 0),
	Color3.fromRGB(22, 22, 14),
	false,
	true,
	Color3.fromRGB(25, 25, 30),
}

local tbl20 = {
	"❄️ Arctic Glitch (Ice White + Cyan)",
	Color3.fromRGB(10, 14, 18),
	Color3.fromRGB(200, 240, 255),
	Color3.fromRGB(16, 22, 28),
	false,
	true,
	Color3.fromRGB(0, 150, 255),
}

for _, v10 in ipairs({tbl9, tbl10, tbl11, tbl12, tbl13, tbl14, tbl15, tbl16, tbl17, tbl18, tbl19, tbl20}) do
	func18(v10[1], v10[2], v10[3], v10[4], v10[5], v10[6], v10[7])
end

v9.CanvasSize = UDim2.new(0, 0, 1.8, 0)
local frame21 = Instance.new("Frame", v9)
frame21.Size = UDim2.new(0.98, 0, 0, 280)
frame21.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
frame21.ClipsDescendants = true
frame21.ZIndex = 3
Instance.new("UICorner", frame21).CornerRadius = UDim.new(0, 10)
local uIStroke11 = Instance.new("UIStroke", frame21)
uIStroke11.Color = func()
uIStroke11.Thickness = 2
func7(frame21, 22)
local frame22 = Instance.new("Frame", frame21)
frame22.Size = UDim2.new(0, 64, 0, 64)
frame22.Position = UDim2.new(0.5, -32, 0.04, 0)
frame22.BackgroundTransparency = 1
frame22.ZIndex = 4
local imageLabel2 = Instance.new("ImageLabel", frame22)
imageLabel2.Size = UDim2.new(1, 0, 1, 0)
imageLabel2.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
imageLabel2.ZIndex = 4
Instance.new("UICorner", imageLabel2).CornerRadius = UDim.new(1, 0)
local uIStroke12 = Instance.new("UIStroke", imageLabel2)
uIStroke12.Color = func()
uIStroke12.Thickness = 2.5

pcall(function()
	imageLabel2.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
end)

local textLabel17 = Instance.new("TextLabel", frame21)
textLabel17.Size = UDim2.new(1, 0, 0, 20)
textLabel17.Position = UDim2.new(0, 0, 0.29, 0)
textLabel17.Text = "ARCHITECT & LEAD CREATOR: ASUKA 👑"
textLabel17.TextColor3 = func()
textLabel17.Font = Enum.Font.Code
textLabel17.TextSize = 12
textLabel17.BackgroundTransparency = 1
textLabel17.ZIndex = 4
local textLabel18 = Instance.new("TextLabel", frame21)
textLabel18.Size = UDim2.new(1, 0, 0, 16)
textLabel18.Position = UDim2.new(0, 0, 0.37, 0)
textLabel18.Text = "⚡ [ FOUNDER & CHIEF SYSTEM ENGINE: ASUKA / TMX ] ⚡"
textLabel18.TextColor3 = func()
textLabel18.Font = Enum.Font.Code
textLabel18.TextSize = 9.5
textLabel18.BackgroundTransparency = 1
textLabel18.ZIndex = 4
local frame23 = Instance.new("Frame", frame21)
frame23.Size = UDim2.new(0.9, 0, 0, 75)
frame23.Position = UDim2.new(0.05, 0, 0.46, 0)
frame23.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
frame23.ZIndex = 4
Instance.new("UICorner", frame23).CornerRadius = UDim.new(0, 8)
local textLabel19 = Instance.new("TextLabel", frame23)
textLabel19.Size = UDim2.new(1, -16, 1, -10)
textLabel19.Position = UDim2.new(0, 8, 0, 5)
textLabel19.Text = "🎭 ASUKA CORE ENGINE V3 - ULTIMATE LANDSCAPE SPAMMER\n⚡ CYBER DUAL-THEME ARCHITECTURE & TARGET MATRIX\n👑 MUCH LOVE & SUPREMACY FROM ASUKA // TMX ON TOP"
textLabel19.TextColor3 = Color3.fromRGB(200, 200, 220)
textLabel19.Font = Enum.Font.Code
textLabel19.TextSize = 8.5
textLabel19.TextWrapped = true
textLabel19.BackgroundTransparency = 1
textLabel19.ZIndex = 5
local textButton6 = Instance.new("TextButton", frame21)
textButton6.Size = UDim2.new(0.9, 0, 0, 32)
textButton6.Position = UDim2.new(0.05, 0, 0.82, 0)
textButton6.Text = "👤 COPY DEVELOPER PROFILE LINK ⚡"
textButton6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textButton6.TextColor3 = Color3.fromRGB(14, 14, 20)
textButton6.Font = Enum.Font.Code
textButton6.TextSize = 9.5
textButton6.ZIndex = 4
Instance.new("UICorner", textButton6).CornerRadius = UDim.new(0, 6)
func8(textButton6, Color3.fromRGB(220, 220, 255), Color3.fromRGB(255, 255, 255))

textButton6.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("Yadsan_GodVerse")
		textButton6.Text = "✨ COPIED TO CLIPBOARD!"
		task.wait(2)
		textButton6.Text = "👤 COPY DEVELOPER PROFILE LINK ⚡"
	end
end)

RunService.RenderStepped:Connect(function()
	local v1 = func()
	uIStroke5.Color = v1
	textLabel10.TextColor3 = v1
	uIStroke7.Color = v1
	uIStroke10.Color = v1
	uIStroke6.Color = v1
	textButton3.TextColor3 = v1
	textLabel6.TextColor3 = v1
	uIStroke8.Color = v1
	uIStroke9.Color = v1
	local v2 = math.sin(tick() * 4) * 35
	textLabel7.Rotation = v2
	textLabel9.Rotation = v2
	textLabel14.Rotation = v2

	if frame.Visible then
		uIStroke.Color = v1
		textLabel.TextColor3 = v1
		uIStroke1.Color = v1
	end

	if frame4.Visible then
		uIStroke3.Color = v1
		uIStroke4.Color = v1
	end

	if frame21.Visible then
		uIStroke11.Color = v1
		uIStroke12.Color = v1
		textLabel17.TextColor3 = v1
		textLabel18.TextColor3 = v1
	end

	for _, v3 in ipairs(tbl5) do
		v3.TextColor3 = v1
	end
end)

textButton1.MouseButton1Click:Connect(function()
	frame4.Visible = false
	frame6.Visible = true
end)

func1()

task.spawn(function()
	task.wait(1)
	local v1 = func4("♤Asuka Spammer V2 on Top h8 🗼 pe 😍")
	local v2 = math.clamp(180 - v1 - 1, 5, 140)
	local v3 = func5(textBox1.Text, 1, v2)
	func6((v3 ~= "" and v3 .. " " or "") .. "♤Asuka Spammer V2 on Top h8 🗼 pe 😍")
end)
