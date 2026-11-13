-- Configuration
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local chatDelay = 1.25
local messages = {
    "『💀』 Hello Bhai 😈 " .. player.Name .. ", Humari Gang Mein Jeet Aayega? AG Ka Baap🔥 『🩸』",
    "『😡』//OWNER//:LEADER:// 『😏』",
    "『⚠️』CELESTIAL X ASUKA X ZM ON TOP『💀』",
    "CELESTIAL GODVERSE HUB UV1 BEST SCRIPTS XD 🗿", -- Added right below -pd
    "SCriPt By Yadsan_Godverse WorkiNg!"
}

-- Function to safely send chat messages across different Roblox chat systems
local function sendChat(message)
    -- Modern TextChatService (2023+)
    local textChatService = game:GetService("TextChatService")
    if textChatService and textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local textChannel = textChatService.TextChannels:FindFirstChild("RBXGeneral")
        if textChannel then
            textChannel:SendAsync(message)
            return
        end
    end
    
    -- Legacy ChatService fallback
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local defaultChatSystemChatEvents = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if defaultChatSystemChatEvents then
        local sayMessageRequest = defaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
        if sayMessageRequest and sayMessageRequest:IsA("RemoteEvent") then
            sayMessageRequest:FireServer(message, "All")
        end
    end
end

-- Main Execution Sequence
task.spawn(function()
    -- Loop through and send the configured messages with the specified delay
    for _, msg in ipairs(messages) do
        sendChat(msg)
        task.wait(chatDelay)
    end
    
    -- Execute the external Patchma Hub script after the final delay
    local success, err = pcall(function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/yadsanpapa/Yadsan-/refs/heads/main/Celestial_GodverseHubUV1.lua"))()
    end)
    
    if not success then
        warn("Failed to execute external script: " .. tostring(err))
    end
end)
