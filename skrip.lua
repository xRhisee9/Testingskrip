-- Pastikan ini adalah LocalScript di StarterPlayerScripts
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hapus GUI lama jika ada
if playerGui:FindFirstChild("SpeedGUI") then
    playerGui.SpeedGUI:Destroy()
end

-- Create main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedGUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Main container frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, 180)
mainFrame.Position = UDim2.new(0, 10, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0

-- Add rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Add drop shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.ZIndex = -1
shadow.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
titleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0, 140, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "SPEED CONTROL"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -30, 0, 0)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18

-- Content frame (will be hidden when minimized)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundTransparency = 1

-- Speed input
local textBox = Instance.new("TextBox")
textBox.Name = "SpeedInput"
textBox.Size = UDim2.new(0.8, 0, 0, 30)
textBox.Position = UDim2.new(0.1, 0, 0.1, 0)
textBox.PlaceholderText = "16-100"
textBox.Text = "16"
textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.ClearTextOnFocus = false
textBox.Font = Enum.Font.Gotham

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 4)
textBoxCorner.Parent = textBox

-- Speed display
local speedDisplay = Instance.new("TextLabel")
speedDisplay.Name = "SpeedDisplay"
speedDisplay.Size = UDim2.new(0.8, 0, 0, 20)
speedDisplay.Position = UDim2.new(0.1, 0, 0.4, 0)
speedDisplay.BackgroundTransparency = 1
speedDisplay.Text = "Current: 16 studs"
speedDisplay.TextColor3 = Color3.fromRGB(200, 200, 200)
speedDisplay.Font = Enum.Font.Gotham
speedDisplay.TextSize = 14

-- Apply button
local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(0.8, 0, 0, 30)
applyButton.Position = UDim2.new(0.1, 0, 0.7, 0)
applyButton.Text = "APPLY"
applyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.Font = Enum.Font.GothamBold

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 4)
buttonCorner.Parent = applyButton

-- Parent all elements
titleText.Parent = titleBar
minimizeButton.Parent = titleBar
titleBar.Parent = mainFrame

textBox.Parent = contentFrame
speedDisplay.Parent = contentFrame
applyButton.Parent = contentFrame
contentFrame.Parent = mainFrame

mainFrame.Parent = gui

-- Minimize functionality
local isMinimized = false
local originalSize = mainFrame.Size

minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        minimizeButton.Text = "+"
        contentFrame.Visible = false
        mainFrame.Size = UDim2.new(0, 220, 0, 30)
    else
        minimizeButton.Text = "-"
        contentFrame.Visible = true
        mainFrame.Size = originalSize
    end
end)

-- Drag functionality
local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Speed control functionality
local function updateWalkSpeed()
    local speedValue = tonumber(textBox.Text)
    
    if speedValue and speedValue >= 16 and speedValue <= 100 then
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        
        if humanoid then
            humanoid.WalkSpeed = speedValue
            speedDisplay.Text = "Current: "..speedValue.." studs"
            textBox.Text = tostring(speedValue)
        else
            speedDisplay.Text = "No character found!"
            task.wait(2)
            if humanoid then
                speedDisplay.Text = "Current: "..humanoid.WalkSpeed.." studs"
            else
                speedDisplay.Text = "Current: ?"
            end
        end
    else
        speedDisplay.Text = "Invalid speed (16-100)"
        textBox.Text = "16"
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end

applyButton.MouseButton1Click:Connect(updateWalkSpeed)
textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        updateWalkSpeed()
    end
end)

-- Handle character respawns
player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    speedDisplay.Text = "Current: "..humanoid.WalkSpeed.." studs"
    textBox.Text = tostring(humanoid.WalkSpeed)
end)
