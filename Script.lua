-- MANscript Hub | Пустое меню 350x200 (только интерфейс)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Цвета
local colors = {
    bg = Color3.fromRGB(18, 18, 22),
    card = Color3.fromRGB(28, 28, 35),
    accent = Color3.fromRGB(70, 70, 90),
    green = Color3.fromRGB(0, 200, 100),
    red = Color3.fromRGB(200, 50, 50),
    text = Color3.fromRGB(240, 240, 240),
    textDim = Color3.fromRGB(160, 160, 170),
    tabActive = Color3.fromRGB(120, 50, 200),
    tabInactive = Color3.fromRGB(40, 40, 55)
}

local function animate(obj, props, dur)
    local tween = TweenService:Create(obj, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

-- Очистка старых GUI
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "MANscriptMenu" then
        v:Destroy()
    end
end

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MANscriptMenu"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 200)
mainFrame.Position = UDim2.new(0, 10, 0, 60)
mainFrame.BackgroundColor3 = colors.bg
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = colors.card
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -90, 1, 0)
titleText.Position = UDim2.new(0, 12, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "MANscript Hub"
titleText.TextColor3 = colors.text
titleText.TextSize = 15
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Font = Enum.Font.GothamBold
titleText.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -38, 0, 6)
closeBtn.BackgroundColor3 = colors.accent
closeBtn.Text = "−"
closeBtn.TextColor3 = colors.text
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

-- Вкладки
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(1, 0, 0, 35)
tabsFrame.Position = UDim2.new(0, 0, 0, 40)
tabsFrame.BackgroundTransparency = 1
tabsFrame.Parent = mainFrame

local tab1 = Instance.new("TextButton")
tab1.Size = UDim2.new(0.25, 0, 1, 0)
tab1.Position = UDim2.new(0, 0, 0, 0)
tab1.BackgroundColor3 = colors.tabActive
tab1.Text = "📊 Меню"
tab1.TextColor3 = colors.text
tab1.TextSize = 11
tab1.Font = Enum.Font.GothamBold
tab1.BorderSizePixel = 0
tab1.Parent = tabsFrame

local tab2 = Instance.new("TextButton")
tab2.Size = UDim2.new(0.25, 0, 1, 0)
tab2.Position = UDim2.new(0.25, 0, 0, 0)
tab2.BackgroundColor3 = colors.tabInactive
tab2.Text = "🎮 Скрипты"
tab2.TextColor3 = colors.text
tab2.TextSize = 11
tab2.Font = Enum.Font.GothamBold
tab2.BorderSizePixel = 0
tab2.Parent = tabsFrame

local tab3 = Instance.new("TextButton")
tab3.Size = UDim2.new(0.25, 0, 1, 0)
tab3.Position = UDim2.new(0.5, 0, 0, 0)
tab3.BackgroundColor3 = colors.tabInactive
tab3.Text = "⚙️ Настройки"
tab3.TextColor3 = colors.text
tab3.TextSize = 11
tab3.Font = Enum.Font.GothamBold
tab3.BorderSizePixel = 0
tab3.Parent = tabsFrame

local tab4 = Instance.new("TextButton")
tab4.Size = UDim2.new(0.25, 0, 1, 0)
tab4.Position = UDim2.new(0.75, 0, 0, 0)
tab4.BackgroundColor3 = colors.tabInactive
tab4.Text = "🎨 Тема"
tab4.TextColor3 = colors.text
tab4.TextSize = 11
tab4.Font = Enum.Font.GothamBold
tab4.BorderSizePixel = 0
tab4.Parent = tabsFrame

-- Контент
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -90)
contentFrame.Position = UDim2.new(0, 10, 0, 80)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Вкладка 1 (Меню)
local tab1Content = Instance.new("ScrollingFrame")
tab1Content.Size = UDim2.new(1, 0, 1, 0)
tab1Content.BackgroundTransparency = 1
tab1Content.ScrollBarThickness = 3
tab1Content.Visible = true
tab1Content.Parent = contentFrame

local placeholder1 = Instance.new("TextLabel")
placeholder1.Size = UDim2.new(1, 0, 0, 40)
placeholder1.BackgroundColor3 = colors.card
placeholder1.BackgroundTransparency = 0.3
placeholder1.Text = "📊 Здесь будет статистика"
placeholder1.TextColor3 = colors.textDim
placeholder1.TextSize = 11
placeholder1.Font = Enum.Font.Gotham
placeholder1.Parent = tab1Content

local corner1 = Instance.new("UICorner")
corner1.CornerRadius = UDim.new(0, 8)
corner1.Parent = placeholder1

-- Вкладка 2 (Скрипты)
local tab2Content = Instance.new("ScrollingFrame")
tab2Content.Size = UDim2.new(1, 0, 1, 0)
tab2Content.BackgroundTransparency = 1
tab2Content.ScrollBarThickness = 3
tab2Content.Visible = false
tab2Content.Parent = contentFrame

