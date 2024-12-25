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

-- Function to make the menu drop down or up
local menuExpanded = false
function toggleMenu()
    if menuExpanded then
        menuFrame:TweenSize(UDim2.new(0, 250, 0, 50), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.5, true)
    else
        if isMobile then
            menuFrame:TweenSize(UDim2.new(0, 200, 0, 350), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.5, true)
        else
            menuFrame:TweenSize(UDim2.new(0, 250, 0, 400), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.5, true)
        end
    end
    menuExpanded = not menuExpanded
end

-- Button to toggle the menu open/close
local toggleMenuButton = Instance.new("TextButton")
toggleMenuButton.Text = "Toggle Menu"
toggleMenuButton.Size = UDim2.new(0, 120, 0, 40)
toggleMenuButton.Position = UDim2.new(0, 10, 0, 70)
toggleMenuButton.Parent = menuFrame
toggleMenuButton.MouseButton1Click:Connect(toggleMenu)

-- Check if the player is on mobile or PC
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled

if isMobile then
    menuFrame.Size = UDim2.new(0, 200, 0, 50)
    menuTitle.TextSize = 20
    toggleMenuButton.Size = UDim2.new(0, 120, 0, 40)
else
    menuFrame.Size = UDim2.new(0, 250, 0, 50)
    menuTitle.TextSize = 24
    toggleMenuButton.Size = UDim2.new(0, 150, 0, 50)
end

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

-- Player Settings Buttons
local outlineButton = Instance.new("TextButton")
outlineButton.Text = "Toggle Outline"
outlineButton.Size = UDim2.new(0, 150, 0, 50)
outlineButton.Position = UDim2.new(0, 10, 0, 10)
outlineButton.Parent = playerSettings

local showInfoButton = Instance.new("TextButton")
showInfoButton.Text = "Show Player Info"
showInfoButton.Size = UDim2.new(0, 150, 0, 50)
showInfoButton.Position = UDim2.new(0, 10, 0, 70)
showInfoButton.Parent = playerSettings

-- Movement Settings Buttons
local fastAnimationButton = Instance.new("TextButton")
fastAnimationButton.Text = "Fast Animations"
fastAnimationButton.Size = UDim2.new(0, 150, 0, 50)
fastAnimationButton.Position = UDim2.new(0, 10, 0, 10)
fastAnimationButton.Parent = movementSettings

local flyButton = Instance.new("TextButton")
flyButton.Text = "Toggle Fly"
flyButton.Size = UDim2.new(0, 150, 0, 50)
flyButton.Position = UDim2.new(0, 10, 0, 70)
flyButton.Parent = movementSettings

local noclipButton = Instance.new("TextButton")
noclipButton.Text = "Toggle Noclip"
noclipButton.Size = UDim2.new(0, 150, 0, 50)
noclipButton.Position = UDim2.new(0, 10, 0, 130)
noclipButton.Parent = movementSettings

-- Placeholder Functions for Each Button
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- For toggling the outline (Client-side)
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

-- For showing player info (Client-side)
local function showPlayerInfo()
    local playerInfo = "Name: " .. player.Name .. "\n"
    playerInfo = playerInfo .. "Distance: " .. (player.Character.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).magnitude .. " studs\n"
    playerInfo = playerInfo .. "Join Date: " .. player.AccountAge .. " days"
    print(playerInfo)
end

-- For fast animations (simply adjusts the speed) (Client-side)
local function fastAnimation()
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 100  -- Make walking faster
        humanoid.JumpHeight = 50  -- Make jumping higher
    end
end

-- For fly mode (Server-side)
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

-- For noclip mode (Server-side)
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

-- Connect button actions
outlineButton.MouseButton1Click:Connect(toggleOutline)
showInfoButton.MouseButton1Click:Connect(showPlayerInfo)
fastAnimationButton.MouseButton1Click:Connect(fastAnimation)
flyButton.MouseButton1Click:Connect(toggleFly)
noclipButton.MouseButton1Click:Connect(toggleNoclip)
