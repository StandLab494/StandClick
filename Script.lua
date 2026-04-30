local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ===== ЗАСТАВКА =====
local splashGui = Instance.new("ScreenGui")
splashGui.Parent = game:GetService("CoreGui")
splashGui.ResetOnSpawn = false

local blur = Instance.new("BlurEffect")
blur.Size = 12
blur.Parent = game:GetService("Lighting")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 320)
frame.Position = UDim2.new(0.5, -150, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Parent = splashGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = frame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 50)
logo.Position = UDim2.new(0, 0, 0, 25)
logo.BackgroundTransparency = 1
logo.Text = "MANscript"
logo.TextColor3 = Color3.fromRGB(200, 150, 255)
logo.TextSize = 32
logo.Font = Enum.Font.GothamBold
logo.Parent = frame

local warning = Instance.new("TextLabel")
warning.Size = UDim2.new(1, -40, 0, 60)
warning.Position = UDim2.new(0, 20, 0, 90)
warning.BackgroundTransparency = 1
warning.Text = "‼️ МЫ НЕ НЕСЁМ ОТВЕТСТВЕННОСТЬ ЗА ВАШ АККАУНТ ‼️"
warning.TextColor3 = Color3.fromRGB(255, 100, 100)
warning.TextSize = 13
warning.TextWrapped = true
warning.Font = Enum.Font.GothamBold
warning.Parent = frame

local advice = Instance.new("TextLabel")
advice.Size = UDim2.new(1, -40, 0, 40)
advice.Position = UDim2.new(0, 20, 0, 160)
advice.BackgroundTransparency = 1
advice.Text = "Попытайтесь не спалиться с использованием эксплойтеров!"
advice.TextColor3 = Color3.fromRGB(220, 180, 220)
advice.TextSize = 11
advice.Font = Enum.Font.Gotham
advice.Parent = frame

local acceptBtn = Instance.new("TextButton")
acceptBtn.Size = UDim2.new(0, 260, 0, 55)
acceptBtn.Position = UDim2.new(0.5, -130, 1, -75)
acceptBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 140)
acceptBtn.Text = "Я ПРОЧИТАЛ И НЕСУ ОТВЕТСТВЕННОСТЬ"
acceptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
acceptBtn.TextSize = 11
acceptBtn.Font = Enum.Font.GothamBold
acceptBtn.BorderSizePixel = 0
acceptBtn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = acceptBtn

acceptBtn.MouseButton1Click:Connect(function()
    splashGui:Destroy()
    blur:Destroy()
end)

-- ===== АНИМИРОВАННЫЙ ФОН (ЗАСТАВКА) =====
local bgGradient = Instance.new("Frame")
bgGradient.Size = UDim2.new(1, 0, 1, 0)
bgGradient.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
bgGradient.BackgroundTransparency = 0
bgGradient.Parent = splashGui

local function animateBg()
    while splashGui and splashGui.Parent do
        local hue = tick() % 6 / 6
        local color = Color3.fromHSV(hue, 0.6, 0.15)
        TweenService:Create(bgGradient, TweenInfo.new(3), {BackgroundColor3 = color}):Play()
        task.wait(3)
    end
end
task.spawn(animateBg)

-- ===== ОСНОВНОЕ МЕНЮ =====
local gui = Instance.new("ScreenGui")
gui.Name = "MANscriptHub"
gui.Parent = game:GetService("CoreGui")
gui.ResetOnSpawn = false

-- Звук клика
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://9120373326"
clickSound.Volume = 0.5
clickSound.Parent = gui

local function playClick()
    clickSound:Play()
end

-- Анимированный фон меню
local menuBg = Instance.new("Frame")
menuBg.Size = UDim2.new(1, 0, 1, 0)
menuBg.BackgroundColor3 = Color3.fromRGB(5, 5, 12)
menuBg.Parent = gui

task.spawn(function()
    while gui and gui.Parent do
        local hue = tick() % 6 / 6
        local color = Color3.fromHSV(hue, 0.5, 0.1)
        TweenService:Create(menuBg, TweenInfo.new(4), {BackgroundColor3 = color}):Play()
        task.wait(4)
    end
end)

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 450, 0, 560)
main.Position = UDim2.new(0, 10, 0, 60)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
main.BackgroundTransparency = 0.1
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -180, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MANscript Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

-- Кнопка ТГК
local tgBtn = Instance.new("TextButton")
tgBtn.Size = UDim2.new(0, 70, 0, 30)
tgBtn.Position = UDim2.new(1, -165, 0.5, -15)
tgBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
tgBtn.Text = "📢 ТГК"
tgBtn.TextColor3 = Color3.fromRGB(200, 180, 255)
tgBtn.TextSize = 11
tgBtn.Font = Enum.Font.GothamBold
tgBtn.BorderSizePixel = 0
tgBtn.Parent = titleBar

local tgCorner = Instance.new("UICorner")
tgCorner.CornerRadius = UDim.new(0, 8)
tgCorner.Parent = tgBtn

tgBtn.MouseButton1Click:Connect(function()
    playClick()
    setclipboard("https://t.me/manscripthub")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "MANscript",
        Text = "Ссылка на ТГК скопирована!",
        Duration = 2
    })
end)

-- Кнопка смены темы
local themeBtn = Instance.new("TextButton")
themeBtn.Size = UDim2.new(0, 50, 0, 30)
themeBtn.Position = UDim2.new(1, -110, 0.5, -15)
themeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
themeBtn.Text = "🌙"
themeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
themeBtn.TextSize = 16
themeBtn.Font = Enum.Font.GothamBold
themeBtn.BorderSizePixel = 0
themeBtn.Parent = titleBar

