-- FATALITY Mod Menu by Zo for Alpha in Zeta (Enhanced for Mobile and Power)
-- This script creates a mod menu GUI for Roblox with advanced hacking features

-- Ensure this script runs on the client side (LocalScript)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local guiEnabled = false

-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FatalityMenu"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.IgnoreGuiInset = true -- Ensures the GUI isn't offset by the top bar on mobile

-- Create the main frame (scaled for mobile)
local scaleFactor = 0.6
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400 * scaleFactor, 0, 500 * scaleFactor)
mainFrame.Position = UDim2.new(0.5, -(400 * scaleFactor) / 2, 0.5, -(500 * scaleFactor) / 2)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Create the title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30 * scaleFactor)
titleBar.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60 * scaleFactor, 1, 0)
titleLabel.Position = UDim2.new(0, 10 * scaleFactor, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FATALITY"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20 * scaleFactor
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = titleBar

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30 * scaleFactor, 0, 30 * scaleFactor)
closeButton.Position = UDim2.new(1, -30 * scaleFactor, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16 * scaleFactor
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = titleBar

-- Warning label
local warningLabel = Instance.new("TextLabel")
warningLabel.Size = UDim2.new(0, 380 * scaleFactor, 0, 60 * scaleFactor)
warningLabel.Position = UDim2.new(0, 10 * scaleFactor, 0, 40 * scaleFactor)
warningLabel.BackgroundTransparency = 1
warningLabel.Text = "HEADS UP!\nTHIS GUI IS MADE ONLY FOR SERIOUS HACKING SKILLS AND WILL NOT BE GIVEN FOR FREE"
warningLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
warningLabel.TextSize = 14 * scaleFactor
warningLabel.Font = Enum.Font.SourceSans
warningLabel.TextWrapped = true
warningLabel.Parent = mainFrame

-- Category frame (left side)
local categoryFrame = Instance.new("Frame")
categoryFrame.Size = UDim2.new(0, 100 * scaleFactor, 0, 400 * scaleFactor)
categoryFrame.Position = UDim2.new(0, 10 * scaleFactor, 0, 100 * scaleFactor)
categoryFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
categoryFrame.BorderSizePixel = 0
categoryFrame.Parent = mainFrame

-- Content frame (right side)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0, 270 * scaleFactor, 0, 380 * scaleFactor)
contentFrame.Position = UDim2.new(0, 120 * scaleFactor, 0, 110 * scaleFactor)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- Categories
local categories = {"CREDITS", "BASIC", "EXECUTOR", "CHAOTIC", "VISUALS", "OTHERS", "POWER"}
local currentCategory = "BASIC"

-- Create category buttons
for i, category in pairs(categories) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10 * scaleFactor, 0, 50 * scaleFactor)
    button.Position = UDim2.new(0, 5 * scaleFactor, 0, (i-1) * 55 * scaleFactor)
    button.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    button.Text = category .. (category == "POWER" and "!" or "")
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16 * scaleFactor
    button.Font = Enum.Font.SourceSans
    button.Parent = categoryFrame

    button.MouseButton1Click:Connect(function()
        currentCategory = category
        for _, child in pairs(contentFrame:GetChildren()) do
            child:Destroy()
        end
        loadCategoryContent(category)
    end)
end

