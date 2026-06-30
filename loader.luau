local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = nil
local MainFrame = nil
local Tabs = {}
local CurrentTab = nil

local Settings = {
    Speed = {Enabled = false, Value = 100},
    Jump = {Enabled = false, Value = 100},
    InfiniteJump = false,
    Noclip = false,
    Fly = {Enabled = false, Speed = 50},
    RageBot = false,
    SilentAim = false,
    AutoQueue = false,
    QueueMode = "1v1",
}

local function CreateUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KronosHub"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    ScreenGui.ResetOnSpawn = false

    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 550, 0, 440)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    MainFrame.BorderSizePixel = 0

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = MainFrame

    local Stroke = Instance.new("UIStroke")
    Stroke.Parent = MainFrame
    Stroke.Color = Color3.fromRGB(120, 80, 255)
    Stroke.Thickness = 1
    Stroke.Transparency = 0.5

    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainFrame
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    TitleBar.BackgroundTransparency = 0.5
    TitleBar.BorderSizePixel = 0

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = TitleBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "크로노스 허브 | Kronos Hub"
    TitleLabel.TextColor3 = Color3.fromRGB(200, 180, 255)
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.Code
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TitleBar
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -38, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 40)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseBtn.TextSize = 16
    CloseBtn.Font = Enum.Font.Code
    CloseBtn.AutoButtonColor = false

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 5)
    CloseCorner.Parent = CloseBtn

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = MainFrame
    Sidebar.Size = UDim2.new(0, 100, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
    Sidebar.BackgroundTransparency = 0.5
    Sidebar.BorderSizePixel = 0

    local Content = Instance.new("Frame")
    Content.Parent = MainFrame
    Content.Size = UDim2.new(1, -100, 1, -40)
    Content.Position = UDim2.new(0, 100, 0, 40)
    Content.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    Content.BackgroundTransparency = 0.2
    Content.BorderSizePixel = 0

    local TabData = {
        {Name = "Combat", Icon = "⚔️"},
        {Name = "Player", Icon = "👤"},
        {Name = "Visual", Icon = "👁️"},
        {Name = "Misc", Icon = "⚙️"},
        {Name = "Settings", Icon = "🔧"},
    }

    for i, data in ipairs(TabData) do
        local Btn = Instance.new("TextButton")
        Btn.Parent = Sidebar
        Btn.Size = UDim2.new(1, -10, 0, 35)
        Btn.Position = UDim2.new(0, 5, 0, 5 + (i - 1) * 40)
        Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        Btn.BackgroundTransparency = 0.8
        Btn.BorderSizePixel = 0
        Btn.Text = data.Icon .. " " .. data.Name
        Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
        Btn.TextSize = 12
        Btn.Font = Enum.Font.Code
        Btn.AutoButtonColor = false

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 5)
        BtnCorner.Parent = Btn

        local ActiveBar = Instance.new("Frame")
        ActiveBar.Parent = Btn
        ActiveBar.Size = UDim2.new(0, 3, 1, -10)
        ActiveBar.Position = UDim2.new(0, 0, 0, 5)
        ActiveBar.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
        ActiveBar.BackgroundTransparency = 1
        ActiveBar.BorderSizePixel = 0

        local ActiveCorner = Instance.new("UICorner")
        ActiveCorner.CornerRadius = UDim.new(0, 2)
        ActiveCorner.Parent = ActiveBar

        local Panel = Instance.new("ScrollingFrame")
        Panel.Parent = Content
        Panel.Size = UDim2.new(1, 0, 1, 0)
        Panel.BackgroundTransparency = 1
        Panel.BorderSizePixel = 0
        Panel.Visible = false
        Panel.ScrollBarThickness = 2
        Panel.CanvasSize = UDim2.new(0, 0, 0, 0)

        local PanelLayout = Instance.new("UIListLayout")
        PanelLayout.Parent = Panel
        PanelLayout.Padding = UDim.new(0, 8)

        Tabs[data.Name] = {
            Button = Btn,
            ActiveBar = ActiveBar,
            Panel = Panel,
            Layout = PanelLayout,
        }

        Btn.MouseButton1Click:Connect(function()
            for _, tab in pairs(Tabs) do
                tab.Panel.Visible = false
                tab.ActiveBar.BackgroundTransparency = 1
                tab.Button.BackgroundTransparency = 0.8
            end
            Panel.Visible = true
            ActiveBar.BackgroundTransparency = 0
            Btn.BackgroundTransparency = 0.5
            CurrentTab = data.Name
        end)
    end

    if Tabs["Combat"] then
        Tabs["Combat"].Panel.Visible = true
        Tabs["Combat"].ActiveBar.BackgroundTransparency = 0
        Tabs["Combat"].Button.BackgroundTransparency = 0.5
        CurrentTab = "Combat"
    end

    local Dragging = false
    local DragStart = nil
    local FrameStart = nil

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = input.Position
            FrameStart = MainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local Delta = input.Position - DragStart
            MainFrame.Position = UDim2.new(
                FrameStart.X.Scale,
                FrameStart.X.Offset + Delta.X,
                FrameStart.Y.Scale,
                FrameStart.Y.Offset + Delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)

    local function AddToggle(parent, text, default, callback)
        local Row = Instance.new("Frame", parent)
        Row.Size = UDim2.new(1, -10, 0, 22)
        Row.BackgroundTransparency = 1

        local Box = Instance.new("TextButton", Row)
        Box.Size = UDim2.new(0, 12, 0, 12)
        Box.Position = UDim2.new(0, 5, 0.5, -6)
        Box.BorderSizePixel = 1
        Box.BorderColor3 = Color3.fromRGB(60, 60, 60)
        Box.Text = ""
        Box.BackgroundColor3 = default and Color3.fromRGB(120, 80, 255) or Color3.fromRGB(14, 14, 14)

        local Label = Instance.new("TextLabel", Row)
        Label.Size = UDim2.new(1, -25, 1, 0)
        Label.Position = UDim2.new(0, 22, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(180, 180, 180)
        Label.Font = Enum.Font.Code
        Label.TextSize = 11
        Label.TextXAlignment = Enum.TextXAlignment.Left

        local state = default

        Box.MouseButton1Click:Connect(function()
            state = not state
            Box.BackgroundColor3 = state and Color3.fromRGB(120, 80, 255) or Color3.fromRGB(14, 14, 14)
            if callback then callback(state) end
        end)

        return state
    end

    local function AddSlider(parent, text, min, max, default, callback)
        local SliderRow = Instance.new("Frame", parent)
        SliderRow.Size = UDim2.new(1, -10, 0, 32)
        SliderRow.BackgroundTransparency = 1

        local Label = Instance.new("TextLabel", SliderRow)
        Label.Size = UDim2.new(1, 0, 0, 14)
        Label.Position = UDim2.new(0, 5, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(180, 180, 180)
        Label.Font = Enum.Font.Code
        Label.TextSize = 11
        Label.TextXAlignment = Enum.TextXAlignment.Left

        local ValueLabel = Instance.new("TextLabel", SliderRow)
        ValueLabel.Size = UDim2.new(1, -10, 0, 14)
        ValueLabel.Position = UDim2.new(0, 0, 0, 0)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Text = default .. " / " .. max
        ValueLabel.TextColor3 = Color3.fromRGB(120, 80, 255)
        ValueLabel.Font = Enum.Font.Code
        ValueLabel.TextSize = 11
        ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

        local Track = Instance.new("TextButton", SliderRow)
        Track.Size = UDim2.new(1, -10, 0, 10)
        Track.Position = UDim2.new(0, 5, 0, 16)
        Track.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Track.BorderSizePixel = 1
        Track.BorderColor3 = Color3.fromRGB(40, 40, 40)
        Track.Text = ""

        local Fill = Instance.new("Frame", Track)
        Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        Fill.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
        Fill.BorderSizePixel = 0

        local function SetValue(input)
            local l = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
            Fill.Size = UDim2.new(l, 0, 1, 0)
            local val = math.floor(min + (max - min) * l)
            ValueLabel.Text = val .. " / " .. max
            callback(val)
        end

        local IsDragging = false

        Track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                IsDragging = true
                SetValue(input)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if IsDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                SetValue(input)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                IsDragging = false
            end
        end)

        return callback
    end

    local function AddSection(parent, title)
        local Section = Instance.new("Frame", parent)
        Section.Size = UDim2.new(1, -10, 0, 100)
        Section.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
        Section.BorderSizePixel = 1
        Section.BorderColor3 = Color3.fromRGB(40, 40, 50)
        Section.BackgroundTransparency = 0.5

        local SecCorner = Instance.new("UICorner")
        SecCorner.CornerRadius = UDim.new(0, 6)
        SecCorner.Parent = Section

        local SecTitle = Instance.new("TextLabel")
        SecTitle.Parent = Section
        SecTitle.Size = UDim2.new(1, -10, 0, 20)
        SecTitle.Position = UDim2.new(0, 8, 0, 2)
        SecTitle.BackgroundTransparency = 1
        SecTitle.Text = title
        SecTitle.TextColor3 = Color3.fromRGB(120, 80, 255)
        SecTitle.TextSize = 12
        SecTitle.Font = Enum.Font.Code
        SecTitle.TextXAlignment = Enum.TextXAlignment.Left

        local SecContainer = Instance.new("Frame")
        SecContainer.Parent = Section
        SecContainer.Size = UDim2.new(1, -10, 1, -25)
        SecContainer.Position = UDim2.new(0, 5, 0, 22)
        SecContainer.BackgroundTransparency = 1

        local SecLayout = Instance.new("UIListLayout")
        SecLayout.Parent = SecContainer
        SecLayout.Padding = UDim.new(0, 2)

        return SecContainer
    end

    for _, tab in pairs(Tabs) do
        local Section = AddSection(tab.Panel, "Section")
    end

    print("✅ Kronos Hub UI Loaded!")
end

CreateUI()
