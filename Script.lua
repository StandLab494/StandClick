-- Script by @MANscript
-- SCRIPT HUB (меню как на скриншоте)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- === ЦВЕТА ===
local colors = {
    bg = Color3.fromRGB(18, 18, 22),
    card = Color3.fromRGB(28, 28, 35),
    accent = Color3.fromRGB(70, 70, 90),
    green = Color3.fromRGB(0, 200, 100),
    red = Color3.fromRGB(200, 50, 50),
    text = Color3.fromRGB(240, 240, 240),
    textDim = Color3.fromRGB(160, 160, 170)
}

-- === АНИМАЦИЯ ===
local function animate(obj, props, dur)
    local tween = TweenService:Create(obj, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

-- === СОЗДАНИЕ ГЛАВНОГО ОКНА ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MANscriptHub"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 360, 0, 560)
mainFrame.Position = UDim2.new(0, 10, 0, 60)
mainFrame.BackgroundColor3 = colors.bg
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = mainFrame

-- Тень
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 8, 1, 8)
shadow.Position = UDim2.new(0, -4, 0, -4)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.BorderSizePixel = 0
shadow.ZIndex = 0
shadow.Parent = mainFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 20)
shadowCorner.Parent = shadow

-- === ЗАГОЛОВОК ===
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 55)
titleBar.BackgroundColor3 = colors.card
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 18)
titleCorner.Parent = titleBar

-- Аватарка (иконка)
local avatarIcon = Instance.new("ImageLabel")
avatarIcon.Size = UDim2.new(0, 36, 0, 36)
avatarIcon.Position = UDim2.new(0, 12, 0, 9)
avatarIcon.BackgroundColor3 = colors.accent
avatarIcon.Image = "rbxasset://textures/ui/Shell/Button.png"
avatarIcon.Parent = titleBar

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 10)
avatarCorner.Parent = avatarIcon

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -100, 1, 0)
titleText.Position = UDim2.new(0, 60, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "@MANscript"
titleText.TextColor3 = colors.text
titleText.TextSize = 18
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Font = Enum.Font.GothamBold
titleText.Parent = titleBar

local versionText = Instance.new("TextLabel")
versionText.Size = UDim2.new(1, -100, 0, 20)
versionText.Position = UDim2.new(0, 60, 1, -22)
versionText.BackgroundTransparency = 1
versionText.Text = "Script Hub v1.0"
versionText.TextColor3 = colors.textDim
versionText.TextSize = 11
versionText.TextXAlignment = Enum.TextXAlignment.Left
versionText.Font = Enum.Font.Gotham
versionText.Parent = titleBar

-- Кнопка закрытия/сворачивания
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -46, 0, 9)
closeBtn.BackgroundColor3 = colors.accent
closeBtn.Text = "✕"
closeBtn.TextColor3 = colors.text
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

-- === СКРОЛЛ ПАНЕЛЬ ===
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -75)
scrollFrame.Position = UDim2.new(0, 10, 0, 65)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = colors.accent
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

local uiList = Instance.new("UIListLayout")
uiList.Padding = UDim.new(0, 12)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Parent = scrollFrame

-- === ФУНКЦИЯ СОЗДАНИЯ КАТЕГОРИИ ===
local function createCategory(title)
    local categoryFrame = Instance.new("Frame")
    categoryFrame.Size = UDim2.new(1, 0, 0, 40)
    categoryFrame.BackgroundTransparency = 1
    categoryFrame.Parent = scrollFrame
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = colors.accent
    line.BorderSizePixel = 0
    line.Parent = categoryFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = colors.text
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = categoryFrame
    
    return categoryFrame
end

