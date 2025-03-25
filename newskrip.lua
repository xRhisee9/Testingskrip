-- RayField UI Speed Controller
-- Place this LocalScript in StarterPlayerScripts

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Wait for character to load
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Create RayField window
local Window = Rayfield:CreateWindow({
    Name = "Character Speed Controller",
    LoadingTitle = "Speed Control",
    LoadingSubtitle = "by YourName",
    ConfigurationSaving = {
        Enabled = false,
    },
    KeySystem = false, -- Set to true if you want key system
})

-- Create main tab
local MainTab = Window:CreateTab("Main", 4483362458) -- Optional icon ID

-- Create speed slider section
local SpeedSlider = MainTab:CreateSection("Speed Adjustment")

-- Create slider
local slider = MainTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = humanoid.WalkSpeed,
    Flag = "SpeedSlider", -- Optional flag
    Callback = function(value)
        humanoid.WalkSpeed = value
    end,
})

-- Create toggle for auto-run
local autoRunToggle = MainTab:CreateToggle({
    Name = "Auto Run",
    CurrentValue = false,
    Flag = "AutoRunToggle",
    Callback = function(state)
        if state then
            humanoid.WalkSpeed = 50 -- Default run speed
            slider:Set(50) -- Update slider to match
        else
            humanoid.WalkSpeed = 16 -- Default walk speed
            slider:Set(16) -- Update slider to match
        end
    end,
})

-- Create button to reset to default
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

-- Create info section
local InfoSection = MainTab:CreateSection("Information")

MainTab:CreateLabel("Current Speed: " .. humanoid.WalkSpeed .. " studs")

-- Update label when speed changes
humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    local label = InfoSection:FindFirstChild("CurrentSpeedLabel")
    if label then
        label:Set("Current Speed: " .. humanoid.WalkSpeed .. " studs")
    end
end)

-- Character respawn handler
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = newCharacter:WaitForChild("Humanoid")
    
    -- Update slider to match new character's speed
    slider:Set(humanoid.WalkSpeed)
    
    -- If auto-run was enabled, apply to new character
    if autoRunToggle.CurrentValue then
        humanoid.WalkSpeed = 50
        slider:Set(50)
    end
end)

-- Keybind to toggle UI (optional)
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

-- Notification when loaded
Rayfield:Notify({
    Title = "Speed Control Loaded",
    Content = "Press U to toggle the UI",
    Duration = 5,
    Image = 4483362458,
})
