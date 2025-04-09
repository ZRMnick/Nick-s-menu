-- SDT Mod Menu with Server-Side Name Change by Zo for Alpha in Zeta

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create Remote Events (if they don't exist)
local PlayAnimationEvent = ReplicatedStorage:FindFirstChild("PlayAnimationEvent")
if not PlayAnimationEvent then
    PlayAnimationEvent = Instance.new("RemoteEvent")
    PlayAnimationEvent.Name = "PlayAnimationEvent"
    PlayAnimationEvent.Parent = ReplicatedStorage
end

local ChangeNameEvent = ReplicatedStorage:FindFirstChild("ChangeNameEvent")
if not ChangeNameEvent then
    ChangeNameEvent = Instance.new("RemoteEvent")
    ChangeNameEvent.Name = "ChangeNameEvent"
    ChangeNameEvent.Parent = ReplicatedStorage
end

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SDTMenu"
ScreenGui.Parent = game.CoreGui or Player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "SDT Menu"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 25, 0, 25)
ToggleButton.Position = UDim2.new(1, -35, 0, 5)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton.Text = ">"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.TextSize = 16
ToggleButton.Parent = MainFrame

-- Menu 1: FE Change Name
local Menu1 = Instance.new("Frame")
Menu1.Size = UDim2.new(1, -10, 1, -40)
Menu1.Position = UDim2.new(0, 5, 0, 35)
Menu1.BackgroundTransparency = 1
Menu1.Parent = MainFrame
Menu1.Visible = true

local NameBox = Instance.new("TextBox")
NameBox.Size = UDim2.new(0.7, 0, 0, 30)
NameBox.Position = UDim2.new(0, 5, 0, 5)
NameBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NameBox.Text = "Enter New Name"
NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NameBox.Font = Enum.Font.Gotham
NameBox.TextSize = 14
NameBox.Parent = Menu1

local NameButton = Instance.new("TextButton")
NameButton.Size = UDim2.new(0.25, 0, 0, 30)
NameButton.Position = UDim2.new(0.75, 5, 0, 5)
NameButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
NameButton.Text = "Change"
NameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NameButton.Font = Enum.Font.Gotham
NameButton.TextSize = 14
NameButton.Parent = Menu1

-- Menu 2: Animation Sp00fer Main
local Menu2 = Instance.new("Frame")
Menu2.Size = UDim2.new(1, -10, 1, -40)
Menu2.Position = UDim2.new(0, 5, 0, 35)
Menu2.BackgroundTransparency = 1
Menu2.Parent = MainFrame
Menu2.Visible = false

local AnimBox = Instance.new("TextBox")
AnimBox.Size = UDim2.new(1, -10, 0, 50)
AnimBox.Position = UDim2.new(0, 5, 0, 5)
AnimBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AnimBox.Text = "Click Spoof to capture animation"
AnimBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AnimBox.Font = Enum.Font.Gotham
AnimBox.TextSize = 14
AnimBox.TextWrapped = true
AnimBox.Parent = Menu2

local SpoofButton = Instance.new("TextButton")
SpoofButton.Size = UDim2.new(0.3, 0, 0, 30)
SpoofButton.Position = UDim2.new(0, 5, 0, 60)
SpoofButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
SpoofButton.Text = "Spoof"
SpoofButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpoofButton.Font = Enum.Font.Gotham
SpoofButton.TextSize = 14
SpoofButton.Parent = Menu2

local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(0.3, 0, 0, 30)
CopyButton.Position = UDim2.new(0.35, 5, 0, 60)
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
CopyButton.Text = "Copy"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.Font = Enum.Font.Gotham
CopyButton.TextSize = 14
CopyButton.Parent = Menu2

local NextButton = Instance.new("TextButton")
NextButton.Size = UDim2.new(0.3, 0, 0, 30)
NextButton.Position = UDim2.new(0.7, 5, 0, 60)
NextButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
NextButton.Text = "Next"
NextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NextButton.Font = Enum.Font.Gotham
NextButton.TextSize = 14
NextButton.Parent = Menu2

-- Menu 3: Animation Player
local Menu3 = Instance.new("Frame")
Menu3.Size = UDim2.new(1, -10, 1, -40)
Menu3.Position = UDim2.new(0, 5, 0, 35)
Menu3.BackgroundTransparency = 1
Menu3.Parent = MainFrame
Menu3.Visible = false

