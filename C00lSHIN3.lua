-- Zo’s C00lShIn3 GUI for Alpha in Zeta
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Create RemoteEvent for Server-Side Chaos
local ChaosEvent = Instance.new("RemoteEvent")
ChaosEvent.Name = "ZetaChaosEvent"
ChaosEvent.Parent = ReplicatedStorage

-- GUI Setup (Reset-Proof)
local function setupGui()
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "C00lShIn3Gui"
    Gui.ResetOnSpawn = false -- Survives death like a badass!
    Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Cool Intro Shit
    local Intro = Instance.new("Frame")
    Intro.Size = UDim2.new(1, 0, 1, 0)
    Intro.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Intro.Parent = Gui
    local IntroText = Instance.new("TextLabel")
    IntroText.Size = UDim2.new(0.5, 0, 0.2, 0)
    IntroText.Position = UDim2.new(0.25, 0, 0.4, 0)
    IntroText.BackgroundTransparency = 1
    IntroText.Text = "C00lShIn3 GUI\nAlpha’s Zeta Reign"
    IntroText.TextColor3 = Color3.fromRGB(255, 0, 0)
    IntroText.TextSize = 30
    IntroText.Font = Enum.Font.SourceSansBold
    IntroText.TextStrokeTransparency = 0
    IntroText.Parent = Intro
    for i = 1, 10 do
        IntroText.TextTransparency = i / 10
        IntroText.TextStrokeTransparency = i / 10
        wait(0.1)
    end
    Intro:Destroy()

    -- GUI Frame Shit (Small for Mobile)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 150, 0, 200)
    Frame.Position = UDim2.new(0.5, -75, 0.5, -100)
    Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Frame.BorderSizePixel = 2
    Frame.Parent = Gui

    -- Minimize Button
    local Minimized = false
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.Position = UDim2.new(1, -25, 0, 5)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 14
    MinimizeButton.Parent = Frame

    -- Title Bar
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title.Text = "C00lShIn3 GUI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.SourceSansBold
    Title.Parent = Frame

    -- Rule Roblox Text
    local Footer = Instance.new("TextLabel")
    Footer.Size = UDim2.new(1, 0, 0, 20)
    Footer.Position = UDim2.new(0, 0, 1, -20)
    Footer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Footer.Text = "RULE ROBLOX"
    Footer.TextColor3 = Color3.fromRGB(255, 255, 255)
    Footer.TextSize = 12
    Footer.Font = Enum.Font.SourceSansBold
    Footer.Parent = Frame

    -- Scrolling Frame for Buttons
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -10, 1, -60)
    ScrollFrame.Position = UDim2.new(0, 5, 0, 35)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.ScrollBarThickness = 5
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500) -- Bigger for new features
    ScrollFrame.Parent = Frame

    -- Custom Notification System
    local function notify(message)
        local Notif = Instance.new("TextLabel")
        Notif.Size = UDim2.new(0, 100, 0, 30)
        Notif.Position = UDim2.new(0.5, -50, 0, 10)
        Notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Notif.Text = message
        Notif.TextColor3 = Color3.fromRGB(255, 0, 0)
        Notif.TextSize = 12
        Notif.TextWrapped = true
        Notif.Parent = Gui
        wait(3)
        Notif:Destroy()
    end

    -- FE Detection
    local function checkFE()
        local isFE = RunService:IsServer()
        if isFE then
            notify("Non-FE! Chaos is fucking on! 🌩️")
        else
            notify("FE on. Needs a backdoor, Alpha! ⚠️")
        end
    end
    checkFE()

    -- Cheat Button Function
    local function createButton(name, posY, func)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0.9, 0, 0, 40)
        Button.Position = UDim2.new(0.05, 0, 0, posY)
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Button.Text = name
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 14
        Button.Parent = ScrollFrame
        Button.MouseButton1Click:Connect(func)
    end

    -- Client-Side Cheat Triggers (Fires to Server)
    local function speedHack()
        ChaosEvent:FireServer("SpeedHack")
        notify("Zooming every fucker! 🏃‍♂️")
    end

    local function teleportAll()
        ChaosEvent:FireServer("TeleportAll", LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame)
        notify("All bitches in the sky! 🌌")
    end

    local function explodeEveryone()
        ChaosEvent:FireServer("ExplodeEveryone")
        notify("Boom, motherfuckers! 💥")
    end

    local function giveAllTools()
        ChaosEvent:FireServer("GiveAllTools")
        notify("Tools for all, you greedy shits! 🛠️")
    end

    local function destroyMap()
        ChaosEvent:FireServer("DestroyMap")
        notify("Map’s fucked to hell! 🏚️")
    end

    local function infiniteExplosions()
        ChaosEvent:FireServer("InfiniteExplosions")
        notify("Explosions everywhere, you chaotic fuck! 💣")
    end

    local function crashServer()
        ChaosEvent:FireServer("CrashServer")
        notify("Server’s getting fucked hard! 💀")
    end

    local spamActive = false
    local function spamCustomWords()
        if not spamActive then
            spamActive = true
            local TextBox = Instance.new("TextBox")
            TextBox.Size = UDim2.new(0.9, 0, 0, 40)
            TextBox.Position = UDim2.new(0.05, 0, 0, 450)
            TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            TextBox.Text = "Spam shit"
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14
            TextBox.Parent = ScrollFrame
            
            TextBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    local spamText = TextBox.Text
                    ChaosEvent:FireServer("SpamCustomWords", spamText)
                    notify("Spamming your fucked-up words! 📢")
                end
            end)
        else
            spamActive = false
            ChaosEvent:FireServer("StopSpam")
            notify("Spam’s off, you crazy bastard! 🛑")
        end
    end

    -- New Features
    local function rainFire()
        ChaosEvent:FireServer("RainFire")
        notify("Fire’s raining, you pyro fuck! 🔥")
    end

    local function freezeEveryone()
        ChaosEvent:FireServer("FreezeEveryone")
        notify("Everyone’s frozen, you icy bastard! ❄️")
    end

    local function cloneChaos()
        ChaosEvent:FireServer("CloneChaos")
        notify("Clones fucking everywhere! 👥")
    end

    -- Minimize Functionality
    MinimizeButton.MouseButton1Click:Connect(function()
        if not Minimized then
            Frame.Size = UDim2.new(0, 150, 0, 30)
            ScrollFrame.Visible = false
            Footer.Visible = false
            MinimizeButton.Text = "+"
            Minimized = true
        else
            Frame.Size = UDim2.new(0, 150, 0, 200)
            ScrollFrame.Visible = true
            Footer.Visible = true
            MinimizeButton.Text = "-"
            Minimized = false
        end
    end)

    -- Add Buttons to GUI (Including New Features)
    createButton("Speed Hack", 0, speedHack)
    createButton("Teleport All", 45, teleportAll)
    createButton("Explode Everyone", 90, explodeEveryone)
    createButton("Give All Tools", 135, giveAllTools)
    createButton("Destroy Map", 180, destroyMap)
    createButton("Infinite Explosions", 225, infiniteExplosions)
    createButton("Crash Server", 270, crashServer)
    createButton("Rain Fire", 315, rainFire)
    createButton("Freeze Everyone", 360, freezeEveryone)
    createButton("Clone Chaos", 405, cloneChaos)
    createButton("Spam Custom Words", 450, spamCustomWords)