-- Function to load content for each category
function loadCategoryContent(category)
    if category == "CREDITS" then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20 * scaleFactor, 1, -20 * scaleFactor)
        label.Position = UDim2.new(0, 10 * scaleFactor, 0, 10 * scaleFactor)
        label.BackgroundTransparency = 1
        label.Text = "Created by Zo for Alpha, the commander of Zeta."
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 14 * scaleFactor
        label.TextWrapped = true
        label.Parent = contentFrame

    elseif category == "BASIC" then
        -- Speed Hack
        local speedButton = Instance.new("TextButton")
        speedButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        speedButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 10 * scaleFactor)
        speedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        speedButton.Text = "Speed Hack (100)"
        speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        speedButton.TextSize = 14 * scaleFactor
        speedButton.Parent = contentFrame

        speedButton.MouseButton1Click:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = 100
            end
        end)

        -- Jump Power
        local jumpButton = Instance.new("TextButton")
        jumpButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        jumpButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 60 * scaleFactor)
        jumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        jumpButton.Text = "Jump Power (100)"
        jumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        jumpButton.TextSize = 14 * scaleFactor
        jumpButton.Parent = contentFrame

        jumpButton.MouseButton1Click:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.JumpPower = 100
            end
        end)

    elseif category == "EXECUTOR" then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        label.Position = UDim2.new(0, 10 * scaleFactor, 0, 10 * scaleFactor)
        label.BackgroundTransparency = 1
        label.Text = "Execute custom scripts here."
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 14 * scaleFactor
        label.Parent = contentFrame

        local scriptBox = Instance.new("TextBox")
        scriptBox.Size = UDim2.new(1, -20 * scaleFactor, 0, 100 * scaleFactor)
        scriptBox.Position = UDim2.new(0, 10 * scaleFactor, 0, 60 * scaleFactor)
        scriptBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        scriptBox.TextSize = 14 * scaleFactor
        scriptBox.MultiLine = true
        scriptBox.ClearTextOnFocus = false
        scriptBox.Text = "-- Enter Lua script here"
        scriptBox.Parent = contentFrame

        local executeButton = Instance.new("TextButton")
        executeButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        executeButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 170 * scaleFactor)
        executeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        executeButton.Text = "Execute Script"
        executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        executeButton.TextSize = 14 * scaleFactor
        executeButton.Parent = contentFrame

        executeButton.MouseButton1Click:Connect(function()
            local func, err = loadstring(scriptBox.Text)
            if func then
                func()
            else
                warn("Error executing script: " .. err)
            end
        end)

    elseif category == "CHAOTIC" then
        -- Kill All Players
        local killButton = Instance.new("TextButton")
        killButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        killButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 10 * scaleFactor)
        killButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        killButton.Text = "Kill All Players"
        killButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        killButton.TextSize = 14 * scaleFactor
        killButton.Parent = contentFrame

        killButton.MouseButton1Click:Connect(function()
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
                    p.Character.Humanoid.Health = 0
                end
            end
        end)

        -- Aimbot
        local aimbotButton = Instance.new("TextButton")
        aimbotButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        aimbotButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 60 * scaleFactor)
        aimbotButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        aimbotButton.Text = "Toggle Aimbot"
        aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        aimbotButton.TextSize = 14 * scaleFactor
        aimbotButton.Parent = contentFrame

        local aimbotEnabled = false
        aimbotButton.MouseButton1Click:Connect(function()
            aimbotEnabled = not aimbotEnabled
            aimbotButton.Text = "Toggle Aimbot (" .. (aimbotEnabled and "ON" or "OFF") .. ")"
        end)

        -- Aimbot logic
        runService.RenderStepped:Connect(function()
            if aimbotEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local closestPlayer = nil
                local closestDistance = math.huge
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                        local distance = (p.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = p
                        end
                    end
                end
                if closestPlayer and closestPlayer.Character then
                    local targetPos = closestPlayer.Character.HumanoidRootPart.Position
                    local playerPos = player.Character.HumanoidRootPart.Position
                    local lookVector = (targetPos - playerPos).Unit
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(playerPos, playerPos + lookVector)
                end
            end
        end)

        -- Kill Aura
        local killAuraButton = Instance.new("TextButton")
        killAuraButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        killAuraButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 110 * scaleFactor)
        killAuraButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        killAuraButton.Text = "Toggle Kill Aura"
        killAuraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        killAuraButton.TextSize = 14 * scaleFactor
        killAuraButton.Parent = contentFrame

        local killAuraEnabled = false
        killAuraButton.MouseButton1Click:Connect(function()
            killAuraEnabled = not killAuraEnabled
            killAuraButton.Text = "Toggle Kill Aura (" .. (killAuraEnabled and "ON" or "OFF") .. ")"
        end)

        -- Kill Aura logic
        runService.Heartbeat:Connect(function()
            if killAuraEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                        local distance = (p.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance <= 20 then
                            p.Character.Humanoid.Health = 0
                        end
                    end
                end
            end
        end)

    elseif category == "VISUALS" then
        -- ESP (Highlight Players)
        local espButton = Instance.new("TextButton")
        espButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        espButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 10 * scaleFactor)
        espButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        espButton.Text = "Toggle ESP"
        espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        espButton.TextSize = 14 * scaleFactor
        espButton.Parent = contentFrame

        local espEnabled = false
        espButton.MouseButton1Click:Connect(function()
            espEnabled = not espEnabled
            espButton.Text = "Toggle ESP (" .. (espEnabled and "ON" or "OFF") .. ")"
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local highlight = p.Character:FindFirstChild("ESPHighlight")
                    if espEnabled then
                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "ESPHighlight"
                            highlight.FillColor = Color3.fromRGB(0, 255, 0)
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.Parent = p.Character
                        end
                    else
                        if highlight then
                            highlight:Destroy()
                        end
                    end
                end
            end
        end)

        -- Fullbright
        local fullbrightButton = Instance.new("TextButton")
        fullbrightButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        fullbrightButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 60 * scaleFactor)
        fullbrightButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        fullbrightButton.Text = "Toggle Fullbright"
        fullbrightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        fullbrightButton.TextSize = 14 * scaleFactor
        fullbrightButton.Parent = contentFrame

        local fullbrightEnabled = false
        local lighting = game:GetService("Lighting")
        local oldBrightness = lighting.Brightness
        local oldAmbient = lighting.Ambient
        local oldOutdoorAmbient = lighting.OutdoorAmbient
        local oldFogEnd = lighting.FogEnd

        fullbrightButton.MouseButton1Click:Connect(function()
            fullbrightEnabled = not fullbrightEnabled
            fullbrightButton.Text = "Toggle Fullbright (" .. (fullbrightEnabled and "ON" or "OFF") .. ")"
            if fullbrightEnabled then
                lighting.Brightness = 1
                lighting.Ambient = Color3.fromRGB(255, 255, 255)
                lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                lighting.FogEnd = 100000
            else
                lighting.Brightness = oldBrightness
                lighting.Ambient = oldAmbient
                lighting.OutdoorAmbient = oldOutdoorAmbient
                lighting.FogEnd = oldFogEnd
            end
        end)

    elseif category == "OTHERS" then
        -- Teleport to Player
        local tpButton = Instance.new("TextButton")
        tpButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        tpButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 10 * scaleFactor)
        tpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tpButton.Text = "Teleport to Random Player"
        tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpButton.TextSize = 14 * scaleFactor
        tpButton.Parent = contentFrame

        tpButton.MouseButton1Click:Connect(function()
            local players = game.Players:GetPlayers()
            local target = players[math.random(1, #players)]
            if target ~= player and target.Character and player.Character then
                player.Character:MoveTo(target.Character.HumanoidRootPart.Position)
            end
        end)

    elseif category == "POWER" then
        -- God Mode
        local godButton = Instance.new("TextButton")
        godButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        godButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 10 * scaleFactor)
        godButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        godButton.Text = "Toggle God Mode"
        godButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        godButton.TextSize = 14 * scaleFactor
        godButton.Parent = contentFrame

        local godMode = false
        godButton.MouseButton1Click:Connect(function()
            godMode = not godMode
            godButton.Text = "Toggle God Mode (" .. (godMode and "ON" or "OFF") .. ")"
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.MaxHealth = godMode and math.huge or 100
                player.Character.Humanoid.Health = godMode and math.huge or 100
            end
        end)

        -- Noclip
        local noclipButton = Instance.new("TextButton")
        noclipButton.Size = UDim2.new(1, -20 * scaleFactor, 0, 40 * scaleFactor)
        noclipButton.Position = UDim2.new(0, 10 * scaleFactor, 0, 60 * scaleFactor)
        noclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        noclipButton.Text = "Toggle Noclip"
        noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        noclipButton.TextSize = 14 * scaleFactor
        noclipButton.Parent = contentFrame

        local noclipEnabled = false
        noclipButton.MouseButton1Click:Connect(function()
            noclipEnabled = not noclipEnabled
            noclipButton.Text = "Toggle Noclip (" .. (noclipEnabled and "ON" or "OFF") .. ")"
        end)

        -- Noclip logic
        runService.Stepped:Connect(function()
            if noclipEnabled and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end

-- Initial category load
loadCategoryContent("BASIC")

-- Toggle GUI with a keybind (F) or tap (mobile)
local lastTapTime = 0
local tapThreshold = 0.3

userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.F then
        guiEnabled = not guiEnabled
        mainFrame.Visible = guiEnabled
    elseif input.UserInputType == Enum.UserInputType.Touch then
        local currentTime = tick()
        if currentTime - lastTapTime < tapThreshold then
            guiEnabled = not guiEnabled
            mainFrame.Visible = guiEnabled
        end
        lastTapTime = currentTime
    end
end)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    guiEnabled = false
    mainFrame.Visible = false
end)

-- Make the GUI draggable (works on both PC and mobile)
local dragging = false
local dragInput
local dragStart
local startPos

titleBar.InputBegan:Connect(function(input)
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

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

userInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
