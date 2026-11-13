--// ZERO MERCY SPAMMER V1  
--// LocalScript -> StarterPlayerScripts  
  
local Players = game:GetService("Players")  
local TweenService = game:GetService("TweenService")  
local TextChatService = game:GetService("TextChatService")  
local UserInputService = game:GetService("UserInputService")  
local Lighting = game:GetService("Lighting")  
  
local player = Players.LocalPlayer  
local playerGui = player:WaitForChild("PlayerGui")  
  
local WIDTH = 600  
local HEIGHT = 300  
  
--==================================================  
-- GUI  
--==================================================  
  
local gui = Instance.new("ScreenGui")  
gui.Name = "ZERO_MERCY_SPAMMER_V1"  
gui.ResetOnSpawn = false  
gui.IgnoreGuiInset = true  
gui.Parent = playerGui  
  
--==================================================  
-- BLUR LOADING  
--==================================================  
  
local blur = Instance.new("BlurEffect")  
blur.Name = "ZERO_MERCY_LOADING_BLUR"  
blur.Size = 26  
blur.Parent = Lighting  
  
local overlay = Instance.new("Frame")  
overlay.Size = UDim2.fromScale(1,1)  
overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)  
overlay.BackgroundTransparency = 0.55  
overlay.BorderSizePixel = 0  
overlay.Parent = gui  
  
local loading = Instance.new("Frame")  
loading.AnchorPoint = Vector2.new(.5,.5)  
loading.Position = UDim2.fromScale(.5,.5)  
loading.Size = UDim2.fromOffset(330,135)  
loading.BackgroundColor3 = Color3.fromRGB(15,18,28)  
loading.BackgroundTransparency = .05  
loading.Parent = overlay  
  
Instance.new("UICorner",loading).CornerRadius = UDim.new(0,18)  
  
local loadTitle = Instance.new("TextLabel")  
loadTitle.Size = UDim2.new(1,-30,0,35)  
loadTitle.Position = UDim2.fromOffset(15,12)  
loadTitle.BackgroundTransparency = 1  
loadTitle.Text = "⚔ ZERO MERCY SPAMMER V1"  
loadTitle.TextColor3 = Color3.new(1,1,1)  
loadTitle.Font = Enum.Font.GothamBold  
loadTitle.TextSize = 20  
loadTitle.Parent = loading  
  
local loadPercent = Instance.new("TextLabel")  
loadPercent.Size = UDim2.new(1,-30,0,25)  
loadPercent.Position = UDim2.fromOffset(15,50)  
loadPercent.BackgroundTransparency = 1  
loadPercent.TextColor3 = Color3.fromRGB(210,210,220)  
loadPercent.Font = Enum.Font.Gotham  
loadPercent.TextSize = 14  
loadPercent.Text = "Loading... 0%"  
loadPercent.Parent = loading  
  
local barBack = Instance.new("Frame")  
barBack.Size = UDim2.new(1,-40,0,9)  
barBack.Position = UDim2.fromOffset(20,95)  
barBack.BackgroundColor3 = Color3.fromRGB(48,52,62)  
barBack.Parent = loading  
  
Instance.new("UICorner",barBack).CornerRadius = UDim.new(1,0)  
  
local bar = Instance.new("Frame")  
bar.Size = UDim2.new(0,0,1,0)  
bar.BackgroundColor3 = Color3.fromRGB(180,185,195)  
bar.Parent = barBack  
  
Instance.new("UICorner",bar).CornerRadius = UDim.new(1,0)  
  
for i = 1,100 do  
	loadPercent.Text = "Loading... "..i.."%"  
  
	TweenService:Create(  
		bar,  
		TweenInfo.new(.06,Enum.EasingStyle.Linear),  
		{Size = UDim2.new(i/100,0,1,0)}  
	):Play()  
  
	task.wait(.06)  
end  
  
task.wait(.25)  
  
overlay:Destroy()  
blur:Destroy()  
  
--==================================================  
-- EXECUTED MESSAGE  
--==================================================  
  
task.defer(function()  
  
	local channels = TextChatService:WaitForChild("TextChannels",10)  
  
	if not channels then  
		return  
	end  
  
	local general = channels:WaitForChild("RBXGeneral",10)  
  
	if not general then  
		return  
	end  
  
	pcall(function()  
		general:SendAsync(  
			"_____///@@@@/😍ZERO MERCY ON TOP SPAMMER V1 EXECUTED:D///@///😝..!"  
		)  
	end)  
  
end)  
  
--==================================================  
-- MAIN GUI  
--==================================================  
  