end

-- Server-Side Handler (Needs Executor with Server Access)
if RunService:IsServer() then
    ChaosEvent.OnServerEvent:Connect(function(player, action, data)
        if action == "SpeedHack" then
            for _, p in pairs(Players:GetPlayers()) do
                local humanoid = p.Character and p.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 150
                end
            end
        elseif action == "TeleportAll" and data then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.CFrame = data * CFrame.new(math.random(-10, 10), 50, math.random(-10, 10))
                end
            end
        elseif action == "ExplodeEveryone" then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local explosion = Instance.new("Explosion")
                    explosion.Position = p.Character.HumanoidRootPart.Position
                    explosion.BlastRadius = 50
                    explosion.Parent = game.Workspace
                end
            end
        elseif action == "GiveAllTools" then
            for _, tool in pairs(ReplicatedStorage:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, p in pairs(Players:GetPlayers()) do
                        tool:Clone().Parent = p.Backpack
                    end
                end
            end
        elseif action == "DestroyMap" then
            for _, part in pairs(game.Workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part.Parent:FindFirstChild("Humanoid") then
                    part:Destroy()
                end
            end
        elseif action == "InfiniteExplosions" then
            spawn(function()
                for i = 1, 20 do
                    for _, p in pairs(Players:GetPlayers()) do
                        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            local explosion = Instance.new("Explosion")
                            explosion.Position = p.Character.HumanoidRootPart.Position + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
                            explosion.BlastRadius = 30
                            explosion.Parent = game.Workspace
                        end
                    end
                    wait(0.5)
                end
            end)
        elseif action == "CrashServer" then
            while true do
                for i = 1, 1000 do
                    Instance.new("Part", game.Workspace)
                end
                wait(0.1)
            end
        elseif action == "SpamCustomWords" and data then
            spawn(function()
                while true do
                    for _, p in pairs(Players:GetPlayers()) do
                        if p.Character and p.Character:FindFirstChild("Head") then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Size = UDim2.new(0, 100, 0, 30)
                            billboard.Adornee = p.Character.Head
                            billboard.StudsOffset = Vector3.new(0, 3, 0)
                            billboard.Parent = p.Character
                            local label = Instance.new("TextLabel")
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.BackgroundTransparency = 1
                            label.Text = data
                            label.TextColor3 = Color3.fromRGB(255, 0, 0)
                            label.TextSize = 16
                            label.Parent = billboard
                            wait(1)
                            billboard:Destroy()
                        end
                    end
                    wait(0.1)
                end
            end)
        elseif action == "StopSpam" then
            -- Still a limitation, no clean stop from client
        elseif action == "RainFire" then
            spawn(function()
                for i = 1, 30 do
                    for _, p in pairs(Players:GetPlayers()) do
                        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            local fire = Instance.new("Fire")
                            fire.Size = 10
                            fire.Parent = Instance.new("Part")
                            fire.Parent.Anchored = true
                            fire.Parent.Size = Vector3.new(5, 5, 5)
                            fire.Parent.Position = p.Character.HumanoidRootPart.Position + Vector3.new(math.random(-20, 20), 50, math.random(-20, 20))
                            fire.Parent.Parent = game.Workspace
                            wait(2)
                            fire.Parent:Destroy()
                        end
                    end
                    wait(0.3)
                end
            end)
        elseif action == "FreezeEveryone" then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character.HumanoidRootPart.Anchored = true
                    local ice = Instance.new("Part")
                    ice.Size = Vector3.new(5, 5, 5)
                    ice.Position = p.Character.HumanoidRootPart.Position
                    ice.Anchored = true
                    ice.Transparency = 0.5
                    ice.Color = Color3.fromRGB(0, 191, 255)
                    ice.Parent = game.Workspace
                    wait(5)
                    ice:Destroy()
                    p.Character.HumanoidRootPart.Anchored = false
                end
            end
        elseif action == "CloneChaos" then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    for i = 1, 5 do
                        local clone = p.Character:Clone()
                        clone.Parent = game.Workspace
                        clone.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(math.random(-10, 10), 0, math.random(-10, 10))
                        wait(10)
                        clone:Destroy()
                    end
                end
            end
        end
    end)
end

-- Initial GUI Setup
setupGui()

-- Rebuild GUI on Character Respawn
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    if not LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("C00lShIn3Gui") then
        setupGui()
    end
end)

print("C00lShIn3 GUI with new fucked-up features is live, Alpha! Rule that shit! 👑")
