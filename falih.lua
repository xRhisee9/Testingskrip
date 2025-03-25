local scriptString = [[
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Atur kecepatan berlari sesuai keinginan Anda
local runSpeed = 100 -- Ubah ke kecepatan yang diinginkan
local normalSpeed = 16 -- Kecepatan normal
local flying = false -- Status terbang

-- Fungsi untuk berlari kencang
local function runFast()
    humanoid.WalkSpeed = runSpeed
end

-- Fungsi untuk terbang
local function fly()
    if not flying then
        flying = true
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Kecepatan terbang
        bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0) -- Mengizinkan gerakan vertikal
        bodyVelocity.Parent = character.HumanoidRootPart

        -- Menghapus BodyVelocity setelah 5 detik
        wait(5)
        bodyVelocity:Destroy()
    else
        flying = false
        humanoid.PlatformStand = false -- Kembali ke keadaan normal
    end
end

-- Mengatur kontrol untuk tombol
local runButton = script.Parent:WaitForChild("RunButton")
local flyButton = script.Parent:WaitForChild("FlyButton")

runButton.MouseButton1Click:Connect(function()
    if humanoid.WalkSpeed == normalSpeed then
        runFast()
    else
        humanoid.WalkSpeed = normalSpeed -- Kembalikan ke kecepatan normal
    end
end)

flyButton.MouseButton1Click:Connect(function()
    if not flying then
        fly() -- Menghidupkan terbang
        humanoid.PlatformStand = true -- Mencegah karakter jatuh saat terbang
    else
        flying = false
        humanoid.PlatformStand = false -- Kembali ke keadaan normal
        humanoid.WalkSpeed = normalSpeed -- Kembalikan ke kecepatan normal
    end
end)
]]

-- Menjalankan skrip menggunakan loadstring
loadstring(scriptString)()
