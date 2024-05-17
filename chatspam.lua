local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local NumberBox = Instance.new("TextBox")
local TextButton = Instance.new("TextButton")
local Title = Instance.new("TextLabel")

-- ScreenGui setup
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.Name = "DraggableGui"

-- Draggable Frame setup
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.Size = UDim2.new(0, 250, 0, 150)
Frame.Position = UDim2.new(0.5, -125, 0.5, -75)
Frame.Active = true
Frame.Draggable = true

-- Title setup
Title.Parent = Frame
Title.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Title"

-- TextBox setup for text input
TextBox.Parent = Frame
TextBox.PlaceholderText = "Enter text here"
TextBox.Size = UDim2.new(0, 200, 0, 50)
TextBox.Position = UDim2.new(0.5, -100, 0.3, 0)

-- NumberBox setup for number input
NumberBox.Parent = Frame
NumberBox.PlaceholderText = "Enter number here (unused)"
NumberBox.Size = UDim2.new(0, 200, 0, 50)
NumberBox.Position = UDim2.new(0.5, -100, 0.5, 0)

-- TextButton setup
TextButton.Parent = Frame
TextButton.Text = "Chat Text"
TextButton.Size = UDim2.new(0, 100, 0, 50)
TextButton.Position = UDim2.new(0.5, -50, 0.7, 0)

-- Button click event
TextButton.MouseButton1Click:Connect(function()
    if TextBox.Text ~= "" and NumberBox.Text ~= "" then
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(TextBox.Text, "All")
    else
        warn("Both fields are required.")
    end
end)

-- Make the Frame draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

uis.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
