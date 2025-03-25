-- Pastikan ini adalah LocalScript dan ditempatkan di StarterPlayerScripts

-- Tunggu hingga game sepenuhnya dimuat
repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Load RayField UI Library
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end)

if not success then
    warn("Gagal memuat RayField UI Library")
    return
end

-- Buat antarmuka UI
local Window = Rayfield:CreateWindow({
    Name = "Pengatur Kecepatan Karakter",
    LoadingTitle = "Memuat Pengatur Kecepatan...",
    LoadingSubtitle = "Silakan tunggu",
    ConfigurationSaving = {
        Enabled = false,
    },
    KeySystem = false,
})

-- Buat tab utama
local MainTab = Window:CreateTab("Pengaturan Utama")

-- Tunggu hingga karakter muncul
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Buat slider kecepatan
local speedSlider = MainTab:CreateSlider({
    Name = "Kecepatan Berjalan",
    Range = {16, 100},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = humanoid.WalkSpeed,
    Callback = function(value)
        if humanoid then
            humanoid.WalkSpeed = value
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Humanoid tidak ditemukan!",
                Duration = 3,
            })
        end
    end,
})

-- Tombol reset
MainTab:CreateButton({
    Name = "Reset Ke Default",
    Callback = function()
        if humanoid then
            humanoid.WalkSpeed = 16
            speedSlider:Set(16)
            Rayfield:Notify({
                Title = "Berhasil",
                Content = "Kecepatan direset ke 16 studs",
                Duration = 3,
            })
        end
    end,
})

-- Handle respawn karakter
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = newCharacter:WaitForChild("Humanoid")
    
    -- Update slider saat karakter respawn
    speedSlider:Set(humanoid.WalkSpeed)
end)

-- Keybind untuk toggle UI
local Input = game:GetService("UserInputService")
local uiHidden = false

MainTab:CreateKeybind({
    Name = "Toggle UI",
    CurrentKeybind = "U",
    HoldToInteract = false,
    Callback = function()
        uiHidden = not uiHidden
        Window:Toggle(uiHidden)
    end,
})

-- Notifikasi saat pertama kali load
Rayfield:Notify({
    Title = "Pengatur Kecepatan Aktif",
    Content = "Tekan U untuk menampilkan/menyembunyikan UI",
    Duration = 5,
})

print("Pengatur kecepatan berhasil dimuat!")