local main = Instance.new("Frame")  
main.Name = "Main"  
main.Size = UDim2.fromOffset(WIDTH,HEIGHT)  
main.Position = UDim2.new(.5,-WIDTH/2,.5,-HEIGHT/2)  
main.BackgroundColor3 = Color3.fromRGB(14,17,27)  
main.BorderSizePixel = 0  
main.Parent = gui  
  
Instance.new("UICorner",main).CornerRadius = UDim.new(0,18)  
  
local stroke = Instance.new("UIStroke")  
stroke.Color = Color3.fromRGB(80,85,105)  
stroke.Thickness = 1.5  
stroke.Transparency = .25  
stroke.Parent = main  
  
--==================================================  
-- TOP BAR  
--==================================================  
  
local top = Instance.new("Frame")  
top.Size = UDim2.new(1,0,0,48)  
top.BackgroundColor3 = Color3.fromRGB(22,25,35)  
top.BorderSizePixel = 0  
top.Parent = main  
  
local title = Instance.new("TextLabel")  
title.Size = UDim2.new(1,-65,1,0)  
title.Position = UDim2.fromOffset(16,0)  
title.BackgroundTransparency = 1  
title.Text = "⚔ ZERO MERCY SPAMMER V1"  
title.TextXAlignment = Enum.TextXAlignment.Left  
title.TextColor3 = Color3.new(1,1,1)  
title.Font = Enum.Font.GothamBold  
title.TextSize = 17  
title.Parent = top  
  
local close = Instance.new("TextButton")  
close.Size = UDim2.fromOffset(36,32)  
close.Position = UDim2.new(1,-45,0,8)  
close.BackgroundColor3 = Color3.fromRGB(105,35,48)  
close.Text = "⚔"  
close.TextColor3 = Color3.new(1,1,1)  
close.Font = Enum.Font.GothamBold  
close.TextSize = 18  
close.Parent = top  
  
Instance.new("UICorner",close).CornerRadius = UDim.new(0,9)  
  
--==================================================  
-- DRAG  
--==================================================  
  
local function draggable(frame,handle)  
  
	local dragging = false  
	local dragStart  
	local startPos  
  
	handle.InputBegan:Connect(function(input)  
  
		if input.UserInputType == Enum.UserInputType.MouseButton1  
			or input.UserInputType == Enum.UserInputType.Touch then  
  
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
  
	UserInputService.InputChanged:Connect(function(input)  
  
		if dragging and (  
			input.UserInputType == Enum.UserInputType.MouseMovement  
			or input.UserInputType == Enum.UserInputType.Touch  
		) then  
  
			local delta = input.Position - dragStart  
  
			frame.Position = UDim2.new(  
				startPos.X.Scale,  
				startPos.X.Offset + delta.X,  
				startPos.Y.Scale,  
				startPos.Y.Offset + delta.Y  
			)  
		end  
	end)  
end  
  
draggable(main,top)  
  
--==================================================  
-- INPUTS  
--==================================================  
  
local function makeLabel(txt,x,y)  
  
	local l = Instance.new("TextLabel")  
	l.Size = UDim2.fromOffset(82,28)  
	l.Position = UDim2.fromOffset(x,y)  
	l.BackgroundTransparency = 1  
	l.Text = txt  
	l.TextXAlignment = Enum.TextXAlignment.Left  
	l.TextColor3 = Color3.fromRGB(195,198,208)  
	l.Font = Enum.Font.GothamMedium  
	l.TextSize = 13  
	l.Parent = main  
  
	return l  
end  
  
local function makeBox(x,y,w,placeholder)  
  
	local b = Instance.new("TextBox")  
	b.Size = UDim2.fromOffset(w,30)  
	b.Position = UDim2.fromOffset(x,y)  
	b.BackgroundColor3 = Color3.fromRGB(28,31,42)  
	b.BorderSizePixel = 0  
	b.PlaceholderText = placeholder  
	b.PlaceholderColor3 = Color3.fromRGB(115,118,128)  
	b.TextColor3 = Color3.new(1,1,1)  
	b.Font = Enum.Font.Gotham  
	b.TextSize = 13  
	b.ClearTextOnFocus = false  
	b.Parent = main  
  
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)  
  
	return b  
end  
  
makeLabel("Target",18,62)  
local targetBox = makeBox(100,61,180,"Target name")  
  
makeLabel("Symbol",18,99)  
local symbolBox = makeBox(100,98,180,"★")  
  
makeLabel("Count",18,136)  
local countBox = makeBox(100,135,180,"1 - 100")  
  
makeLabel("Emoji",305,62)  
local emojiBox = makeBox(390,61,180,"😂")  
  
