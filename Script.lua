-- MANscript Hub (3 вкладки: Меню | Скрипты | Музыка)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

-- ===== ЦВЕТА =====
local colors = {
    bg = Color3.fromRGB(18, 18, 22),
    card = Color3.fromRGB(28, 28, 35),
    accent = Color3.fromRGB(70, 70, 90),
    green = Color3.fromRGB(0, 200, 100),
    red = Color3.fromRGB(200, 50, 50),
    text = Color3.fromRGB(240, 240, 240),
    textDim = Color3.fromRGB(160, 160, 170),
    tabActive = Color3.fromRGB(0, 150, 200),
    tabInactive = Color3.fromRGB(40, 40, 55)
}

-- ===== МУЗЫКАЛЬНЫЙ ПЛЕЕР =====
local player = Instance.new("Sound")
player.Volume = 0.5
player.Looped = true
player.Parent = CoreGui

local function playMusic(id)
    player.SoundId = "rbxassetid://" .. tostring(id)
    player:Play()
end

local function stopMusic()
    player:Stop()
end

local function setVolume(vol)
    player.Volume = math.clamp(vol, 0, 1)
end

local songIDs = {
    {name = "Roblox Main Theme", id = "1839189998"},
    {name = "Epic Battle (Raid)", id = "1840576456"},
    {name = "Chill Lofi", id = "9120394240"},
    {name = "Retro Arcade", id = "6678863342"},
    {name = "Synthwave", id = "7266095685"},
    {name = "Night Ride", id = "8118354532"},
    {name = "Sunset Vibes", id = "8144028326"},
    {name = "Action Trailer", id = "5858214740"},
    {name = "Suspense", id = "4012555256"},
    {name = "Victory Fanfare", id = "4203662159"},
    {name = "Boss Fight", id = "6576183301"},
    {name = "Mysterious", id = "4963954177"},
    {name = "Tropical Beats", id = "8956785122"},
    {name = "LoFi Study", id = "7368416683"},
    {name = "Phonk Energy", id = "10372548840"},
    {name = "Dungeon Crawl", id = "5252695259"},
    {name = "Cyberpunk", id = "9143271822"},
    {name = "Space Odyssey", id = "5862092309"},
    {name = "Rainy Day", id = "7498519165"},
    {name = "Jazz Club", id = "6804304570"},
}

-- ===== ЗАСТАВКА-ПРЕДУПРЕЖДЕНИЕ =====
local splashGui = Instance.new("ScreenGui")
splashGui.Name = "Warning"
splashGui.Parent = CoreGui
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

