-- // Rivals Mod Menu Script with Full Features
-- Compatible with Mobile and PC
-- Made for Delta Executor

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local workspace = game.Workspace
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")

-- ESP Storage
local espEnabled = false
local boxEspEnabled = false
local lineEspEnabled = false
local espObjects = {}

-- UI Elements
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")
local dropdown = Instance.new("Frame")
local minimizeButton = Instance.new("TextButton")
local dropdownVisible = false
local isMinimized = false

-- Add to GUI
screenGui.Parent = game.CoreGui
screenGui.Name = "RivalsModMenu"

-- Frame Setup
frame.Parent = screenGui
frame.Size = UDim2.new(0, 220, 0, 50) -- Minimized by default
frame.Position = UDim2.new(0.5, -110, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true

-- Minimize Button
minimizeButton.Parent = frame
minimizeButton.Text = "▼"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(0, 190, 0, 10)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.SourceSans
minimizeButton.TextSize = 18

-- Dropdown Setup
dropdown.Parent = frame
dropdown.Size = UDim2.new(0, 220, 0, 0)
dropdown.Position = UDim2.new(0, 0, 0, 50)
dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dropdown.ClipsDescendants = true

-- Toggle Button Setup
toggleButton.Parent = frame
toggleButton.Text = "Open Menu"
toggleButton.Size = UDim2.new(0, 180, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextSize = 18

-- // Functions
local function createDropdownButton(name, callback)
    local button = Instance.new("TextButton")
    button.Parent = dropdown
    button.Text = name
    button.Size = UDim2.new(0, 200, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Toggle Dropdown
local function toggleDropdown()
    dropdownVisible = not dropdownVisible
    if dropdownVisible then
        dropdown:TweenSize(UDim2.new(0, 220, 0, 440), "Out", "Quad", 0.3, true)
    else
        dropdown:TweenSize(UDim2.new(0, 220, 0, 0), "Out", "Quad", 0.3, true)
    end
end

-- Minimize/Maximize Menu
local function toggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        minimizeButton.Text = "▲"
        frame:TweenSize(UDim2.new(0, 220, 0, 50), "Out", "Quad", 0.3, true)
    else
        minimizeButton.Text = "▼"
        frame:TweenSize(UDim2.new(0, 220, 0, 490), "Out", "Quad", 0.3, true)
    end
end

-- Features Implementation
local function toggleAutoCollect()
    local autoCollectEnabled = not autoCollectEnabled
    if autoCollectEnabled then
        print("Auto Collect Coins Enabled")
        while autoCollectEnabled do
            for _, coin in pairs(workspace.Coins:GetChildren()) do
                if coin:IsA("Part") and coin:FindFirstChild("TouchInterest") then
                    firetouchinterest(player.Character.HumanoidRootPart, coin, 0)
                    wait(0.1)
                    firetouchinterest(player.Character.HumanoidRootPart, coin, 1)
                end
            end
            wait(1)
        end
    else
        print("Auto Collect Coins Disabled")
    end
end

local function toggleSpeed()
    local speedEnabled = not speedEnabled
    if speedEnabled then
        player.Character.Humanoid.WalkSpeed = 100
        print("Speed Hack Enabled")
    else
        player.Character.Humanoid.WalkSpeed = 16
        print("Speed Hack Disabled")
    end
end

local function toggleJump()
    local jumpEnabled = not jumpEnabled
    if jumpEnabled then
        player.Character.Humanoid.JumpPower = 200
        print("Jump Hack Enabled")
    else
        player.Character.Humanoid.JumpPower = 50
        print("Jump Hack Disabled")
    end
end

local function teleportTo(position)
    player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    print("Teleported to", position)
end

local function toggleInvisible()
    player.Character.Head.Transparency = 1
    for _, part in ipairs(player.Character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
            part.CanCollide = false
        end
    end
    print("Invisible Mode Enabled")
end

local function toggleKillAura()
    local killAuraEnabled = not killAuraEnabled
    if killAuraEnabled then
        print("Kill Aura Enabled")
        runService.RenderStepped:Connect(function()
            for _, target in pairs(workspace.Players:GetChildren()) do
                if target ~= player and target:FindFirstChild("Humanoid") then
                    target.Humanoid:TakeDamage(10)
                end
            end
        end)
    else
        print("Kill Aura Disabled")
    end
end

-- ESP Functions
local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        for _, target in pairs(workspace.Players:GetChildren()) do
            if target ~= player and target:FindFirstChild("HumanoidRootPart") then
                local espElement = createESP(target.HumanoidRootPart)
                espElement.Parent = target
                table.insert(espObjects, espElement)
            end
        end
        print("ESP Enabled")
    else
        for _, esp in pairs(espObjects) do
            esp:Destroy()
        end
        espObjects = {}
        print("ESP Disabled")
    end
end

-- // Add Buttons
createDropdownButton("Toggle Auto Collect", toggleAutoCollect)
createDropdownButton("Toggle Speed Hack", toggleSpeed)
createDropdownButton("Toggle Jump Hack", toggleJump)
createDropdownButton("Teleport to (0, 100, 0)", function() teleportTo(Vector3.new(0, 100, 0)) end)
createDropdownButton("Toggle Invisible", toggleInvisible)
createDropdownButton("Toggle Kill Aura", toggleKillAura)
createDropdownButton("Toggle ESP", toggleESP)

-- Connect UI Buttons
toggleButton.MouseButton1Click:Connect(toggleDropdown)
minimizeButton.MouseButton1Click:Connect(toggleMinimize)

print("Enhanced Mod Menu with Full Features Loaded!")