makeLabel("Delay",305,99)  
local delayBox = makeBox(390,98,180,"Seconds")  
  
makeLabel("Status",305,136)  
  
local status = Instance.new("TextLabel")  
status.Size = UDim2.fromOffset(180,30)  
status.Position = UDim2.fromOffset(390,135)  
status.BackgroundColor3 = Color3.fromRGB(28,31,42)  
status.Text = "● STOPPED"  
status.TextColor3 = Color3.fromRGB(255,130,130)  
status.Font = Enum.Font.GothamBold  
status.TextSize = 12  
status.Parent = main  
  
Instance.new("UICorner",status).CornerRadius = UDim.new(0,8)  
  
--==================================================  
-- SYMBOLS  
--==================================================  
  
local symbols = {  
	"🔥","💀","👑","😈","🤡",  
	"😂","😭","🥀","⚡","🗡",  
	"×","∆","Ω","λ","♨",  
	"♻","☮","☸","✝","⚜",  
	"⚙","❗","❓","‼","🛡",  
	"⭕","🔱","💫","✨","💥"  
}  
  
local picker = Instance.new("Frame")  
picker.Size = UDim2.fromOffset(360,76)  
picker.Position = UDim2.fromOffset(18,174)  
picker.BackgroundColor3 = Color3.fromRGB(20,23,33)  
picker.BorderSizePixel = 0  
picker.Parent = main  
  
Instance.new("UICorner",picker).CornerRadius = UDim.new(0,10)  
  
local scroll = Instance.new("ScrollingFrame")  
scroll.Size = UDim2.new(1,-8,1,-8)  
scroll.Position = UDim2.fromOffset(4,4)  
scroll.BackgroundTransparency = 1  
scroll.BorderSizePixel = 0  
scroll.ScrollBarThickness = 3  
scroll.Parent = picker  
  
local grid = Instance.new("UIGridLayout")  
grid.CellSize = UDim2.fromOffset(62,28)  
grid.CellPadding = UDim2.fromOffset(5,4)  
grid.FillDirection = Enum.FillDirection.Horizontal  
grid.FillDirectionMaxCells = 5  
grid.SortOrder = Enum.SortOrder.LayoutOrder  
grid.Parent = scroll  
  
for i,symbol in ipairs(symbols) do  
  
	local button = Instance.new("TextButton")  
	button.LayoutOrder = i  
	button.BackgroundColor3 = Color3.fromRGB(31,34,45)  
	button.Text = symbol  
	button.TextColor3 = Color3.new(1,1,1)  
	button.Font = Enum.Font.Gotham  
	button.TextSize = 17  
	button.Parent = scroll  
  
	Instance.new("UICorner",button).CornerRadius = UDim.new(0,6)  
  
	button.MouseButton1Click:Connect(function()  
		symbolBox.Text = symbol  
	end)  
end  
  
grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()  
	scroll.CanvasSize = UDim2.fromOffset(  
		0,  
		grid.AbsoluteContentSize.Y + 5  
	)  
end)  
  
--==================================================  
-- ROAST LINES  
--==================================================  
  
