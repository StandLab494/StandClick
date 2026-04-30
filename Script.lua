
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local colors = {
    bg = Color3.fromRGB(18, 18, 22),
    card = Color3.fromRGB(28, 28, 35),
    accent = Color3.fromRGB(70, 70, 90),
    green = Color3.fromRGB(0, 200, 100),
    red = Color3.fromRGB(200, 50, 50),
    text = Color3.fromRGB(240, 240, 240),
    textDim = Color3.fromRGB(160, 160, 170)
}

local function animate(obj, props, dur)
    local tween = TweenService:Create(obj, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end


local splashGui = Instance.new("ScreenGui")
splashGui.Name = "Warning"
splashGui.Parent = game.CoreGui
splashGui.ResetOnSpawn = false

local blur = Instance.new("BlurEffect")
blur.Size = 12
blur.Parent = game.Lighting

local splashBg = Instance.new("Frame")
splashBg.Size = UDim2.new(1, 0, 1, 0)
splashBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
splashBg.BackgroundTransparency = 0.5
splashBg.Parent = splashGui

local warningFrame = Instance.new("Frame")
warningFrame.Size = UDim2.new(0, 300, 0, 300)
warningFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
warningFrame.BackgroundColor3 = colors.card
warningFrame.BackgroundTransparency = 0.15
warningFrame.Parent = splashGui

local warningCorner = Instance.new("UICorner")
warningCorner.CornerRadius = UDim.new(0, 20)
warningCorner.Parent = warningFrame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 50)
logo.Position = UDim2.new(0, 0, 0, 20)
logo.BackgroundTransparency = 1
logo.Text = "MANscript"
logo.TextColor3 = Color3.fromRGB(200, 150, 255)
logo.TextSize = 32
logo.Font = Enum.Font.GothamBold
logo.Parent = warningFrame

local warningText = Instance.new("TextLabel")
warningText.Size = UDim2.new(1, -40, 0, 60)
warningText.Position = UDim2.new(0, 20, 0, 85)
warningText.BackgroundTransparency = 1
warningText.Text = "‼️ МЫ НЕ НЕСЁМ ОТВЕТСТВЕННОСТЬ ЗА ВАШ АККАУНТ ‼️"
warningText.TextColor3 = Color3.fromRGB(255, 100, 100)
warningText.TextSize = 13
warningText.TextWrapped = true
warningText.Font = Enum.Font.GothamBold
warningText.Parent = warningFrame

local advice = Instance.new("TextLabel")
advice.Size = UDim2.new(1, -40, 0, 40)
advice.Position = UDim2.new(0, 20, 0, 155)
advice.BackgroundTransparency = 1
advice.Text = "Попытайтесь не спалиться с использованием эксплойтеров!"
advice.TextColor3 = Color3.fromRGB(220, 180, 220)
advice.TextSize = 11
advice.Font = Enum.Font.Gotham
advice.Parent = warningFrame

local acceptBtn = Instance.new("TextButton")
acceptBtn.Size = UDim2.new(0, 240, 0, 50)
acceptBtn.Position = UDim2.new(0.5, -120, 1, -65)
acceptBtn.BackgroundColor3 = colors.green
acceptBtn.Text = "Я ПРОЧИТАЛ И НЕСУ ОТВЕТСТВЕННОСТЬ"
acceptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
acceptBtn.TextSize = 11
acceptBtn.TextWrapped = true
acceptBtn.Font = Enum.Font.GothamBold
acceptBtn.Parent = warningFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = acceptBtn


