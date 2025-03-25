local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("EnhancedSpeedGUI") then
    playerGui.EnhancedSpeedGUI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "EnhancedSpeedGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.ZIndex = -1
shadow.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 2

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0, 200, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "CHARACTER SPEED CONTROL"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 16
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.ZIndex = 3

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 40, 0, 40)
minimizeButton.Position = UDim2.new(1, -40, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(0, 90, 180)
minimizeButton.BackgroundTransparency = 0.5
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 24
minimizeButton.ZIndex = 3

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 12)
minimizeCorner.Parent = minimizeButton

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1

local textBox = Instance.new("TextBox")
textBox.Name = "SpeedInput"
textBox.Size = UDim2.new(1, -20, 0, 40)
textBox.Position = UDim2.new(0, 10, 0, 10)
textBox.PlaceholderText = "Enter speed (16-100)"
textBox.Text = "16"
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.ClearTextOnFocus = false
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 16
textBox.TextWrapped = true

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 6)
textBoxCorner.Parent = textBox

local speedDisplay = Instance.new("TextLabel")
speedDisplay.Name = "SpeedDisplay"
speedDisplay.Size = UDim2.new(1, -20, 0, 30)
speedDisplay.Position = UDim2.new(0, 10, 0, 60)
speedDisplay.BackgroundTransparency = 1
speedDisplay.Text = "Current Speed: 16 studs"
speedDisplay.TextColor3 = Color3.fromRGB(200, 220, 255)
speedDisplay.Font = Enum.Font.GothamSemibold
speedDisplay.TextSize = 16
speedDisplay.TextXAlignment = Enum.TextXAlignment.Left

local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(1, -20, 0, 45)
applyButton.Position = UDim2.new(0, 10, 0, 100)
applyButton.Text = "APPLY SPEED"
applyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.Font = Enum.Font.GothamBold
applyButton.TextSize = 18
applyButton.AutoButtonColor = false

applyButton.MouseEnter:Connect(function()
    applyButton.BackgroundColor3 = Color3.fromRGB(20, 190, 255)
end)

applyButton.MouseLeave:Connect(function()
    applyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)

applyButton.MouseButton1Down:Connect(function()
    applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 230)
end)

applyButton.MouseButton1Up:Connect(function()
    applyButton.BackgroundColor3 = Color3.fromRGB(20, 190, 255)
end)

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = applyButton

titleText.Parent = titleBar
minimizeButton.Parent = titleBar
titleBar.Parent = mainFrame

textBox.Parent = contentFrame
speedDisplay.Parent = contentFrame
applyButton.Parent = contentFrame
contentFrame.Parent = mainFrame

mainFrame.Parent = gui

local isMinimized = false
local originalSize = mainFrame.Size
local originalPosition = mainFrame.Position

minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        minimizeButton.Text = "+"
        contentFrame.Visible = false
        mainFrame.Size = UDim2.new(0, 300, 0, 40) 
        mainFrame.Position = UDim2.new(0.5, -150, 0, 10)
    else
        minimizeButton.Text = "-"
        contentFrame.Visible = true
        mainFrame.Size = originalSize
        mainFrame.Position = originalPosition
    end
end)

local dragging = false
local dragStartPos
local frameStartPos

local function updateInput(input)
    local delta = input.Position - dragStartPos
    mainFrame.Position = UDim2.new(
        frameStartPos.X.Scale, 
        frameStartPos.X.Offset + delta.X,
        frameStartPos.Y.Scale, 
        frameStartPos.Y.Offset + delta.Y
    )
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position
        frameStartPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateInput(input)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateInput(input)
    end
end)

local function updateWalkSpeed()
    local speedValue = tonumber(textBox.Text)
    
    if speedValue and speedValue >= 16 and speedValue <= 100 then
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        
        if humanoid then
            humanoid.WalkSpeed = speedValue
            speedDisplay.Text = "Current Speed: "..speedValue.." studs"
            textBox.Text = tostring(speedValue)
            
            applyButton.Text = "APPLIED!"
            task.wait(0.5)
            applyButton.Text = "APPLY SPEED"
        else
            speedDisplay.Text = "Character not found!"
            task.wait(2)
            if humanoid then
                speedDisplay.Text = "Current Speed: "..humanoid.WalkSpeed.." studs"
            else
                speedDisplay.Text = "Current Speed: ?"
            end
        end
    else
        speedDisplay.Text = "Please enter between 16-100"
        textBox.Text = "16"
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16
        end
        
        local originalColor = textBox.BackgroundColor3
        textBox.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        task.wait(0.3)
        textBox.BackgroundColor3 = originalColor
    end
end

applyButton.MouseButton1Click:Connect(updateWalkSpeed)
textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        updateWalkSpeed()
    end
end)

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    speedDisplay.Text = "Current Speed: "..humanoid.WalkSpeed.." studs"
    textBox.Text = tostring(humanoid.WalkSpeed)
end)

if player.Character then
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if humanoid then
        speedDisplay.Text = "Current Speed: "..humanoid.WalkSpeed.." studs"
        textBox.Text = tostring(humanoid.WalkSpeed)
    end
end