local roasts = {  
  
	"GAMEPLAY DEKH KE ENEMY KO BHI CONFIDENCE AA GAYA",  
  
	"BHAI TU KHEL RAHA HAI YA OPPONENT KO PRACTICE KARWA RAHA HAI?",  
  
	"TERI STRATEGY ITNI SECRET HAI KI TUJHE KHUD NAHI PATA",  
  
	"SCOREBOARD PE NAAM HAI, PAR IMPACT KAHAN HAI?",  
  
	"TUJHE HARAANE KI ZAROORAT NAHI, TU KHUD HI ROUND GIFT KAR RAHA HAI",  
  
	"TERA AIM IDHAR, TARGET UDHAR — PERFECT CONFUSION",  
  
	"NEXT MOVE DEKHNE KE LIYE GAME NAHI, COMEDY SHOW CHAHIYE",  
  
	"OPPONENT KO CHALLENGE KIYA THA, PAR TU TOH FREE POINTS DE RAHA HAI",  
  
	"ITNA MISS KIYA KI TARGET NE BHI TERA WAIT KARNA CHHOD DIYA",  
  
	"SCOREBOARD KO THODA PERSONAL SPACE DE — WO ALREADY SAB BATA RAHA HAI",  
  
	"TERI ENTRY HERO WALI THI, PAR RESULT PLOT TWIST NIKLA",  
  
	"GAMEPLAY DEKH KE LAGA UPDATE ABHI BAAKI HAI",  
  
	"AURA DIKHANE AAYA THA, PAR GAMEPLAY NE VERIFY NAHI KIYA",  
  
	"TERA AIM TARGET SE ZYADA MAP EXPLORE KAR RAHA HAI",  
  
	"ROUND JEETNE AAYA THA, PAR OPPONENT KO PRACTICE MIL GAYI",  
  
	"PLAN ITNA ADVANCED THA KI GAME BHI SAMJH NAHI PAYA",  
  
	"TERA GAMEPLAY BUFFERING MEIN HAI, PAR ROUND LIVE CHAL RAHA HAI",  
  
	"SKILL CHECK START HUA AUR SCOREBOARD NE ANSWER DE DIYA",  
  
	"BHAI TERA CONFIDENCE HIGH HAI, RESULT LOW BATTERY PE HAI",  
  
	"TERA BEST MOVE ABHI TAK LOADING MEIN HAI",  
  
	"OPPONENT NE ATTACK NAHI KIYA, TU KHUD HI OPPORTUNITY DE GAYA",  
  
	"GAMEPLAY AISA KI SPECTATOR MODE BHI ENTERTAINING HO GAYA",  
  
	"TERI STRATEGY KO DEKH KE MAP BHI CONFUSED HAI",  
  
	"AIM SEARCH KARTE KARTE ROUND KHATAM HO GAYA",  
  
	"ENTRY STRONG, EXIT SCOREBOARD KE HAWALE",  
  
	"TERA GAMEPLAY DEKH KE LAGTA HAI TUTORIAL SKIP KARNA MAHENGA PAD GAYA",  
  
	"OPPONENT KO HARANA THA, PAR FREE POINTS DISTRIBUTE HO RAHE HAIN",  
  
	"TERI MOVEMENT KA LOGIC ABHI TAK DISCOVER NAHI HUA",  
  
	"SCOREBOARD NE AISA SPOILER DIYA KI ROAST KI ZAROORAT HI NAHI",  
  
	"GAMEPLAY KA PLOT TWIST HAR ROUND MEIN NAYA HAI"  
}  
  
--==================================================  
-- COUNT / SYMBOL  
--==================================================  
  
local function getCount()  
  
	local n = tonumber(countBox.Text) or 1  
  
	return math.clamp(math.floor(n),1,100)  
  
end  
  
local function getSymbols()  
  
	local s = symbolBox.Text  
  
	if s == "" then  
		s = "★"  
	end  
  
	local count = math.min(getCount(),20)  
  
	return string.rep(s,count)  
  
end  
  
--==================================================  
-- TARGET NAME  
--==================================================  
  
local function getTargetName()  
  
	local name = targetBox.Text:gsub("^%s*(.-)%s*$","%1")  
  
	if name == "" then  
		name = "Target"  
	end  
  
	return name  
  
end  
  
--==================================================  
-- PREVIEW  
--==================================================  
  
local preview = Instance.new("TextLabel")  
preview.Size = UDim2.fromOffset(552,35)  
preview.Position = UDim2.fromOffset(30,256)  
preview.BackgroundColor3 = Color3.fromRGB(24,27,38)  
preview.TextColor3 = Color3.fromRGB(80,255,100)  
preview.TextWrapped = true  
preview.Font = Enum.Font.GothamBold  
preview.TextSize = 10  
preview.Text = "Preview..."  
preview.Parent = main  
  
Instance.new("UICorner",preview).CornerRadius = UDim.new(0,8)  
  
local function updatePreview()  
  
	local symbolsText = getSymbols()  
	local targetName = getTargetName()  
  
	preview.Text =  
		"@" .. targetName  
		.." "  
		..symbolsText  
		.." | "  
		..roasts[1]  
		.." | "  
		..(emojiBox.Text ~= "" and emojiBox.Text or "😂")  
		.." | "  
		..symbolsText  
  
end  
  
targetBox:GetPropertyChangedSignal("Text"):Connect(updatePreview)  
symbolBox:GetPropertyChangedSignal("Text"):Connect(updatePreview)  
countBox:GetPropertyChangedSignal("Text"):Connect(updatePreview)  
emojiBox:GetPropertyChangedSignal("Text"):Connect(updatePreview)  
  
updatePreview()  
  
--==================================================  
-- START / STOP  
--==================================================  
  
local start = Instance.new("TextButton")  
start.Size = UDim2.fromOffset(100,30)  
start.Position = UDim2.fromOffset(400,174)  
start.BackgroundColor3 = Color3.fromRGB(35,105,70)  
start.Text = "▶ START"  
start.TextColor3 = Color3.new(1,1,1)  
start.Font = Enum.Font.GothamBold  
start.TextSize = 12  
start.Parent = main  
  
