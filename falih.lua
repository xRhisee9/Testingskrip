local Players = game:GetService("Players")

local function highlightPlayer(player)
    -- Pastikan karakter pemain sudah ada
    if player.Character then
        local highlight = Instance.new("Highlight")
        highlight.Parent = player.Character
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(0, 0, 255)
    end
end

-- Menggunakan event CharacterAdded untuk menambahkan highlight saat karakter muncul
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        highlightPlayer(player)
    end)
end)

-- Highlight pemain yang sudah ada saat skrip dijalankan
for _, player in ipairs(Players:GetPlayers()) do
    highlightPlayer(player)
end