local themeCorner = Instance.new("UICorner")
themeCorner.CornerRadius = UDim.new(0, 8)
themeCorner.Parent = themeBtn

local currentTheme = "dark"
themeBtn.MouseButton1Click:Connect(function()
    playClick()
    if currentTheme == "dark" then
        currentTheme = "light"
        main.BackgroundColor3 = Color3.fromRGB(240, 240, 250)
        main.BackgroundTransparency = 0.05
        titleBar.BackgroundColor3 = Color3.fromRGB(220, 220, 235)
        title.TextColor3 = Color3.fromRGB(20, 20, 30)
        themeBtn.Text = "☀️"
    else
        currentTheme = "dark"
        main.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        main.BackgroundTransparency = 0.1
        titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        themeBtn.Text = "🌙"
    end
end)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -38, 0, 8)
minBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 20
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.Parent = titleBar

local minCornerBtn = Instance.new("UICorner")
minCornerBtn.CornerRadius = UDim.new(1, 0)
minCornerBtn.Parent = minBtn

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -16, 1, -55)
scroll.Position = UDim2.new(0, 8, 0, 50)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

local function addCat(name)
    local cat = Instance.new("Frame")
    cat.Size = UDim2.new(1, -8, 0, 38)
    cat.BackgroundTransparency = 1
    cat.Parent = scroll
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = Color3.fromRGB(60, 60, 85)
    line.BorderSizePixel = 0
    line.Parent = cat
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = name
    text.TextColor3 = Color3.fromRGB(200, 200, 210)
    text.TextSize = 13
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.Font = Enum.Font.GothamBold
    text.Parent = cat
end

local function addScript(name, url, col)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 55)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.BackgroundTransparency = 0.4
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.Parent = scroll
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -100, 0, 24)
    nameLabel.Position = UDim2.new(0, 16, 0, 8)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(235, 235, 245)
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = btn
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -100, 0, 18)
    descLabel.Position = UDim2.new(0, 16, 0, 32)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = "нажми чтобы запустить"
    descLabel.TextColor3 = Color3.fromRGB(130, 130, 150)
    descLabel.TextSize = 10
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Font = Enum.Font.Gotham
    descLabel.Parent = btn
    
    local run = Instance.new("TextButton")
    run.Size = UDim2.new(0, 75, 0, 32)
    run.Position = UDim2.new(1, -85, 0.5, -16)
    run.BackgroundColor3 = col or Color3.fromRGB(0, 130, 80)
    run.Text = "СТАРТ"
    run.TextColor3 = Color3.fromRGB(255, 255, 255)
    run.TextSize = 11
    run.Font = Enum.Font.GothamBold
    run.BorderSizePixel = 0
    run.Parent = btn
    
    local runCorner = Instance.new("UICorner")
    runCorner.CornerRadius = UDim.new(0, 7)
    runCorner.Parent = run
    
    run.MouseButton1Click:Connect(function()
        playClick()
        pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "MANscript",
            Text = name .. " запущен",
            Duration = 2
        })
    end)
end

addCat("ШУТЕРЫ")
addScript("BloxStrike", "https://raw.githubusercontent.com/polo242c/bloxstrike/refs/heads/main/blox", Color3.fromRGB(180, 60, 60))
addScript("Dead Rails", "https://raw.githubusercontent.com/hungquan99/HungHub/main/loader.lua", Color3.fromRGB(80, 80, 180))
addScript("TSB", "https://raw.githubusercontent.com/COOLXPLO/DP-HUB-coolxplo/refs/heads/main/TSB.lua", Color3.fromRGB(200, 100, 50))
addScript("Rivals", "https://soluna-script.vercel.app/main.lua", Color3.fromRGB(100, 150, 200))

addCat("РПГ")
addScript("Blox Fruit", "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua", Color3.fromRGB(0, 150, 100))
addScript("Forsaken", "https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua", Color3.fromRGB(180, 120, 0))
addScript("99 Nights", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", Color3.fromRGB(120, 60, 180))
addScript("Steal a Brainrot", "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/DUELWorld.lua", Color3.fromRGB(150, 50, 100))

addCat("ИНФО")
local info = Instance.new("TextButton")
info.Size = UDim2.new(1, -8, 0, 42)
info.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
info.BackgroundTransparency = 0.5
info.Text = "@MANscript  |  спасибо за использование ❤️"
info.TextColor3 = Color3.fromRGB(160, 160, 180)
info.TextSize = 11
info.Font = Enum.Font.Gotham
info.BorderSizePixel = 0
info.Parent = scroll

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 10)
infoCorner.Parent = info

-- ===== ПЕРЕТАСКИВАНИЕ =====
local dragging = false
local dragStart = nil
local frameStart = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        frameStart = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function()
    dragging = false
end)

-- ===== СВОРАЧИВАНИЕ =====
local minimized = false
local fullSize = main.Size
local fullPos = main.Position

minBtn.MouseButton1Click:Connect(function()
    playClick()
    if minimized then
        minimized = false
        main.Size = fullSize
        main.Position = fullPos
        minBtn.Text = "-"
        scroll.Visible = true
    else
        minimized = true
        main.Size = UDim2.new(0, 65, 0, 45)
        main.Position = UDim2.new(1, -75, 0, 70)
        minBtn.Text = "+"
        scroll.Visible = false
    end
end)

task.wait(0.1)
local h = 0
for _, v in pairs(scroll:GetChildren()) do
    if v:IsA("Frame") or v:IsA("TextButton") then
        h = h + v.Size.Y.Offset + 8
    end
end
scroll.CanvasSize = UDim2.new(0, 0, 0, h + 20)