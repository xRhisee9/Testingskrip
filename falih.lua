-- Skrip ini ditempatkan di ServerScriptService atau tempat yang sesuai
local Players = game:GetService("Players")

-- Fungsi untuk membuat highlight dan nama tag
local function setupPlayerCharacter(player)
    local character = player.Character or player.CharacterAdded:Wait()
    
    -- Buat Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "PlayerHighlight"
    highlight.Adornee = character
    highlight.Parent = character
    
    -- Atur warna highlight (opsional, bisa disesuaikan)
    highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Hijau
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Putih
    
    -- Buat BillboardGui untuk nama pemain
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerNameTag"
    billboard.Adornee = character:WaitForChild("Head")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0) -- Posisi di atas kepala
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.MaxDistance = 100 -- Hanya terlihat dalam jarak 100 studs
    
    -- Tambahkan TextLabel untuk nama
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Parent = billboard
    
    billboard.Parent = character:WaitForChild("Head")
    
    -- Jika karakter mati dan respawn, setup ulang
    player.CharacterAdded:Connect(function(newCharacter)
        -- Hapus yang lama jika ada
        if character:FindFirstChild("PlayerHighlight") then
            character.PlayerHighlight:Destroy()
        end
        if character:FindFirstChild("Head") and character.Head:FindFirstChild("PlayerNameTag") then
            character.Head.PlayerNameTag:Destroy()
        end
        
        -- Setup yang baru
        setupPlayerCharacter(player)
    end)
end

-- Setup untuk pemain yang sudah ada di game
for _, player in ipairs(Players:GetPlayers()) do
    setupPlayerCharacter(player)
end

-- Setup untuk pemain yang baru bergabung
Players.PlayerAdded:Connect(function(player)
    setupPlayerCharacter(player)
end)
