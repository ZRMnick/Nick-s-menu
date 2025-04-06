local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Wait for Character to load
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 10)
if not HumanoidRootPart then
    warn("Failed to find HumanoidRootPart. GUI may not function correctly.")
    return
end

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
ScreenGui.ResetOnSpawn = false
if not ScreenGui.Parent then
    warn("Failed to parent ScreenGui to PlayerGui. Aborting.")
    return
end

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.6, 0, 0.6, 0)
Frame.Position = UDim2.new(0.5, -Frame.Size.X.Offset/2, 0.5, -Frame.Size.Y.Offset/2)
Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Carnality GUI | V0.1 (DEV VERSION)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Title.Parent = Frame

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -30, 0, 0)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Parent = Frame

-- Features Frame (Category Buttons)
local FeaturesFrame = Instance.new("Frame")
FeaturesFrame.Size = UDim2.new(0.4, 0, 1, -40)
FeaturesFrame.Position = UDim2.new(0, 5, 0, 35)
FeaturesFrame.BackgroundTransparency = 1
FeaturesFrame.Parent = Frame

-- Content Frame (Right Side for Category Content)
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(0.55, 0, 1, -40)
ContentFrame.Position = UDim2.new(0.45, 0, 0, 35)
ContentFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ContentFrame.Visible = false
ContentFrame.Parent = Frame

-- Function to clear ContentFrame before loading new content
local function clearContentFrame()
    local success, err = pcall(function()
        for _, child in pairs(ContentFrame:GetChildren()) do
            child:Destroy()
        end
    end)
    if not success then
        warn("Failed to clear ContentFrame: " .. tostring(err))
        ContentFrame.Visible = false -- Fallback: hide ContentFrame if clearing fails
    end
end

-- Add Button Function (For Categories)
local function addButton(text, posY, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 25)
    Button.Position = UDim2.new(0, 0, 0, posY)
    Button.Text = text
    Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    Button.Parent = FeaturesFrame
    Button.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            clearContentFrame() -- Clear previous content
            callback()
        end)
        if not success then
            warn("Failed to load category '" .. text .. "': " .. tostring(err))
            ContentFrame.Visible = false -- Hide ContentFrame on failure
        end
    end)
end

-- Category: Credits (Default on Load)
addButton("Credits", 0, function()
    ContentFrame.Visible = true

    local CreditsContent = Instance.new("Frame")
    CreditsContent.Size = UDim2.new(1, 0, 1, 0)
    CreditsContent.BackgroundTransparency = 1
    CreditsContent.Parent = ContentFrame

    local CreditsText = Instance.new("TextLabel")
    CreditsText.Size = UDim2.new(1, 0, 1, 0)
    CreditsText.Position = UDim2.new(0, 0, 0, 0)
    CreditsText.Text = "Scripted by: C00lShIn3\nDiscord: discord.gg/82hMwkxaA7\nYouTube: youtube.com/@E.xposure"
    CreditsText.TextColor3 = Color3.fromRGB(255, 255, 255)
    CreditsText.BackgroundTransparency = 1
    CreditsText.TextScaled = true
    CreditsText.Parent = CreditsContent

    print("Credits category loaded.")
end)

