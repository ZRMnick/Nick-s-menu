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
introLabel.Text = "Nick's Menu | V1.0"
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
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Visible = false

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

-- Animate Main Menu Appearance
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -600)
mainFrame.Visible = true
mainFrame:TweenPosition(UDim2.new(0.5, -200, 0.5, -250), "Out", "Bounce", 1, true)

-- Create Categories
local categories = {
    {Name = "Player Scripts", Color = Color3.fromRGB(50, 50, 200)},
    {Name = "Visuals", Color = Color3.fromRGB(200, 50, 50)},
    {Name = "Miscellaneous", Color = Color3.fromRGB(50, 200, 50)},
}

local categoryFrames = {}
for i, category in ipairs(categories) do
    local button = Instance.new("TextButton", mainFrame)
    button.Size = UDim2.new(0.9, 0, 0, 60)
    button.Position = UDim2.new(0.05, 0, 0, 80 + (i - 1) * 80)
    button.Text = category.Name
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = category.Color

    -- Create category frame
    local categoryFrame = Instance.new("Frame", mainFrame)
    categoryFrame.Size = UDim2.new(1, 0, 0.6, 0)
    categoryFrame.Position = UDim2.new(0, 0, 0, 80 + (i - 1) * 80 + 70)
    categoryFrame.BackgroundTransparency = 1
    categoryFrame.Visible = false
    table.insert(categoryFrames, categoryFrame)

    -- Toggle visibility of category
    button.MouseButton1Click:Connect(function()
        for _, frame in pairs(categoryFrames) do
            frame.Visible = false
        end
        categoryFrame.Visible = true
    end)
end

-- Example Buttons in Categories
local exampleButton = Instance.new("TextButton", categoryFrames[1])
exampleButton.Size = UDim2.new(0.8, 0, 0, 50)
exampleButton.Position = UDim2.new(0.1, 0, 0, 20)
exampleButton.Text = "Outline Players"
exampleButton.TextScaled = true
exampleButton.Font = Enum.Font.Gotham
exampleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exampleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)

exampleButton.MouseButton1Click:Connect(function()
    -- Your script logic here
end)
