local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = nil
local MainFrame = nil
local Tabs = {}
local CurrentTab = nil
local UIVisible = true

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
    MainFrame.Size = UDim2.new(0, 420, 0, 340)
    MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 16)
    MainFrame.BorderSizePixel = 0

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = MainFrame

    local Stroke = Instance.new("UIStroke")
    Stroke.Parent = MainFrame
    Stroke.Color = Color3.fromRGB(80, 60, 200)
    Stroke.Thickness = 1
    Stroke.Transparency = 0.3

    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainFrame
    TitleBar.Size = UDim2.new(1, 0, 0, 32)
    TitleBar.BackgroundColor3 = Color3.fromRGB(16, 16, 28)
    TitleBar.BackgroundTransparency = 0.5
    TitleBar.BorderSizePixel = 0

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = TitleBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.Size = UDim2.new(1, -80, 1, 0)
    TitleLabel.Position = UDim2.new(0, 12, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "크로노스 허브 | Kronos Hub"
    TitleLabel.TextColor3 = Color3.fromRGB(180, 160, 255)
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.Code
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ToggleUIBtn = Instance.new("TextButton")
    ToggleUIBtn.Parent = TitleBar
    ToggleUIBtn.Size = UDim2.new(0, 22, 0, 22)
    ToggleUIBtn.Position = UDim2.new(1, -60, 0, 5)
    ToggleUIBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    ToggleUIBtn.BorderSizePixel = 0
    ToggleUIBtn.Text = "−"
    ToggleUIBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
    ToggleUIBtn.TextSize = 14
    ToggleUIBtn.Font = Enum.Font.Code
    ToggleUIBtn.AutoButtonColor = false

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 4)
    ToggleCorner.Parent = ToggleUIBtn

    ToggleUIBtn.MouseButton1Click:Connect(function()
        UIVisible = not UIVisible
        MainFrame.Visible = UIVisible
        ToggleUIBtn.Text = UIVisible and "−" or "+"
    end)

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TitleBar
    CloseBtn.Size = UDim2.new(0, 22, 0, 22)
    CloseBtn.Position = UDim2.new(1, -32, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 30)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.TextSize = 12
    CloseBtn.Font = Enum.Font.Code
    CloseBtn.AutoButtonColor = false

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseBtn

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = MainFrame
    Sidebar.Size = UDim2.new(0, 80, 1, -32)
    Sidebar.Position = UDim2.new(0, 0, 0, 32)
    Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
    Sidebar.BackgroundTransparency = 0.5
    Sidebar.BorderSizePixel = 0

    local Content = Instance.new("Frame")
    Content.Parent = MainFrame
    Content.Size = UDim2.new(1, -80, 1, -32)
    Content.Position = UDim2.new(0, 80, 0, 32)
    Content.BackgroundColor3 = Color3.fromRGB(8, 8, 16)
    Content.BackgroundTransparency = 0.2
    Content.BorderSizePixel = 0

    local TabData = {
        {Name = "Combat", Icon = "⚔"},
        {Name = "Player", Icon = "👤"},
        {Name = "Visual", Icon = "👁"},
        {Name = "Misc", Icon = "⚙"},
        {Name = "Settings", Icon = "🔧"},
    }

    for i, data in ipairs(TabData) do
        local Btn = Instance.new("TextButton")
        Btn.Parent = Sidebar
        Btn.Size = UDim2.new(1, -8, 0, 30)
        Btn.Position = UDim2.new(0, 4, 0, 4 + (i - 1) * 34)
        Btn.BackgroundColor3 = Color3.fromRGB(16, 16, 28)
        Btn.BackgroundTransparency = 0.8
        Btn.BorderSizePixel = 0
        Btn.Text = data.Icon .. " " .. data.Name
        Btn.TextColor3 = Color3.fromRGB(160, 160, 190)
        Btn.TextSize = 10
        Btn.Font = Enum.Font.Code
        Btn.AutoButtonColor = false

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 4)
        BtnCorner.Parent = Btn

        local ActiveBar = Instance.new("Frame")
        ActiveBar.Parent = Btn
        ActiveBar.Size = UDim2.new(0, 2, 1, -8)
        ActiveBar.Position = UDim2.new(0, 0, 0, 4)
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
        PanelLayout.Padding = UDim.new(0, 6)

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

    local function AddToggle(parent, text, default, callback)
        local Row = Instance.new("Frame", parent)
        Row.Size = UDim2.new(1, -6, 0, 20)
        Row.BackgroundTransparency = 1

        local Box = Instance.new("TextButton", Row)
        Box.Size = UDim2.new(0, 10, 0, 10)
        Box.Position = UDim2.new(0, 4, 0.5, -5)
        Box.BorderSizePixel = 1
        Box.BorderColor3 = Color3.fromRGB(60, 60, 80)
        Box.Text = ""
        Box.BackgroundColor3 = default and Color3.fromRGB(120, 80, 255) or Color3.fromRGB(14, 14, 20)

        local BoxCorner = Instance.new("UICorner")
        BoxCorner.CornerRadius = UDim.new(0, 2)
        BoxCorner.Parent = Box

        local Label = Instance.new("TextLabel", Row)
        Label.Size = UDim2.new(1, -20, 1, 0)
        Label.Position = UDim2.new(0, 18, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(170, 170, 200)
        Label.Font = Enum.Font.Code
        Label.TextSize = 10
        Label.TextXAlignment = Enum.TextXAlignment.Left

        local state = default

        Box.MouseButton1Click:Connect(function()
            state = not state
            Box.BackgroundColor3 = state and Color3.fromRGB(120, 80, 255) or Color3.fromRGB(14, 14, 20)
            if callback then callback(state) end
        end)

        return state
    end

    local function AddSlider(parent, text, min, max, default, callback)
        local SliderRow = Instance.new("Frame", parent)
        SliderRow.Size = UDim2.new(1, -6, 0, 28)
        SliderRow.BackgroundTransparency = 1

        local Label = Instance.new("TextLabel", SliderRow)
        Label.Size = UDim2.new(0.6, 0, 0, 14)
        Label.Position = UDim2.new(0, 4, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(170, 170, 200)
        Label.Font = Enum.Font.Code
        Label.TextSize = 10
        Label.TextXAlignment = Enum.TextXAlignment.Left

        local ValueLabel = Instance.new("TextLabel", SliderRow)
        ValueLabel.Size = UDim2.new(0.4, -10, 0, 14)
        ValueLabel.Position = UDim2.new(0.6, 0, 0, 0)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Text = default .. " / " .. max
        ValueLabel.TextColor3 = Color3.fromRGB(120, 80, 255)
        ValueLabel.Font = Enum.Font.Code
        ValueLabel.TextSize = 10
        ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

        local Track = Instance.new("TextButton", SliderRow)
        Track.Size = UDim2.new(1, -8, 0, 8)
        Track.Position = UDim2.new(0, 4, 0, 16)
        Track.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        Track.BorderSizePixel = 0
        Track.Text = ""

        local TrackCorner = Instance.new("UICorner")
        TrackCorner.CornerRadius = UDim.new(0, 4)
        TrackCorner.Parent = Track

        local Fill = Instance.new("Frame", Track)
        Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        Fill.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
        Fill.BorderSizePixel = 0

        local FillCorner = Instance.new("UICorner")
        FillCorner.CornerRadius = UDim.new(0, 4)
        FillCorner.Parent = Fill

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
        Section.Size = UDim2.new(1, -6, 0, 80)
        Section.BackgroundColor3 = Color3.fromRGB(14, 14, 24)
        Section.BorderSizePixel = 1
        Section.BorderColor3 = Color3.fromRGB(40, 40, 60)
        Section.BackgroundTransparency = 0.5

        local SecCorner = Instance.new("UICorner")
        SecCorner.CornerRadius = UDim.new(0, 6)
        SecCorner.Parent = Section

        local SecTitle = Instance.new("TextLabel")
        SecTitle.Parent = Section
        SecTitle.Size = UDim2.new(1, -10, 0, 18)
        SecTitle.Position = UDim2.new(0, 8, 0, 2)
        SecTitle.BackgroundTransparency = 1
        SecTitle.Text = title
        SecTitle.TextColor3 = Color3.fromRGB(120, 80, 255)
        SecTitle.TextSize = 11
        SecTitle.Font = Enum.Font.Code
        SecTitle.TextXAlignment = Enum.TextXAlignment.Left

        local SecContainer = Instance.new("Frame")
        SecContainer.Parent = Section
        SecContainer.Size = UDim2.new(1, -10, 1, -24)
        SecContainer.Position = UDim2.new(0, 5, 0, 20)
        SecContainer.BackgroundTransparency = 1

        local SecLayout = Instance.new("UIListLayout")
        SecLayout.Parent = SecContainer
        SecLayout.Padding = UDim.new(0, 2)

        return SecContainer
    end

    local function AddCombatTab()
        local panel = Tabs["Combat"].Panel

        local aimbotSection = AddSection(panel, "Aimbot")
        AddToggle(aimbotSection, "Aimbot", false, function(s) Settings.Aimbot = s end)
        AddToggle(aimbotSection, "Right Click Only", true, function(s) Settings.AimbotRightClick = s end)
        AddSlider(aimbotSection, "Smoothness", 0.1, 1, 0.5, function(s) Settings.AimbotSmooth = s end)

        local rageSection = AddSection(panel, "Rage")
        AddToggle(rageSection, "Rage Bot", false, function(s) Settings.RageBot = s end)

        local silentSection = AddSection(panel, "Silent Aim")
        AddToggle(silentSection, "Silent Aim", false, function(s) Settings.SilentAim = s end)
        AddToggle(silentSection, "Wallbang", false, function(s) Settings.Wallbang = s end)
        AddSlider(silentSection, "FOV", 10, 360, 180, function(s) Settings.SilentFOV = s end)

        local antiAimSection = AddSection(panel, "Animation Anti-Aim")
        AddToggle(antiAimSection, "Anti-Aim", false, function(s) Settings.AntiAim = s end)

        local scroll = panel
        if scroll and scroll:FindFirstChild("UIListLayout") then
            scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.UIListLayout.AbsoluteContentSize.Y + 20)
        end
    end

    local function AddPlayerTab()
        local panel = Tabs["Player"].Panel

        local movementSection = AddSection(panel, "Movement")
        AddToggle(movementSection, "WalkSpeed", false, function(s) Settings.Speed.Enabled = s end)
        AddSlider(movementSection, "Speed Value", 16, 500, 100, function(s) Settings.Speed.Value = s end)

        AddToggle(movementSection, "JumpPower", false, function(s) Settings.Jump.Enabled = s end)
        AddSlider(movementSection, "Jump Value", 50, 300, 100, function(s) Settings.Jump.Value = s end)

        AddToggle(movementSection, "Infinite Jump", false, function(s) Settings.InfiniteJump = s end)
        AddToggle(movementSection, "Noclip", false, function(s) Settings.Noclip = s end)

        local flySection = AddSection(panel, "Fly")
        AddToggle(flySection, "Fly", false, function(s) Settings.Fly.Enabled = s end)
        AddSlider(flySection, "Fly Speed", 10, 200, 50, function(s) Settings.Fly.Speed = s end)

        local scroll = panel
        if scroll and scroll:FindFirstChild("UIListLayout") then
            scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.UIListLayout.AbsoluteContentSize.Y + 20)
        end
    end

    AddCombatTab()
    AddPlayerTab()

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

    print("✅ Kronos Hub Loaded!")
end

CreateUI()