-- Category: Code Executor
addButton("Code Executor", 30, function()
    ContentFrame.Visible = true

    local CodeContent = Instance.new("Frame")
    CodeContent.Size = UDim2.new(1, 0, 1, 0)
    CodeContent.BackgroundTransparency = 1
    CodeContent.Parent = ContentFrame

    local CodeTitle = Instance.new("TextLabel")
    CodeTitle.Size = UDim2.new(1, 0, 0, 30)
    CodeTitle.Text = "Code Executor"
    CodeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    CodeTitle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    CodeTitle.Parent = CodeContent

    local CodeBox = Instance.new("TextBox")
    CodeBox.Size = UDim2.new(0.9, 0, 0, 80)
    CodeBox.Position = UDim2.new(0.05, 0, 0, 40)
    CodeBox.Text = "Put code here..."
    CodeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    CodeBox.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    CodeBox.TextScaled = true
    CodeBox.TextWrapped = true
    CodeBox.ClearTextOnFocus = true
    CodeBox.Parent = CodeContent

    local ExecuteButton = Instance.new("TextButton")
    ExecuteButton.Size = UDim2.new(0.9, 0, 0, 25)
    ExecuteButton.Position = UDim2.new(0.05, 0, 0, 130)
    ExecuteButton.Text = "Execute"
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.Parent = CodeContent

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    StatusLabel.Position = UDim2.new(0.05, 0, 0, 160)
    StatusLabel.Text = "Status: Idle"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.TextScaled = true
    StatusLabel.Parent = CodeContent

    ExecuteButton.MouseButton1Click:Connect(function()
        local code = CodeBox.Text
        local func, err = loadstring(code)
        if func then
            local success, runErr = pcall(function()
                func()
                StatusLabel.Text = "Status: Executed code!"
                print("Code executed successfully.")
            end)
            if not success then
                StatusLabel.Text = "Status: Error - " .. tostring(runErr)
                warn("Code execution failed: " .. tostring(runErr))
            end
        else
            StatusLabel.Text = "Status: Invalid code - " .. tostring(err)
            warn("Invalid code: " .. tostring(err))
        end
    end)

    print("Code Executor category loaded.")
end)