local AnimInput = Instance.new("TextBox")
AnimInput.Size = UDim2.new(1, -10, 0, 50)
AnimInput.Position = UDim2.new(0, 5,/act 0, 5)
AnimInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AnimInput.Text = "Enter Animation ID (rbxassetid://)"
AnimInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AnimInput.Font = Enum.Font.Gotham
AnimInput.TextSize = 14
AnimInput.TextWrapped = true
AnimInput.Parent = Menu3

local AnimateButton = Instance.new("TextButton")
AnimateButton.Size = UDim2.new(0.3, 0, 0, 30)
AnimateButton.Position = UDim2.new(0, 5, 0, 60)
AnimateButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
AnimateButton.Text = "Animate"
AnimateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AnimateButton.Font = Enum.Font.Gotham
AnimateButton.TextSize = 14
AnimateButton.Parent = Menu3

local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(0.3, 0, 0, 30)
StopButton.Position = UDim2.new(0.35, 5, 0, 60)
StopButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
StopButton.Text = "Stop"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.Font = Enum.Font.Gotham
StopButton.TextSize = 14
StopButton.Parent = Menu3

local BackButton = Instance.new("TextButton")
BackButton.Size = UDim2.new(0.3, 0, 0, 30)
BackButton.Position = UDim2.new(0.7, 5, 0, 60)
BackButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
BackButton.Text = "Back"
BackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BackButton.Font = Enum.Font.Gotham
BackButton.TextSize = 14
BackButton.Parent = Menu3

-- Loading Animation
local LoadingLabel = Instance.new("TextLabel")
LoadingLabel.Size = UDim2.new(1, 0, 1, 0)
LoadingLabel.Position = UDim2.new(0, 0, 0, 0)
LoadingLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LoadingLabel.Text = "Loading..."
LoadingLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
LoadingLabel.Font = Enum.Font.Gotham
LoadingLabel.TextSize = 24
LoadingLabel.Parent = MainFrame
LoadingLabel.Visible = true

-- Tween Animations
local function tweenFade(object, property, value, time)
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, {[property] = value})
    tween:Play()
    return tween
end

-- Loading Sequence
tweenFade(LoadingLabel, "TextTransparency", 1, 1).Completed:Connect(function()
    LoadingLabel.Visible = false
end)

-- Toggle Menu Functionality
local currentMenu = 1
ToggleButton.MouseButton1Click:Connect(function()
    if currentMenu == 1 then
        tweenFade(Menu1, "Position", UDim2.new(-1, 5, 0, 35), 0.5).Completed:Connect(function()
            Menu1.Visible = false
            Menu2.Visible = true
            Menu2.Position = UDim2.new(1, 5, 0, 35)
            tweenFade(Menu2, "Position", UDim2.new(0, 5, 0, 35), 0.5)
        end)
        ToggleButton.Text = "<"
        Title.Text = "SDT Animation Sp00fer"
        currentMenu = 2
    else
        tweenFade(Menu2, "Position", UDim2.new(1, 5, 0, 35), 0.5).Completed:Connect(function()
            Menu2.Visible = false
            Menu1.Visible = true
            Menu1.Position = UDim2.new(-1, 5, 0, 35)
            tweenFade(Menu1, "Position", UDim2.new(0, 5, 0, 35), 0.5)
        end)
        ToggleButton.Text = ">"
        Title.Text = "SDT Menu"
        currentMenu = 1
    end
end)

-- Next Menu Transition (Menu2 to Menu3)
NextButton.MouseButton1Click:Connect(function()
    tweenFade(Menu2, "Position", UDim2.new(-1, 5, 0, 35), 0.5).Completed:Connect(function()
        Menu2.Visible = false
        Menu3.Visible = true
        Menu3.Position = UDim2.new(1, 5, 0, 35)
        tweenFade(Menu3, "Position", UDim2.new(0, 5, 0, 35), 0.5)
    end)
    Title.Text = "SDT Animation Player"
end)

-- Back Menu Transition (Menu3 to Menu2)
BackButton.MouseButton1Click:Connect(function()
    tweenFade(Menu3, "Position", UDim2.new(1, 5, 0, 35), 0.5).Completed:Connect(function()
        Menu3.Visible = false
        Menu2.Visible = true
        Menu2.Position = UDim2.new(-1, 5, 0, 35)
        tweenFade(Menu2, "Position", UDim2.new(0, 5, 0, 35), 0.5)
    end)
    Title.Text = "SDT Animation Sp00fer"
end)