Instance.new("UICorner",start).CornerRadius = UDim.new(0,8)  
  
local stop = Instance.new("TextButton")  
stop.Size = UDim2.fromOffset(100,30)  
stop.Position = UDim2.fromOffset(485,208)  
stop.BackgroundColor3 = Color3.fromRGB(110,38,50)  
stop.Text = "■ STOP"  
stop.TextColor3 = Color3.new(1,1,1)  
stop.Font = Enum.Font.GothamBold  
stop.TextSize = 12  
stop.Parent = main  
  
Instance.new("UICorner",stop).CornerRadius = UDim.new(0,8)  
  
--==================================================  
-- MESSAGE LOOP  
--==================================================  
  
local running = false  
local roastIndex = 1  
  
local function sendTestMessage()  
  
	local symbolsText = getSymbols()  
	local targetName = getTargetName()  
  
	local message =  
		"@" .. targetName  
		.." "  
		..symbolsText  
		.." | "  
		..roasts[roastIndex]  
		.." | "  
		..(emojiBox.Text ~= "" and emojiBox.Text or "😂")  
		.." | "  
		..symbolsText  
  
	roastIndex += 1  
  
	if roastIndex > #roasts then  
		roastIndex = 1  
	end  
  
	pcall(function()  
  
		local channels = TextChatService:FindFirstChild("TextChannels")  
  
		if channels then  
  
			local general = channels:FindFirstChild("RBXGeneral")  
  
			if general then  
				general:SendAsync(message)  
			end  
  
		end  
  
	end)  
  
end  
  
--==================================================  
-- START  
--==================================================  
  
start.MouseButton1Click:Connect(function()  
  
	if running then  
		return  
	end  
  
	running = true  
  
	start.Text = "● RUNNING"  
	status.Text = "● RUNNING"  
	status.TextColor3 = Color3.fromRGB(100,240,145)  
  
	task.spawn(function()  
  
		while running do  
  
			sendTestMessage()  
  
			local delayValue = tonumber(delayBox.Text) or 10  
			delayValue = math.max(1,delayValue)  
  
			task.wait(delayValue)  
  
		end  
  
	end)  
  
end)  
  
--==================================================  
-- STOP  
--==================================================  
  
stop.MouseButton1Click:Connect(function()  
  
	running = false  
  
	start.Text = "▶ START"  
	status.Text = "● STOPPED"  
	status.TextColor3 = Color3.fromRGB(255,130,130)  
  
end)  
  
--==================================================  
-- SS1 REOPEN BUTTON  
--==================================================  
  
local ss1 = Instance.new("TextButton")  
ss1.Size = UDim2.fromOffset(58,58)  
ss1.Position = UDim2.new(1,-75,1,-80)  
ss1.BackgroundColor3 = Color3.fromRGB(25,28,40)  
ss1.Text = "SS1"  
ss1.TextColor3 = Color3.new(1,1,1)  
ss1.Font = Enum.Font.GothamBold  
ss1.TextSize = 16  
ss1.Visible = false  
ss1.Parent = gui  
  
Instance.new("UICorner",ss1).CornerRadius = UDim.new(1,0)  
  
local ssStroke = Instance.new("UIStroke")  
ssStroke.Color = Color3.fromRGB(100,105,125)  
ssStroke.Thickness = 2  
ssStroke.Parent = ss1  
  
draggable(ss1,ss1)  
  
--==================================================  
-- CLOSE — DOES NOT STOP MESSAGE LOOP  
--==================================================  
  
close.MouseButton1Click:Connect(function()  
  
	local tween = TweenService:Create(  
		main,  
		TweenInfo.new(.35,Enum.EasingStyle.Back,Enum.EasingDirection.In),  
		{  
			Size = UDim2.fromOffset(0,0),  
			Rotation = 12  
		}  
	)  
  
	tween:Play()  
	tween.Completed:Wait()  
  
	main.Visible = false  
	main.Rotation = 0  
	main.Size = UDim2.fromOffset(WIDTH,HEIGHT)  
  
	ss1.Visible = true  
  
end)  
  
--==================================================  
-- REOPEN  
--==================================================  
  
ss1.MouseButton1Click:Connect(function()  
  
	ss1.Visible = false  
  
	main.Visible = true  
	main.Size = UDim2.fromOffset(0,0)  
  
	TweenService:Create(  
		main,  
		TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),  
		{  
			Size = UDim2.fromOffset(WIDTH,HEIGHT)  
		}  
	):Play()  
  
end)
