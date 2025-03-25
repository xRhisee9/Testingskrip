local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local Window = Rayfield:CreateWindow({
    Name = "Character Speed Controller",
    LoadingTitle = "Speed Control",
    LoadingSubtitle = "by YourName",
    ConfigurationSaving = {
        Enabled = false,
    },
    KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458)

local SpeedSlider = MainTab:CreateSection("Speed Adjustment")

local slider = MainTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = humanoid.WalkSpeed,
    Flag = "SpeedSlider",
    Callback = function(value)
        humanoid.WalkSpeed = value
    end,
})

local autoRunToggle = MainTab:CreateToggle({
    Name = "Auto Run",
    CurrentValue = false,
    Flag = "AutoRunToggle",
    Callback = function(state)
        if state then
            humanoid.WalkSpeed = 50
            slider:Set(50)
        else
            humanoid.WalkSpeed = 16
            slider:Set(16)
        end
    end,
})

MainTab:CreateButton({
    Name = "Reset to Default",
    Callback = function()
        humanoid.WalkSpeed = 16
        slider:Set(16)
        autoRunToggle:Set(false)
        Rayfield:Notify({
            Title = "Speed Reset",
            Content = "Your speed has been reset to default",
            Duration = 3,
            Image = 4483362458,
        })
    end,
})

local InfoSection = MainTab:CreateSection("Information")

MainTab:CreateLabel("Current Speed: " .. humanoid.WalkSpeed .. " studs")

humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    local label = InfoSection:FindFirstChild("CurrentSpeedLabel")
    if label then
        label:Set("Current Speed: " .. humanoid.WalkSpeed .. " studs")
    end
end)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = newCharacter:WaitForChild("Humanoid")
    
    slider:Set(humanoid.WalkSpeed)
    
    if autoRunToggle.CurrentValue then
        humanoid.WalkSpeed = 50
        slider:Set(50)
    end
end)

local Input = game:GetService("UserInputService")
local uiHidden = false

MainTab:CreateKeybind({
    Name = "Toggle UI",
    CurrentKeybind = "U",
    HoldToInteract = false,
    Flag = "UIKeybind",
    Callback = function()
        uiHidden = not uiHidden
        Window:Toggle(uiHidden)
    end,
})

Rayfield:Notify({
    Title = "Speed Control Loaded",
    Content = "Press U to toggle the UI",
    Duration = 5,
    Image = 4483362458,
})