local function loadMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MANscriptHub"
    screenGui.Parent = game.CoreGui
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

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 55)
    titleBar.BackgroundColor3 = colors.card
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 18)
    titleCorner.Parent = titleBar

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
    titleText.Size = UDim2.new(1, -160, 1, 0)
    titleText.Position = UDim2.new(0, 60, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "MANscript Hub"
    titleText.TextColor3 = colors.text
    titleText.TextSize = 18
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Font = Enum.Font.GothamBold
    titleText.Parent = titleBar

    local tgBtn = Instance.new("TextButton")
    tgBtn.Size = UDim2.new(0, 70, 0, 32)
    tgBtn.Position = UDim2.new(1, -130, 0.5, -16)
    tgBtn.BackgroundColor3 = colors.accent
    tgBtn.Text = "📢 ТГК"
    tgBtn.TextColor3 = colors.text
    tgBtn.TextSize = 12
    tgBtn.Font = Enum.Font.GothamBold
    tgBtn.BorderSizePixel = 0
    tgBtn.Parent = titleBar

    local tgCorner = Instance.new("UICorner")
    tgCorner.CornerRadius = UDim.new(0, 8)
    tgCorner.Parent = tgBtn

    tgBtn.MouseButton1Click:Connect(function()
        setclipboard("https://t.me/manscripthub")
        game.StarterGui:SetCore("SendNotification", {
            Title = "MANscript",
            Text = "Ссылка на ТГК скопирована!",
            Duration = 2
        })
    end)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 36, 0, 36)
    closeBtn.Position = UDim2.new(1, -46, 0, 9)
    closeBtn.BackgroundColor3 = colors.accent
    closeBtn.Text = "−"
    closeBtn.TextColor3 = colors.text
    closeBtn.TextSize = 24
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeBtn

    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -75)
    scrollFrame.Position = UDim2.new(0, 10, 0, 65)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 5
    scrollFrame.ScrollBarImageColor3 = colors.accent
    scrollFrame.ScrollBarImageTransparency = 0.5
    scrollFrame.ElasticBehavior = Enum.ElasticBehavior.Always
    scrollFrame.Parent = mainFrame

    local uiList = Instance.new("UIListLayout")
    uiList.Padding = UDim.new(0, 12)
    uiList.SortOrder = Enum.SortOrder.LayoutOrder
    uiList.Parent = scrollFrame

    local function createCategory(title)
        local catFrame = Instance.new("Frame")
        catFrame.Size = UDim2.new(1, 0, 0, 40)
        catFrame.BackgroundTransparency = 1
        catFrame.Parent = scrollFrame
        
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 2)
        line.Position = UDim2.new(0, 0, 1, -2)
        line.BackgroundColor3 = colors.accent
        line.BorderSizePixel = 0
        line.Parent = catFrame
        
        local catText = Instance.new("TextLabel")
        catText.Size = UDim2.new(1, 0, 1, 0)
        catText.BackgroundTransparency = 1
        catText.Text = title
        catText.TextColor3 = colors.text
        catText.TextSize = 14
        catText.TextXAlignment = Enum.TextXAlignment.Left
        catText.Font = Enum.Font.GothamBold
        catText.Parent = catFrame
    end

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
        descLabel.Text = "нажми чтобы запустить →"
        descLabel.TextColor3 = colors.textDim
        descLabel.TextSize = 11
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Font = Enum.Font.Gotham
        descLabel.Parent = btn
        
        local runBtn = Instance.new("TextButton")
        runBtn.Size = UDim2.new(0, 80, 0, 36)
        runBtn.Position = UDim2.new(1, -90, 0.5, -18)
        runBtn.BackgroundColor3 = color or colors.green
        runBtn.Text = "СТАРТ"
        runBtn.TextColor3 = colors.text
        runBtn.TextSize = 12
        runBtn.Font = Enum.Font.GothamBold
        runBtn.BorderSizePixel = 0
        runBtn.Parent = btn
        
        local runCorner = Instance.new("UICorner")
        runCorner.CornerRadius = UDim.new(0, 8)
        runCorner.Parent = runBtn
        
        if name:find("BloxStrike") then icon.Text = "⚡"
        elseif name:find("Dead") then icon.Text = "💀"
        elseif name:find("TSB") then icon.Text = "🥊"
        elseif name:find("Rivals") then icon.Text = "🎯"
        elseif name:find("Blox Fruit") then icon.Text = "🍎"
        elseif name:find("Forsaken") then icon.Text = "🎭"
        elseif name:find("99") then icon.Text = "🌙"
        elseif name:find("Steal") then icon.Text = "🧠"
        elseif name:find("RexBR") then icon.Text = "🚀"
        elseif name:find("Evade") then icon.Text = "🏃"
        elseif name:find("ETFB") then icon.Text = "🌊"
        elseif name:find("Bee") then icon.Text = "🐝"
        else icon.Text = "📁" end
        
        runBtn.MouseButton1Click:Connect(function()
            animate(btn, {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}, 0.08)
            task.wait(0.08)
            animate(btn, {BackgroundColor3 = colors.card}, 0.08)
            pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            game.StarterGui:SetCore("SendNotification", {
                Title = "MANscript",
                Text = name .. " запущен",
                Duration = 2
            })
        end)
    end

    createCategory("⚔️ ШУТЕРЫ")
    createScriptButton("BloxStrike", "https://raw.githubusercontent.com/polo242c/bloxstrike/refs/heads/main/blox", Color3.fromRGB(200, 80, 80))
    createScriptButton("Dead Rails", "https://raw.githubusercontent.com/hungquan99/HungHub/main/loader.lua", Color3.fromRGB(100, 100, 200))
    createScriptButton("TSB", "https://raw.githubusercontent.com/COOLXPLO/DP-HUB-coolxplo/refs/heads/main/TSB.lua", Color3.fromRGB(200, 150, 50))
    createScriptButton("Rivals", "https://soluna-script.vercel.app/main.lua", Color3.fromRGB(100, 150, 200))
    createScriptButton("Evade", "https://raw.githubusercontent.com/thesigmacorex/Flashware/main/script", Color3.fromRGB(255, 100, 0))

    createCategory("🎮 РПГ")
    createScriptButton("Blox Fruit", "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua", Color3.fromRGB(0, 150, 100))
    createScriptButton("Forsaken", "https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua", Color3.fromRGB(150, 100, 0))
    createScriptButton("99 Nights", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", Color3.fromRGB(120, 60, 180))
    createScriptButton("Steal a Brainrot", "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/DUELWorld.lua", Color3.fromRGB(150, 50, 100))
    createScriptButton("Bee Swarm Simulator", "https://raw.githubusercontent.com/DevKron/Kron_Hub/refs/heads/main/version_1.0", Color3.fromRGB(255, 200, 0))

    createCategory("🚀 БЫСТРЫЙ СБОР / ПОЛЁТ")
    createScriptButton("RexBR Hub (Fly+Collect)", "https://pastebin.com/raw/pCMCfnmV", Color3.fromRGB(0, 200, 150))
    createScriptButton("ETFB (Tsunami Brainrot)", "https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots", Color3.fromRGB(0, 150, 200))

    createCategory("ℹ️ ИНФО")
    local infoBtn = Instance.new("TextButton")
    infoBtn.Size = UDim2.new(1, 0, 0, 50)
    infoBtn.BackgroundColor3 = colors.card
    infoBtn.BackgroundTransparency = 0.4
    infoBtn.Text = "📢 @MANscript | tg: @manscripthub"
    infoBtn.TextColor3 = colors.text
    infoBtn.TextSize = 12
    infoBtn.Font = Enum.Font.Gotham
    infoBtn.BorderSizePixel = 0
    infoBtn.Parent = scrollFrame

    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 12)
    infoCorner.Parent = infoBtn

    local function updateCanvas()
        task.wait(0.1)
        local totalHeight = 0
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") then
                totalHeight = totalHeight + child.Size.Y.Offset + 12
            end
        end
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 20)
        scrollFrame.CanvasPosition = Vector2.new(0, math.max(0, totalHeight + 20 - 500))
    end
    updateCanvas()

    local dragging = false
    local dragStart = nil
    local frameStart = nil

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            frameStart = mainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function()
        dragging = false
    end)

    local minimized = false
    local fullSize = mainFrame.Size
    local fullPos = mainFrame.Position

    closeBtn.MouseButton1Click:Connect(function()
        if minimized then
            minimized = false
            animate(mainFrame, {Size = fullSize}, 0.3)
            animate(mainFrame, {Position = fullPos}, 0.3)
            closeBtn.Text = "−"
            scrollFrame.Visible = true
        else
            minimized = true
            animate(mainFrame, {Size = UDim2.new(0, 60, 0, 55)}, 0.3)
            animate(mainFrame, {Position = UDim2.new(1, -70, 0, 60)}, 0.3)
            closeBtn.Text = "+"
            scrollFrame.Visible = false
        end
    end)

    animate(mainFrame, {BackgroundTransparency = 0.05}, 0.3)
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "MANscript",
        Text = "Хаб загружен! Листай вниз →",
        Duration = 3
    })
end

acceptBtn.MouseButton1Click:Connect(function()
    splashGui:Destroy()
    blur:Destroy()
    loadMenu()
end)

task.wait(4)
pcall(function()
    splashGui:Destroy()
    blur:Destroy()
    loadMenu()
end)