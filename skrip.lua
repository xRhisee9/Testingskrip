local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "SpeedGUI"
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 10, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 180, 0, 30)
textBox.Position = UDim2.new(0.1, 0, 0.1, 0)
textBox.PlaceholderText = "Enter speed (16-100)"
textBox.Text = "16"
textBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.ClearTextOnFocus = false

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 180, 0, 20)
label.Position = UDim2.new(0.1, 0, 0.45, 0)
label.Text = "Current speed: 16"
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(200, 200, 200)
label.Font = Enum.Font.Gotham

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 180, 0, 30)
button.Position = UDim2.new(0.1, 0, 0.7, 0)
button.Text = "Apply Speed"
button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
button.TextColor3 = Color3.fromRGB(255, 255, 255)

textBox.Parent = frame
label.Parent = frame
button.Parent = frame
frame.Parent = gui

local function updateWalkSpeed()
    local speedValue = tonumber(textBox.Text)
    
    if speedValue and speedValue >= 16 and speedValue <= 100 then
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        
        if humanoid then
            humanoid.WalkSpeed = speedValue
            label.Text = "Current speed: "..speedValue
            textBox.Text = tostring(speedValue)
        else
            label.Text = "Character not found!"
            wait(2)
            label.Text = "Current speed: "..(humanoid and humanoid.WalkSpeed or "?")
        end
    else
        label.Text = "Invalid speed (16-100)"
        textBox.Text = "16"
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end

button.MouseButton1Click:Connect(updateWalkSpeed)

textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        updateWalkSpeed()
    end
end)