local placeholder2 = Instance.new("TextLabel")
placeholder2.Size = UDim2.new(1, 0, 0, 40)
placeholder2.BackgroundColor3 = colors.card
placeholder2.BackgroundTransparency = 0.3
placeholder2.Text = "🎮 Здесь будут скрипты"
placeholder2.TextColor3 = colors.textDim
placeholder2.TextSize = 11
placeholder2.Font = Enum.Font.Gotham
placeholder2.Parent = tab2Content

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 8)
corner2.Parent = placeholder2

-- Вкладка 3 (Настройки)
local tab3Content = Instance.new("ScrollingFrame")
tab3Content.Size = UDim2.new(1, 0, 1, 0)
tab3Content.BackgroundTransparency = 1
tab3Content.ScrollBarThickness = 3
tab3Content.Visible = false
tab3Content.Parent = contentFrame

local placeholder3 = Instance.new("TextLabel")
placeholder3.Size = UDim2.new(1, 0, 0, 40)
placeholder3.BackgroundColor3 = colors.card
placeholder3.BackgroundTransparency = 0.3
placeholder3.Text = "⚙️ Здесь будут настройки"
placeholder3.TextColor3 = colors.textDim
placeholder3.TextSize = 11
placeholder3.Font = Enum.Font.Gotham
placeholder3.Parent = tab3Content

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0, 8)
corner3.Parent = placeholder3

-- Вкладка 4 (Тема)
local tab4Content = Instance.new("ScrollingFrame")
tab4Content.Size = UDim2.new(1, 0, 1, 0)
tab4Content.BackgroundTransparency = 1
tab4Content.ScrollBarThickness = 3
tab4Content.Visible = false
tab4Content.Parent = contentFrame

local placeholder4 = Instance.new("TextLabel")
placeholder4.Size = UDim2.new(1, 0, 0, 40)
placeholder4.BackgroundColor3 = colors.card
placeholder4.BackgroundTransparency = 0.3
placeholder4.Text = "🎨 Здесь будут темы"
placeholder4.TextColor3 = colors.textDim
placeholder4.TextSize = 11
placeholder4.Font = Enum.Font.Gotham
placeholder4.Parent = tab4Content

local corner4 = Instance.new("UICorner")
corner4.CornerRadius = UDim.new(0, 8)
corner4.Parent = placeholder4

-- Переключение вкладок
local function switchTab(tab)
    if tab == 1 then
        tab1Content.Visible = true
        tab2Content.Visible = false
        tab3Content.Visible = false
        tab4Content.Visible = false
        tab1.BackgroundColor3 = colors.tabActive
        tab2.BackgroundColor3 = colors.tabInactive
        tab3.BackgroundColor3 = colors.tabInactive
        tab4.BackgroundColor3 = colors.tabInactive
    elseif tab == 2 then
        tab1Content.Visible = false
        tab2Content.Visible = true
        tab3Content.Visible = false
        tab4Content.Visible = false
        tab1.BackgroundColor3 = colors.tabInactive
        tab2.BackgroundColor3 = colors.tabActive
        tab3.BackgroundColor3 = colors.tabInactive
        tab4.BackgroundColor3 = colors.tabInactive
    elseif tab == 3 then
        tab1Content.Visible = false
        tab2Content.Visible = false
        tab3Content.Visible = true
        tab4Content.Visible = false
        tab1.BackgroundColor3 = colors.tabInactive
        tab2.BackgroundColor3 = colors.tabInactive
        tab3.BackgroundColor3 = colors.tabActive
        tab4.BackgroundColor3 = colors.tabInactive
    elseif tab == 4 then
        tab1Content.Visible = false
        tab2Content.Visible = false
        tab3Content.Visible = false
        tab4Content.Visible = true
        tab1.BackgroundColor3 = colors.tabInactive
        tab2.BackgroundColor3 = colors.tabInactive
        tab3.BackgroundColor3 = colors.tabInactive
        tab4.BackgroundColor3 = colors.tabActive
    end
end

tab1.MouseButton1Click:Connect(function() switchTab(1) end)
tab2.MouseButton1Click:Connect(function() switchTab(2) end)
tab3.MouseButton1Click:Connect(function() switchTab(3) end)
tab4.MouseButton1Click:Connect(function() switchTab(4) end)

-- Перетаскивание
local dragging = false
local dragStart = nil
local frameStart = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        frameStart = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Сворачивание
local minimized = false
local fullSize = mainFrame.Size
local fullPos = mainFrame.Position

closeBtn.MouseButton1Click:Connect(function()
    if minimized then
        minimized = false
        animate(mainFrame, {Size = fullSize}, 0.3)
        animate(mainFrame, {Position = fullPos}, 0.3)
        closeBtn.Text = "−"
        tabsFrame.Visible = true
        contentFrame.Visible = true
    else
        minimized = true
        animate(mainFrame, {Size = UDim2.new(0, 60, 0, 40)}, 0.3)
        animate(mainFrame, {Position = UDim2.new(1, -70, 0, 60)}, 0.3)
        closeBtn.Text = "+"
        tabsFrame.Visible = false
        contentFrame.Visible = false
    end
end)

animate(mainFrame, {BackgroundTransparency = 0.05}, 0.3)

print("MANscript Hub | Пустое меню 350x200 загружено")