-- ===== ОСНОВНОЕ МЕНЮ =====
local function loadMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MANscriptHub"
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 380, 0, 560)
    mainFrame.Position = UDim2.new(0, 10, 0, 60)
    mainFrame.BackgroundColor3 = colors.bg
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 18)
    mainCorner.Parent = mainFrame

    -- Заголовок
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

    -- Кнопка ТГК
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

    -- Кнопка сворачивания
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

    -- ===== ВКЛАДКИ =====
    local tabsFrame = Instance.new("Frame")
    tabsFrame.Size = UDim2.new(1, 0, 0, 45)
    tabsFrame.Position = UDim2.new(0, 0, 0, 55)
    tabsFrame.BackgroundTransparency = 1
    tabsFrame.Parent = mainFrame

    local tab1 = Instance.new("TextButton")
    tab1.Size = UDim2.new(0.33, 0, 1, 0)
    tab1.Position = UDim2.new(0, 0, 0, 0)
    tab1.BackgroundColor3 = colors.tabActive
    tab1.Text = "📊 Меню"
    tab1.TextColor3 = colors.text
    tab1.TextSize = 14
    tab1.Font = Enum.Font.GothamBold
    tab1.BorderSizePixel = 0
    tab1.Parent = tabsFrame

    local tab2 = Instance.new("TextButton")
    tab2.Size = UDim2.new(0.34, 0, 1, 0)
    tab2.Position = UDim2.new(0.33, 0, 0, 0)
    tab2.BackgroundColor3 = colors.tabInactive
    tab2.Text = "🎮 Скрипты"
    tab2.TextColor3 = colors.text
    tab2.TextSize = 14
    tab2.Font = Enum.Font.GothamBold
    tab2.BorderSizePixel = 0
    tab2.Parent = tabsFrame

    local tab3 = Instance.new("TextButton")
    tab3.Size = UDim2.new(0.33, 0, 1, 0)
    tab3.Position = UDim2.new(0.67, 0, 0, 0)
    tab3.BackgroundColor3 = colors.tabInactive
    tab3.Text = "🎵 Музыка"
    tab3.TextColor3 = colors.text
    tab3.TextSize = 14
    tab3.Font = Enum.Font.GothamBold
    tab3.BorderSizePixel = 0
    tab3.Parent = tabsFrame

    -- Контент для вкладок
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -115)
    contentFrame.Position = UDim2.new(0, 10, 0, 105)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    -- ===== ВКЛАДКА 1: МЕНЮ (СТАТИСТИКА) =====
    local menuScroll = Instance.new("ScrollingFrame")
    menuScroll.Size = UDim2.new(1, 0, 1, 0)
    menuScroll.BackgroundTransparency = 1
    menuScroll.ScrollBarThickness = 5
    menuScroll.Visible = true
    menuScroll.Parent = contentFrame

    local menuLayout = Instance.new("UIListLayout")
    menuLayout.Padding = UDim.new(0, 10)
    menuLayout.Parent = menuScroll

    local function addMenuCard(title, value, icon)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -10, 0, 60)
        card.BackgroundColor3 = colors.card
        card.BackgroundTransparency = 0.3
        card.Parent = menuScroll
        
        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, 12)
        cardCorner.Parent = card
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, 45, 1, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.TextColor3 = colors.text
        iconLabel.TextSize = 28
        iconLabel.Font = Enum.Font.Gotham
        iconLabel.Parent = card
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -60, 0, 25)
        titleLabel.Position = UDim2.new(0, 55, 0, 8)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = colors.textDim
        titleLabel.TextSize = 12
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.Gotham
        titleLabel.Parent = card
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(1, -60, 0, 25)
        valueLabel.Position = UDim2.new(0, 55, 0, 30)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = value
        valueLabel.TextColor3 = colors.text
        valueLabel.TextSize = 16
        valueLabel.TextXAlignment = Enum.TextXAlignment.Left
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.Parent = card
    end

    addMenuCard("Ваш ник", LocalPlayer.Name, "👤")
    addMenuCard("ID пользователя", LocalPlayer.UserId, "🆔")
    addMenuCard("Аккаунт создан", LocalPlayer.AccountAge .. " дней назад", "📅")
    addMenuCard("Всего игроков", #Players:GetPlayers(), "🌍")
    addMenuCard("Пинг", math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. " ms", "📶")
    addMenuCard("FPS", "отслеживается", "🎮")

    -- Обновление статистики в реальном времени
    local fpsLabel = nil
    local pingLabel = nil
    local playersLabel = nil
    
    for _, child in pairs(menuScroll:GetChildren()) do
        if child:IsA("Frame") then
            local title = child:FindFirstChildOfClass("TextLabel")
            if title and title.Text == "FPS" then
                fpsLabel = child:FindFirstChildOfClass("TextLabel")
            end
            if title and title.Text == "Пинг" then
                pingLabel = child:FindFirstChildOfClass("TextLabel")
            end
            if title and title.Text == "Всего игроков" then
                playersLabel = child:FindFirstChildOfClass("TextLabel")
            end
        end
    end
    
    task.spawn(function()
        local lastFrame = tick()
        while menuScroll.Visible and menuScroll.Parent do
            task.wait(0.5)
            local now = tick()
            local fps = math.floor(1 / (now - lastFrame))
            lastFrame = now
            if fpsLabel then fpsLabel.Text = fps .. " FPS" end
            if pingLabel then 
                local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                pingLabel.Text = math.floor(ping) .. " ms"
            end
            if playersLabel then playersLabel.Text = #Players:GetPlayers() end
        end
    end)

    -- ===== ВКЛАДКА 2: СКРИПТЫ =====
    local scriptsScroll = Instance.new("ScrollingFrame")
    scriptsScroll.Size = UDim2.new(1, 0, 1, 0)
    scriptsScroll.BackgroundTransparency = 1
    scriptsScroll.ScrollBarThickness = 5
    scriptsScroll.Visible = false
    scriptsScroll.Parent = contentFrame

    local scriptsLayout = Instance.new("UIListLayout")
    scriptsLayout.Padding = UDim.new(0, 10)
    scriptsLayout.Parent = scriptsScroll

    local function createScriptButton(name, url, color)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 55)
        btn.BackgroundColor3 = colors.card
        btn.BackgroundTransparency = 0.3
        btn.Text = ""
        btn.BorderSizePixel = 0
        btn.Parent = scriptsScroll
        
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
        
        if name:find("BloxStrike") then icon.Text = "⚡"
        elseif name:find("Dead") then icon.Text = "💀"
        elseif name:find("TSB") then icon.Text = "🥊"
        elseif name:find("Rivals") then icon.Text = "🎯"
        elseif name:find("Evade") then icon.Text = "🏃"
        elseif name:find("Blox Fruit") then icon.Text = "🍎"
        elseif name:find("Forsaken") then icon.Text = "🎭"
        elseif name:find("99") then icon.Text = "🌙"
        elseif name:find("Steal") then icon.Text = "🧠"
        elseif name:find("Bee") then icon.Text = "🐝"
        elseif name:find("RexBR") then icon.Text = "🚀"
        elseif name:find("ETFB") then icon.Text = "🌊"
        else icon.Text = "📁" end
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -100, 0, 25)
        nameLabel.Position = UDim2.new(0, 55, 0, 8)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = colors.text
        nameLabel.TextSize = 14
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = btn
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(1, -100, 0, 18)
        descLabel.Position = UDim2.new(0, 55, 0, 30)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = "нажми чтобы запустить →"
        descLabel.TextColor3 = colors.textDim
        descLabel.TextSize = 10
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
        
        runBtn.MouseButton1Click:Connect(function()
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

    local function addCategory(title)
        local cat = Instance.new("Frame")
        cat.Size = UDim2.new(1, -10, 0, 40)
        cat.BackgroundTransparency = 1
        cat.Parent = scriptsScroll
        
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 2)
        line.Position = UDim2.new(0, 0, 1, -2)
        line.BackgroundColor3 = colors.accent
        line.BorderSizePixel = 0
        line.Parent = cat
        
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = title
        text.TextColor3 = colors.text
        text.TextSize = 14
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.Font = Enum.Font.GothamBold
        text.Parent = cat
    end

    addCategory("⚔️ ШУТЕРЫ")
    createScriptButton("BloxStrike", "https://raw.githubusercontent.com/polo242c/bloxstrike/refs/heads/main/blox", Color3.fromRGB(200, 80, 80))
    createScriptButton("Dead Rails", "https://raw.githubusercontent.com/hungquan99/HungHub/main/loader.lua", Color3.fromRGB(100, 100, 200))
    createScriptButton("TSB", "https://raw.githubusercontent.com/COOLXPLO/DP-HUB-coolxplo/refs/heads/main/TSB.lua", Color3.fromRGB(200, 150, 50))
    createScriptButton("Rivals", "https://soluna-script.vercel.app/main.lua", Color3.fromRGB(100, 150, 200))
    createScriptButton("Evade", "https://raw.githubusercontent.com/thesigmacorex/Flashware/main/script", Color3.fromRGB(255, 100, 0))

    addCategory("🎮 РПГ")
    createScriptButton("Blox Fruit", "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua", Color3.fromRGB(0, 150, 100))
    createScriptButton("Forsaken", "https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua", Color3.fromRGB(150, 100, 0))
    createScriptButton("99 Nights", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", Color3.fromRGB(120, 60, 180))
    createScriptButton("Steal a Brainrot", "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/DUELWorld.lua", Color3.fromRGB(150, 50, 100))
    createScriptButton("Bee Swarm Simulator", "https://raw.githubusercontent.com/DevKron/Kron_Hub/refs/heads/main/version_1.0", Color3.fromRGB(255, 200, 0))

    addCategory("🚀 БЫСТРЫЙ СБОР / ПОЛЁТ")
    createScriptButton("RexBR Hub (Fly+Collect)", "https://pastebin.com/raw/pCMCfnmV", Color3.fromRGB(0, 200, 150))
    createScriptButton("ETFB (Tsunami Brainrot)", "https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots", Color3.fromRGB(0, 150, 200))

    -- ===== ВКЛАДКА 3: МУЗЫКА =====
    local musicScroll = Instance.new("ScrollingFrame")
    musicScroll.Size = UDim2.new(1, 0, 1, 0)
    musicScroll.BackgroundTransparency = 1
    musicScroll.ScrollBarThickness = 5
    musicScroll.Visible = false
    musicScroll.Parent = contentFrame

    local musicLayout = Instance.new("UIListLayout")
    musicLayout.Padding = UDim.new(0, 10)
    musicLayout.Parent = musicScroll

    local nowPlaying = Instance.new("TextLabel")
    nowPlaying.Size = UDim2.new(1, -10, 0, 40)
    nowPlaying.BackgroundColor3 = colors.card
    nowPlaying.BackgroundTransparency = 0.3
    nowPlaying.Text = "🎵 Сейчас: не играет"
    nowPlaying.TextColor3 = colors.textDim
    nowPlaying.TextSize = 12
    nowPlaying.Parent = musicScroll
    nowPlaying.TextWrapped = true

    local nowCorner = Instance.new("UICorner")
    nowCorner.CornerRadius = UDim.new(0, 12)
    nowCorner.Parent = nowPlaying

    local controls = Instance.new("Frame")
    controls.Size = UDim2.new(1, -10, 0, 50)
    controls.BackgroundColor3 = colors.card
    controls.BackgroundTransparency = 0.3
    controls.Parent = musicScroll

    local controlCorner = Instance.new("UICorner")
    controlCorner.CornerRadius = UDim.new(0, 12)
    controlCorner.Parent = controls

    local playBtn = Instance.new("TextButton")
    playBtn.Size = UDim2.new(0, 80, 0, 40)
    playBtn.Position = UDim2.new(0.5, -130, 0.5, -20)
    playBtn.BackgroundColor3 = colors.green
    playBtn.Text = "▶ ИГРАТЬ"
    playBtn.TextColor3 = colors.text
    playBtn.TextSize = 14
    playBtn.Font = Enum.Font.GothamBold
    playBtn.Parent = controls

    local playCorner = Instance.new("UICorner")
    playCorner.CornerRadius = UDim.new(0, 10)
    playCorner.Parent = playBtn

    local stopCtrl = Instance.new("TextButton")
    stopCtrl.Size = UDim2.new(0, 80, 0, 40)
    stopCtrl.Position = UDim2.new(0.5, -40, 0.5, -20)
    stopCtrl.BackgroundColor3 = colors.red
    stopCtrl.Text = "⏹ СТОП"
    stopCtrl.TextColor3 = colors.text
    stopCtrl.TextSize = 14
    stopCtrl.Font = Enum.Font.GothamBold
    stopCtrl.Parent = controls

    local stopCorner = Instance.new("UICorner")
    stopCorner.CornerRadius = UDim.new(0, 10)
    stopCorner.Parent = stopCtrl

    local volDown = Instance.new("TextButton")
    volDown.Size = UDim2.new(0, 50, 0, 40)
    volDown.Position = UDim2.new(1, -110, 0.5, -20)
    volDown.BackgroundColor3 = colors.accent
    volDown.Text = "🔉"
    volDown.TextColor3 = colors.text
    volDown.TextSize = 20
    volDown.Font = Enum.Font.GothamBold
    volDown.Parent = controls

    local volDownCorner = Instance.new("UICorner")
    volDownCorner.CornerRadius = UDim.new(0, 10)
    volDownCorner.Parent = volDown

    local volUp = Instance.new("TextButton")
    volUp.Size = UDim2.new(0, 50, 0, 40)
    volUp.Position = UDim2.new(1, -50, 0.5, -20)
    volUp.BackgroundColor3 = colors.accent
    volUp.Text = "🔊"
    volUp.TextColor3 = colors.text
    volUp.TextSize = 20
    volUp.Font = Enum.Font.GothamBold
    volUp.Parent = controls

    local volUpCorner = Instance.new("UICorner")
    volUpCorner.CornerRadius = UDim.new(0, 10)
    volUpCorner.Parent = volUp

    playBtn.MouseButton1Click:Connect(function()
        if songIDs[1] then
            playMusic(songIDs[1].id)
            nowPlaying.Text = "🎵 Сейчас: " .. songIDs[1].name
        end
    end)

    stopCtrl.MouseButton1Click:Connect(function()
        stopMusic()
        nowPlaying.Text = "🎵 Сейчас: не играет"
    end)

    volDown.MouseButton1Click:Connect(function()
        local newVol = player.Volume - 0.1
        setVolume(newVol)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Музыка",
            Text = "Громкость: " .. math.floor(newVol * 100) .. "%",
            Duration = 1
        })
    end)

    volUp.MouseButton1Click:Connect(function()
        local newVol = player.Volume + 0.1
        setVolume(newVol)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Музыка",
            Text = "Громкость: " .. math.floor(newVol * 100) .. "%",
            Duration = 1
        })
    end)

    for _, song in ipairs(songIDs) do
        local songBtn = Instance.new("TextButton")
        songBtn.Size = UDim2.new(1, -10, 0, 45)
        songBtn.BackgroundColor3 = colors.card
        songBtn.BackgroundTransparency = 0.3
        songBtn.Text = "🎵 " .. song.name
        songBtn.TextColor3 = colors.text
        songBtn.TextSize = 12
        songBtn.TextXAlignment = Enum.TextXAlignment.Left
        songBtn.Font = Enum.Font.Gotham
        songBtn.Parent = musicScroll
        
        local songCorner = Instance.new("UICorner")
        songCorner.CornerRadius = UDim.new(0, 10)
        songCorner.Parent = songBtn
        
        songBtn.MouseButton1Click:Connect(function()
            playMusic(song.id)
            nowPlaying.Text = "🎵 Сейчас: " .. song.name
        end)
    end

    -- Обновление высоты скроллов
    local function updateScrollHeight(scroll, increase)
        task.wait(0.05)
        local h = 10
        for _, child in pairs(scroll:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") then
                h = h + child.Size.Y.Offset + 10
            end
        end
        scroll.CanvasSize = UDim2.new(0, 0, 0, h + 50)
    end

    updateScrollHeight(menuScroll)
    updateScrollHeight(scriptsScroll)
    updateScrollHeight(musicScroll)

    -- Переключение вкладок
    local function switchTab(tab)
        if tab == 1 then
            menuScroll.Visible = true
            scriptsScroll.Visible = false
            musicScroll.Visible = false
            tab1.BackgroundColor3 = colors.tabActive
            tab2.BackgroundColor3 = colors.tabInactive
            tab3.BackgroundColor3 = colors.tabInactive
        elseif tab == 2 then
            menuScroll.Visible = false
            scriptsScroll.Visible = true
            musicScroll.Visible = false
            tab1.BackgroundColor3 = colors.tabInactive
            tab2.BackgroundColor3 = colors.tabActive
            tab3.BackgroundColor3 = colors.tabInactive
            updateScrollHeight(scriptsScroll)
        elseif tab == 3 then
            menuScroll.Visible = false
            scriptsScroll.Visible = false
            musicScroll.Visible = true
            tab1.BackgroundColor3 = colors.tabInactive
            tab2.BackgroundColor3 = colors.tabInactive
            tab3.BackgroundColor3 = colors.tabActive
            updateScrollHeight(musicScroll)
        end
    end

    tab1.MouseButton1Click:Connect(function() switchTab(1) end)
    tab2.MouseButton1Click:Connect(function() switchTab(2) end)
    tab3.MouseButton1Click:Connect(function() switchTab(3) end)

    -- Перетаскивание окна
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
            animate(mainFrame, {Size = UDim2.new(0, 60, 0, 55)}, 0.3)
            animate(mainFrame, {Position = UDim2.new(1, -70, 0, 60)}, 0.3)
            closeBtn.Text = "+"
            tabsFrame.Visible = false
            contentFrame.Visible = false
        end
    end)

    animate(mainFrame, {BackgroundTransparency = 0.05}, 0.3)
    updateScrollHeight(scriptsScroll)
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "MANscript",
        Text = "Хаб с вкладками загружен!",
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