-- === ФУНКЦИЯ СОЗДАНИЯ КНОПКИ ===
local function createScriptButton(name, url, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 55)
    btn.BackgroundColor3 = colors.card
    btn.BackgroundTransparency = 0.3
    btn.Text = ""
    btn.BorderSizePixel = 0
    btn.Parent = scrollFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 45, 1, 0)
    icon.BackgroundTransparency = 1
    icon.TextColor3 = colors.text
    icon.TextSize = 24
    icon.Font = Enum.Font.Gotham
    icon.Parent = btn
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -100, 0, 25)
    nameLabel.Position = UDim2.new(0, 55, 0, 8)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = colors.text
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = btn
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -100, 0, 20)
    descLabel.Position = UDim2.new(0, 55, 0, 30)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = "Нажми чтобы запустить →"
    descLabel.TextColor3 = colors.textDim
    descLabel.TextSize = 11
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Font = Enum.Font.Gotham
    descLabel.Parent = btn
    
    local runBtn = Instance.new("TextButton")
    runBtn.Size = UDim2.new(0, 80, 0, 36)
    runBtn.Position = UDim2.new(1, -90, 0.5, -18)
    runBtn.BackgroundColor3 = color or colors.green
    runBtn.Text = "▶ СТАРТ"
    runBtn.TextColor3 = colors.text
    runBtn.TextSize = 12
    runBtn.Font = Enum.Font.GothamBold
    runBtn.BorderSizePixel = 0
    runBtn.Parent = btn
    
    local runCorner = Instance.new("UICorner")
    runCorner.CornerRadius = UDim.new(0, 8)
    runCorner.Parent = runBtn
    
    runBtn.MouseButton1Click:Connect(function()
        animate(btn, {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}, 0.08)
        task.wait(0.08)
        animate(btn, {BackgroundColor3 = colors.card}, 0.08)
        
        local success, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        
        if not success then
            game.StarterGui:SetCore("SendNotification", {
                Title = "MANscript",
                Text = "Ошибка: " .. tostring(err),
                Duration = 3
            })
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "MANscript",
                Text = name .. " запущен! ✅",
                Duration = 2
            })
        end
    end)
    
    btn.MouseEnter:Connect(function()
        animate(btn, {BackgroundTransparency = 0.1}, 0.1)
    end)
    btn.MouseLeave:Connect(function()
        animate(btn, {BackgroundTransparency = 0.3}, 0.1)
    end)
    
    if name:find("Blox") then icon.Text = "⚔️"
    elseif name:find("Forsaken") then icon.Text = "🎮"
    elseif name:find("Night") then icon.Text = "🌙"
    elseif name:find("Dead") then icon.Text = "💀"
    else icon.Text = "📜" end
    
    return btn
end

-- === ========== ТВОИ СКРИПТЫ ========== ===

-- Категория: ШУТЕРЫ / PVP
createCategory("⚔️ ШУТЕРЫ И PVP")

createScriptButton("BloxStrike", "https://raw.githubusercontent.com/polo242c/bloxstrike/refs/heads/main/blox", Color3.fromRGB(200, 80, 80))
createScriptButton("Dead Rails (Фарм облигаций)", "https://raw.githubusercontent.com/hungquan99/HungHub/main/loader.lua", Color3.fromRGB(100, 100, 200))

-- Категория: РПГ И ФАРМ
createCategory("🎮 РПГ И ФАРМ")

createScriptButton("Blox Fruit", "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua", Color3.fromRGB(0, 150, 100))
createScriptButton("Forsaken", "https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua", Color3.fromRGB(150, 100, 0))
createScriptButton("99 Nights", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", Color3.fromRGB(100, 50, 150))

-- Категория: ИНФО
createCategory("ℹ️ ИНФОРМАЦИЯ")

local infoBtn = Instance.new("TextButton")
infoBtn.Size = UDim2.new(1, 0, 0, 50)
infoBtn.BackgroundColor3 = colors.card
infoBtn.BackgroundTransparency = 0.4
infoBtn.Text = "📢 @MANscript | Telegram: @MANscript"
infoBtn.TextColor3 = colors.text
infoBtn.TextSize = 12
infoBtn.Font = Enum.Font.Gotham
infoBtn.BorderSizePixel = 0
infoBtn.Parent = scrollFrame

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 12)
infoCorner.Parent = infoBtn

-- Обновляем размер Canvas
local function updateCanvas()
    task.wait(0.1)
    local children = scrollFrame:GetChildren()
    local totalHeight = 0
    for _, child in ipairs(children) do
        if child:IsA("Frame") or child:IsA("TextButton") then
            totalHeight = totalHeight + child.Size.Y.Offset + 12
        end
    end
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 20)
end

updateCanvas()

-- === ПЕРЕТАСКИВАНИЕ ОКНА ===
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

-- === СВОРАЧИВАНИЕ ===
local minimized = false
local fullSize = mainFrame.Size
local fullPos = mainFrame.Position

closeBtn.MouseButton1Click:Connect(function()
    if minimized then
        minimized = false
        animate(mainFrame, {Size = fullSize}, 0.3)
        animate(mainFrame, {Position = fullPos}, 0.3)
        closeBtn.Text = "✕"
        scrollFrame.Visible = true
    else
        minimized = true
        animate(mainFrame, {Size = UDim2.new(0, 60, 0, 55)}, 0.3)
        animate(mainFrame, {Position = UDim2.new(1, -70, 0, 60)}, 0.3)
        closeBtn.Text = "+"
        scrollFrame.Visible = false
    end
end)

-- Плавное появление
animate(mainFrame, {BackgroundTransparency = 0.05}, 0.3)

-- Уведомление
game.StarterGui:SetCore("SendNotification", {
    Title = "MANscript",
    Text = "Script Hub загружен! ",
    Duration = 3
})

print("@MANscript - Script Hub активирован")