-- FE Change Name Logic (Server-Side)
NameButton.MouseButton1Click:Connect(function()
    local newName = NameBox.Text
    if newName and newName ~= "" then
        ChangeNameEvent:FireServer(newName) -- Fire to server for replication
        tweenFade(NameButton, "BackgroundColor3", Color3.fromRGB(0, 255, 0), 0.3).Completed:Connect(function()
            tweenFade(NameButton, "BackgroundColor3", Color3.fromRGB(0, 200, 100), 0.3)
        end)
    end
end)

-- Animation Sp00fer Logic
local function getPlayingAnimation()
    for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
        if animTrack.IsPlaying then
            local animId = animTrack.Animation.AnimationId
            return "rbxassetid://" .. animId:match("%d+")
        end
    end
    return "No animation playing"
end

SpoofButton.MouseButton1Click:Connect(function()
    AnimBox.Text = getPlayingAnimation()
    tweenFade(SpoofButton, "BackgroundColor3", Color3.fromRGB(0, 255, 0), 0.3).Completed:Connect(function()
        tweenFade(SpoofButton, "BackgroundColor3", Color3.fromRGB(0, 200, 100), 0.3)
    end)
end)

-- Copy Button Logic
CopyButton.MouseButton1Click:Connect(function()
    if AnimBox.Text ~= "Click Spoof to capture animation" and AnimBox.Text ~= "No animation playing" then
        setclipboard(AnimBox.Text)
        tweenFade(CopyButton, "BackgroundColor3", Color3.fromRGB(0, 255, 255), 0.3).Completed:Connect(function()
            tweenFade(CopyButton, "BackgroundColor3", Color3.fromRGB(0, 150, 255), 0.3)
        end)
    end
end)

-- Animation Player Logic
AnimateButton.MouseButton1Click:Connect(function()
    local animId = AnimInput.Text:match("%d+")
    if animId then
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://" .. animId
        local animTrack = Humanoid:LoadAnimation(animation)
        animTrack:Play()
        -- Fire to server for others to see
        PlayAnimationEvent:FireServer(animId)
        tweenFade(AnimateButton, "BackgroundColor3", Color3.fromRGB(0, 255, 0), 0.3).Completed:Connect(function()
            tweenFade(AnimateButton, "BackgroundColor3", Color3.fromRGB(0, 200, 100), 0.3)
        end)
    end
end)

-- Stop Animation Logic
StopButton.MouseButton1Click:Connect(function()
    for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
        animTrack:Stop()
    end
    tweenFade(StopButton, "BackgroundColor3", Color3.fromRGB(255, 100, 100), 0.3).Completed:Connect(function()
        tweenFade(StopButton, "BackgroundColor3", Color3.fromRGB(255, 50, 50), 0.3)
    end)
end)

-- Character Respawn Handling
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
end)

-- Initial Frame Animation
tweenFade(MainFrame, "BackgroundTransparency", 0, 0.5)

-- Server-Side Script (to be executed separately)
local serverScript = [[
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local PlayAnimationEvent = ReplicatedStorage:WaitForChild("PlayAnimationEvent")
local ChangeNameEvent = ReplicatedStorage:WaitForChild("ChangeNameEvent")

-- Animation Event
PlayAnimationEvent.OnServerEvent:Connect(function(player, animId)
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://" .. animId
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
end)

-- Name Change Event
ChangeNameEvent.OnServerEvent:Connect(function(player, newName)
    local character = player.Character
    if character then
        local nameTag = character:FindFirstChild("CustomNameTag")
        if not nameTag then
            nameTag = Instance.new("StringValue")
            nameTag.Name = "CustomNameTag"
            nameTag.Parent = character
        end
        nameTag.Value = newName
        
        -- Update BillboardGui for visibility
        local head = character:FindFirstChild("Head")
        if head then
            local billboard = head:FindFirstChild("NameBillboard")
            if not billboard then
                billboard = Instance.new("BillboardGui")
                billboard.Name = "NameBillboard"
                billboard.Size = UDim2.new(0, 100, 0, 20)
                billboard.StudsOffset = Vector3.new(0, 2, 0)
                billboard.Adornee = head
                billboard.Parent = head
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.TextStrokeTransparency = 0
                label.Font = Enum.Font.GothamBold
                label.TextSize = 14
                label.Parent = billboard
            end
            billboard.Enabled = true
            billboard:FindFirstChild("TextLabel").Text = newName
        end
    end
end)
]]

print("Server script to execute separately:\n" .. serverScript)
