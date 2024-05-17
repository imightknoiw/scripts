local ChatService = game:GetService("Chat")

local function onPlayerChatted(player, message)
    -- Format the message
    local formattedMessage = player.Name .. " said: " .. message
    
    -- Send the message back to the chat
    ChatService:Chat(player.Character.Head, formattedMessage, Enum.ChatColor.Blue)
end

-- Connect the 'onPlayerChatted' function to the player's Chatted event
game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end)
