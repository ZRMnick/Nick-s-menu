-- Main GUI Script
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create Intro Screen
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "NicksMenuGUI"

local introFrame = Instance.new("Frame", screenGui)
introFrame.Size = UDim2.new(1, 0, 1, 0)
introFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

local introLabel = Instance.new("TextLabel", introFrame)
introLabel.Size = UDim2.new(0.6, 0, 0.2, 0)
introLabel.Position = UDim2.new(0.2, 0, 0.4, 0)
introLabel.Text = "Nick's old Menu | V1.0"
introLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
introLabel.TextScaled = true
introLabel.Font = Enum.Font.GothamBold
introLabel.BackgroundTransparency = 1

-- Intro Animation
introLabel:TweenPosition(UDim2.new(0.2, 0, 0.3, 0), "Out", "Quad", 1, true)
task.wait(2)
introFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 1, true)
task.wait(1)
introFrame:Destroy()

-- Main Menu UI
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)  -- Centered position
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Visible = false  -- Initially hidden

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 60)
titleLabel.Text = "Nick's Menu | V1.0"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 40, 0, 40)
minimizeButton.Position = UDim2.new(1, -50, 0, 10)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.Gotham
minimizeButton.TextScaled = true
minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local isMinimized = false

-- Minimize Logic
minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    for _, child in pairs(mainFrame:GetChildren()) do
        if child ~= titleLabel and child ~= minimizeButton then
            child.Visible = not isMinimized
        end
    end
    mainFrame.Size = isMinimized and UDim2.new(0, 400, 0, 60) or UDim2.new(0, 400, 0, 500)
end)

-- Drag Functionality (Mobile and PC)
local dragging
local dragInput
local dragStart
local startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

titleLabel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Ensure the menu is initially centered (no need to start off-screen)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)  -- Properly centered from the start
mainFrame.Visible = true

-- Animating the Main Menu into view
task.wait(0.5)  -- Short delay to ensure visibility before animation
mainFrame:TweenPosition(UDim2.new(0.5, -200, 0.5, -250), "Out", "Quad", 1, true)  -- Animate the position (just in case we need it)

-- Buttons and Scripts
local button1 = Instance.new("TextButton", mainFrame)
button1.Size = UDim2.new(0.9, 0, 0, 50)
button1.Position = UDim2.new(0.05, 0, 0, 100)
button1.Text = "Outline Players"
button1.TextScaled = true
button1.Font = Enum.Font.Gotham
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.BackgroundColor3 = Color3.fromRGB(50, 50, 200)

button1.MouseButton1Click:Connect(function()
    for _, target in pairs(game.Players:GetPlayers()) do
        if target ~= player then
            local highlight = Instance.new("Highlight")
            highlight.Parent = target.Character
            highlight.Adornee = target.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

local button2 = Instance.new("TextButton", mainFrame)
button2.Size = UDim2.new(0.9, 0, 0, 50)
button2.Position = UDim2.new(0.05, 0, 0, 160)
button2.Text = "Fast Animations"
button2.TextScaled = true
button2.Font = Enum.Font.Gotham
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.BackgroundColor3 = Color3.fromRGB(50, 200, 50)

button2.MouseButton1Click:Connect(function()
    for _, anim in pairs(player.Character.Humanoid.Animator:GetPlayingAnimationTracks()) do
        anim:AdjustSpeed(2.5)
    end
end)