-- Category: Hacks
addButton("Hacks", 60, function() -- Adjusted position since Require Executor is removed
    ContentFrame.Visible = true

    local HacksContent = Instance.new("Frame")
    HacksContent.Size = UDim2.new(1, 0, 1, 0)
    HacksContent.BackgroundTransparency = 1
    HacksContent.Parent = ContentFrame

    local HacksTitle = Instance.new("TextLabel")
    HacksTitle.Size = UDim2.new(1, 0, 0, 30)
    HacksTitle.Text = "Hacks"
    HacksTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    HacksTitle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    HacksTitle.Parent = HacksContent

    -- Add Hack Buttons Function (For Hacks Category)
    local function addHackButton(text, posY, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0.9, 0, 0, 25)
        Button.Position = UDim2.new(0.05, 0, 0, posY)
        Button.Text = text
        Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextScaled = true
        Button.Parent = HacksContent
        Button.MouseButton1Click:Connect(callback)
    end

    -- Hack 1: Speed Hack
    addHackButton("Speed Hack", 35, function()
        local humanoid = Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = humanoid.WalkSpeed == 16 and 32 or 16
            print(humanoid.WalkSpeed == 32 and "Speed boosted, Alpha! 🏃‍♂️" or "Speed reset, Alpha! 🚶")
        else
            warn("Speed Hack failed: Humanoid not found.")
        end
    end)

    -- Hack 2: Teleport Random
    addHackButton("Teleport Random", 65, function()
        local players = Players:GetPlayers()
        local target = players[math.random(1, #players)]
        if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
            print("Teleported to " .. target.Name .. ", Alpha! 🌌")
        else
            warn("Teleport Random failed: No valid target found.")
        end
    end)

    -- Hack 3: Invisibility
    local invisible = false
    addHackButton("Invisibility", 95, function()
        invisible = not invisible
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = invisible and 1 or 0
            end
        end
        print(invisible and "You’re a ghost, Alpha! 👻" or "Visible again, Alpha! 😎")
    end)

    -- Hack 4: Steal Tool
    addHackButton("Steal Tool", 125, function()
        local target = Players:GetPlayers()[math.random(2, #Players:GetPlayers())]
        if target and target.Character and target.Backpack then
            for _, tool in pairs(target.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool:Clone().Parent = LocalPlayer.Backpack
                    print("Stole " .. tool.Name .. " from " .. target.Name .. ", Alpha! 🕵️")
                    break
                end
            end
        else
            warn("Steal Tool failed: No valid target or tools found.")
        end
    end)

    -- Hack 5: ESP
    local espEnabled = false
    local espConnections = {}
    addHackButton("ESP", 155, function()
        espEnabled = not espEnabled
        if espEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = player.Character
                    espConnections[player] = highlight
                end
            end
            print("ESP activated, Alpha! 👀")
        else
            for _, connection in pairs(espConnections) do
                connection:Destroy()
            end
            espConnections = {}
            print("ESP deactivated, Alpha! 🕶️")
        end
    end)

    -- Hack 6: Fly
    local flying = false
    local flyConnection
    addHackButton("Fly", 185, function()
        flying = not flying
        local humanoid = Character:FindFirstChild("Humanoid")
        local rootPart = HumanoidRootPart
        if flying and humanoid and rootPart then
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = rootPart
            if flyConnection then flyConnection:Disconnect() end
            flyConnection = RunService.RenderStepped:Connect(function()
                if not flying then return end
                local cam = workspace.CurrentCamera
                local moveDir = Vector3.new(
                    (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                    (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0),
                    (UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0)
                ).Unit * 50
                bv.Velocity = cam.CFrame:VectorToWorldSpace(moveDir)
                rootPart.CFrame = CFrame.new(rootPart.Position) * cam.CFrame.Rotation
            end)
            print("Flying high, Alpha! ✈️")
        else
            if flyConnection then flyConnection:Disconnect() end
            if rootPart and rootPart:FindFirstChild("BodyVelocity") then
                rootPart:FindFirstChild("BodyVelocity"):Destroy()
            end
            if humanoid then
                humanoid.WalkSpeed = 16
                humanoid.JumpPower = 50
            end
            print("Landed, Alpha! 🌍")
        end
    end)

    print("Hacks category loaded.")
end)

-- Minimize Logic
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Frame.Size = UDim2.new(0.6, 0, 0, 30)
        FeaturesFrame.Visible = false
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
        print("GUI minimized.")
    else
        Frame.Size = UDim2.new(0.6, 0, 0.6, 0)
        FeaturesFrame.Visible = true
        MinimizeButton.Text = "-"
        -- Reopen Credits by default when expanding
        if not ContentFrame.Visible then
            clearContentFrame()
            local creditsButton = FeaturesFrame:GetChildren()[1] -- First button (Credits)
            creditsButton:FindFirstChildWhichIsA("TextButton").MouseButton1Click:Invoke()
        end
        print("GUI expanded.")
    end)
end)

-- ESP Player Handling
Players.PlayerAdded:Connect(function(player)
    if espEnabled and player ~= LocalPlayer then
        player.CharacterAdded:Connect(function(char)
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Parent = char
            espConnections[player] = highlight
        end)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if espConnections[player] then
        espConnections[player]:Destroy()
        espConnections[player] = nil
    end
end)

-- Character Respawn Handling
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart", 10)
    if not HumanoidRootPart then
        warn("Failed to find HumanoidRootPart on respawn.")
        return
    end

    if invisible then
        for _, part in pairs(newChar:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    end

    if flying then
        local humanoid = newChar:FindFirstChild("Humanoid")
        local rootPart = HumanoidRootPart
        if humanoid and rootPart then
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = rootPart
            if flyConnection then flyConnection:Disconnect() end
            flyConnection = RunService.RenderStepped:Connect(function()
                if not flying then return end
                local cam = workspace.CurrentCamera
                local moveDir = Vector3.new(
                    (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                    (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0),
                    (UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0)
                ).Unit * 50
                bv.Velocity = cam.CFrame:VectorToWorldSpace(moveDir)
                rootPart.CFrame = CFrame.new(rootPart.Position) * cam.CFrame.Rotation
            end)
        end
    end

    print("Character respawned and state updated.")
end)

-- Automatically open Credits category on load
local success, err = pcall(function()
    for _, child in pairs(FeaturesFrame:GetChildren()) do
        if child:IsA("TextButton") and child.Text == "Credits" then
            child.MouseButton1Click:Invoke()
            break
        end
    end
end)
if not success then
    warn("Failed to open Credits category on load: " .. tostring(err))
end

print("Carnality GUI loaded, Alpha! Require Executor removed—ready to roll! 🔴✨")
