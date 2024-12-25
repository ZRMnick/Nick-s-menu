-- Initialize main mod menu GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main menu frame (this will hold all the buttons)
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 250, 0, 0)  -- Initial size is small
menuFrame.Position = UDim2.new(0, 10, 0, 10)
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuFrame.BackgroundTransparency = 0.5
menuFrame.Parent = screenGui

-- Title of the menu
local menuTitle = Instance.new("TextLabel")
menuTitle.Text = "Mod Menu"
menuTitle.Size = UDim2.new(1, 0, 0, 50)
menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
menuTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuTitle.TextSize = 24
menuTitle.Parent = menuFrame

-- Scrollable section for the buttons
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -50)
scrollFrame.Position = UDim2.new(0, 0, 0, 50)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
scrollFrame.ScrollBarThickness = 5
scrollFrame.BackgroundTransparency = 1
scrollFrame.Parent = menuFrame

-- Container for buttons inside the scrollable frame
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, 0, 0, 1000)
buttonContainer.Parent = scrollFrame

-- Initialize moveable frame (for dragging the menu)
local dragging = false
local dragStart = nil
local startPos = nil

menuFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = menuFrame.Position
    end
end)

menuFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        menuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

menuFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Create categories for different settings
local playerSettings = Instance.new("Frame")
playerSettings.Size = UDim2.new(1, 0, 0, 100)
playerSettings.Position = UDim2.new(0, 0, 0, 0)
playerSettings.BackgroundTransparency = 1
playerSettings.Parent = buttonContainer

local movementSettings = Instance.new("Frame")
movementSettings.Size = UDim2.new(1, 0, 0, 100)
movementSettings.Position = UDim2.new(0, 0, 0, 100)
movementSettings.BackgroundTransparency = 1
movementSettings.Parent = buttonContainer

-- Placeholder Functions for Each Action
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- For toggling the outline
local function toggleOutline()
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Head") then
            local outline = v:FindFirstChild("Outline")
            if not outline then
                outline = Instance.new("SelectionBox")
                outline.Name = "Outline"
                outline.Adornee = v
                outline.Color3 = Color3.fromRGB(255, 0, 0)  -- Red Outline
                outline.Parent = v
            else
                outline:Destroy()
            end
        end
    end
end

-- For showing player info
local function showPlayerInfo()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            local distance = (plr.Character.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).magnitude
            local joinDate = plr.AccountAge
            local playerInfo = "Name: " .. plr.Name .. "\nDistance: " .. distance .. " studs\nJoin Date: " .. joinDate .. " days"
            local infoGui = Instance.new("BillboardGui")
            infoGui.Parent = plr.Character.Head
            infoGui.Adornee = plr.Character.Head
            infoGui.Size = UDim2.new(0, 200, 0, 50)
            local infoLabel = Instance.new("TextLabel")
            infoLabel.Size = UDim2.new(1, 0, 1, 0)
            infoLabel.Text = playerInfo
            infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            infoLabel.BackgroundTransparency = 1
            infoLabel.Parent = infoGui
            wait(3) -- Keep info displayed for 3 seconds
            infoGui:Destroy()
        end
    end
end

-- For fast animations (simply adjusts the speed)
local function fastAnimation()
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 100  -- Make walking faster
        humanoid.JumpHeight = 50  -- Make jumping higher
    end
end

-- For fly mode
local flying = false
local bodyVelocity = nil
local function toggleFly()
    if flying then
        bodyVelocity:Destroy()
        flying = false
    else
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        bodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart")
        flying = true
    end
end

-- For noclip mode
local noclip = false
local function toggleNoclip()
    noclip = not noclip
    if noclip then
        character:FindFirstChild("Humanoid").PlatformStand = true
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        character:FindFirstChild("Humanoid").PlatformStand = false
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Terms of Service Popup
local tosFrame = Instance.new("Frame")
tosFrame.Size = UDim2.new(0, 300, 0, 300)
tosFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
tosFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
tosFrame.BackgroundTransparency = 0.8
tosFrame.Parent = screenGui

local tosTitle = Instance.new("TextLabel")
tosTitle.Text = "Terms of Service"
tosTitle.Size = UDim2.new(1, 0, 0, 30)
tosTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
tosTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
tosTitle.TextSize = 24
tosTitle.Parent = tosFrame

local tosText = Instance.new("TextLabel")
tosText.Text = "By using this script, you agree to follow the terms of service. Do not use this mod for malicious purposes. Enjoy your experience!"
tosText.Size = UDim2.new(1, 0, 0, 100)
tosText.Position = UDim2.new(0, 0, 0, 30)
tosText.TextColor3 = Color3.fromRGB(255, 255, 255)
tosText.BackgroundTransparency = 1
tosText.TextSize = 16
tosText.TextWrapped = true
tosText.Parent = tosFrame

local agreeButton = Instance.new("TextButton")
agreeButton.Text = "I Agree"
agreeButton.Size = UDim2.new(0, 120, 0, 40)
agreeButton.Position = UDim2.new(0.5, -130, 0, 180)
agreeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
agreeButton.Parent = tosFrame

local disagreeButton = Instance.new("TextButton")
disagreeButton.Text = "I Disagree"
disagreeButton.Size = UDim2.new(0, 120, 0, 40)
disagreeButton.Position = UDim2.new(0.5, 10, 0, 180)
disagreeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
disagreeButton.Parent = tosFrame

local discordButton = Instance.new("TextButton")
discordButton.Text = "Join Discord"
discordButton.Size = UDim2.new(0, 120, 0, 40)
discordButton.Position = UDim2.new(0.5, -130, 0, 230)
discordButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
discordButton.Parent = tosFrame

-- Button connections
agreeButton.MouseButton1Click:Connect(function()
    tosFrame:Destroy()
    -- Continue to main menu setup here
