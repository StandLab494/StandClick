-- ========================
-- MANscript Hub (Final)
-- @MANscript | 4 вкладки, счётчик, язык, темы
-- ========================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")

-- ===== ПЕРЕМЕННЫЕ =====
local currentLanguage = "RU"
local currentTheme = "purple"
local animationsEnabled = true
local soundEnabled = true
local totalRuns = 0

-- ===== ЗАГРУЗКА / СОХРАНЕНИЕ СТАТИСТИКИ =====
local function loadStats()
    local success, data = pcall(function()
        return readfile("MANscript_stats.json")
    end)
    if success and data then
        local decoded = HttpService:JSONDecode(data)
        totalRuns = decoded.totalRuns or 0
    else
        totalRuns = 0
    end
end

local function saveStats()
    pcall(function()
        local data = HttpService:JSONEncode({totalRuns = totalRuns})
        writefile("MANscript_stats.json", data)
    end)
end

loadStats()

-- ===== ТЕМЫ =====
local themes = {
    red = {main = Color3.fromRGB(180, 50, 50), accent = Color3.fromRGB(220, 80, 80)},
    blue = {main = Color3.fromRGB(50, 100, 200), accent = Color3.fromRGB(80, 130, 230)},
    green = {main = Color3.fromRGB(50, 180, 80), accent = Color3.fromRGB(80, 210, 110)},
    purple = {main = Color3.fromRGB(120, 50, 200), accent = Color3.fromRGB(150, 80, 230)},
    orange = {main = Color3.fromRGB(220, 120, 40), accent = Color3.fromRGB(250, 150, 70)}
}

-- ===== ЯЗЫКИ =====
local lang = {
    RU = {
        menu = "📊 Меню",
        scripts = "🎮 Скрипты",
        settings = "⚙️ Настройки",
        theme = "🎨 Цвет темы",
        nickname = "Ваш ник",
        userid = "ID пользователя",
        accountAge = "Аккаунт создан",
        days = "дней",
        totalPlayers = "Всего игроков",
        ping = "Пинг",
        totalRuns = "Запусков скриптов",
        resetStats = "Сбросить статистику",
        language = "Язык",
        animations = "Анимации",
        sounds = "Звуки кликов",
        themeSelect = "Выберите тему",
        back = "Назад",
        save = "Сохранить",
        start = "СТАРТ",
        clickToStart = "нажми чтобы запустить →",
        statResetDone = "Статистика сброшена",
        selectThemeFirst = "Сначала выберите тему",
        needRestart = "Перезапустите хаб",
        catShooters = "⚔️ ШУТЕРЫ И PVP",
        catRPG = "🎮 РПГ И ФАРМ",
        catFast = "🚀 ПОЛЁТ И БЫСТРЫЙ СБОР"
    },
    EN = {
        menu = "📊 Menu",
        scripts = "🎮 Scripts",
        settings = "⚙️ Settings",
        theme = "🎨 Color Theme",
        nickname = "Your nickname",
        userid = "User ID",
        accountAge = "Account created",
        days = "days",
        totalPlayers = "Total players",
        ping = "Ping",
        totalRuns = "Script runs",
        resetStats = "Reset stats",
        language = "Language",
        animations = "Animations",
        sounds = "Click sounds",
        themeSelect = "Select theme",
        back = "Back",
        save = "Save",
        start = "START",
        clickToStart = "click to start →",
        statResetDone = "Stats reset",
        selectThemeFirst = "Select theme first",
        needRestart = "Restart the hub",
        catShooters = "⚔️ SHOOTERS & PVP",
        catRPG = "🎮 RPG & FARM",
        catFast = "🚀 FLY & FAST COLLECT"
    }
}

local function getText(key)
    return lang[currentLanguage][key] or key
end

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
warningFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
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
acceptBtn.BackgroundColor3 = themes.green.main
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

    local function applyTheme()
        local theme = themes[currentTheme]
        if not theme then return end
        for _, tab in pairs({tab1, tab2, tab3, tab4}) do
            if tab.BackgroundColor3 ~= theme.main then
                if tab.Text == getText("menu") or tab.Text == getText("scripts") or tab.Text == getText("settings") or tab.Text == getText("theme") then
                    -- активная вкладка будет другого цвета
                else
                    tab.BackgroundColor3 = theme.accent
                end
            end
        end
    end

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 380, 0, 560)
    mainFrame.Position = UDim2.new(0, 10, 0, 60)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 18)
    mainCorner.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 55)
    titleBar.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 18)
    titleCorner.Parent = titleBar

    local avatarIcon = Instance.new("ImageLabel")
    avatarIcon.Size = UDim2.new(0, 36, 0, 36)
    avatarIcon.Position = UDim2.new(0, 12, 0, 9)
    avatarIcon.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
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
    titleText.TextColor3 = Color3.fromRGB(240, 240, 240)
    titleText.TextSize = 18
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Font = Enum.Font.GothamBold
    titleText.Parent = titleBar

    local tgBtn = Instance.new("TextButton")
    tgBtn.Size = UDim2.new(0, 70, 0, 32)
    tgBtn.Position = UDim2.new(1, -130, 0.5, -16)
    tgBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    tgBtn.Text = "📢 ТГК"
    tgBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
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
    closeBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    closeBtn.Text = "−"
    closeBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
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
    tab1.Size = UDim2.new(0.25, 0, 1, 0)
    tab1.Position = UDim2.new(0, 0, 0, 0)
    tab1.BackgroundColor3 = themes[currentTheme].main
    tab1.Text = getText("menu")
    tab1.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab1.TextSize = 12
    tab1.Font = Enum.Font.GothamBold
    tab1.BorderSizePixel = 0
    tab1.Parent = tabsFrame

    local tab2 = Instance.new("TextButton")
    tab2.Size = UDim2.new(0.25, 0, 1, 0)
    tab2.Position = UDim2.new(0.25, 0, 0, 0)
    tab2.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    tab2.Text = getText("scripts")
    tab2.TextColor3 = Color3.fromRGB(240, 240, 240)
    tab2.TextSize = 12
    tab2.Font = Enum.Font.GothamBold
    tab2.BorderSizePixel = 0
    tab2.Parent = tabsFrame

    local tab3 = Instance.new("TextButton")
    tab3.Size = UDim2.new(0.25, 0, 1, 0)
    tab3.Position = UDim2.new(0.5, 0, 0, 0)
    tab3.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    tab3.Text = getText("settings")
    tab3.TextColor3 = Color3.fromRGB(240, 240, 240)
    tab3.TextSize = 12
    tab3.Font = Enum.Font.GothamBold
    tab3.BorderSizePixel = 0
    tab3.Parent = tabsFrame

    local tab4 = Instance.new("TextButton")
    tab4.Size = UDim2.new(0.25, 0, 1, 0)
    tab4.Position = UDim2.new(0.75, 0, 0, 0)
    tab4.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    tab4.Text = getText("theme")
    tab4.TextColor3 = Color3.fromRGB(240, 240, 240)
    tab4.TextSize = 12
    tab4.Font = Enum.Font.GothamBold
    tab4.BorderSizePixel = 0
    tab4.Parent = tabsFrame

    -- Контент для вкладок
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -115)
    contentFrame.Position = UDim2.new(0, 10, 0, 105)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    -- ===== ВКЛАДКА 1: МЕНЮ =====
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
        card.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
        card.BackgroundTransparency = 0.3
        card.Parent = menuScroll
        
        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, 12)
        cardCorner.Parent = card
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, 45, 1, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
        iconLabel.TextSize = 28
        iconLabel.Font = Enum.Font.Gotham
        iconLabel.Parent = card
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -60, 0, 25)
        titleLabel.Position = UDim2.new(0, 55, 0, 8)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = Color3.fromRGB(160, 160, 170)
        titleLabel.TextSize = 12
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.Gotham
        titleLabel.Parent = card
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(1, -60, 0, 25)
        valueLabel.Position = UDim2.new(0, 55, 0, 30)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = value
        valueLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
        valueLabel.TextSize = 16
        valueLabel.TextXAlignment = Enum.TextXAlignment.Left
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.Parent = card
    end

    addMenuCard(getText("nickname"), LocalPlayer.Name, "👤")
    addMenuCard(getText("userid"), LocalPlayer.UserId, "🆔")
    addMenuCard(getText("accountAge"), LocalPlayer.AccountAge .. " " .. getText("days"), "📅")
    addMenuCard(getText("totalPlayers"), #Players:GetPlayers(), "🌍")
    addMenuCard(getText("ping"), "0 ms", "📶")
    addMenuCard(getText("totalRuns"), totalRuns, "🔥")

    local pingLabel = nil
    local playersLabel = nil
    local runsLabel = nil
    
    for _, child in pairs(menuScroll:GetChildren()) do
        if child:IsA("Frame") then
            local titleObj = child:FindFirstChildOfClass("TextLabel")
            if titleObj then
                if titleObj.Text == getText("ping") then
                    for _, v in pairs(child:GetChildren()) do
                        if v:IsA("TextLabel") and v.TextSize == 16 then pingLabel = v end
                    end
                end
                if titleObj.Text == getText("totalPlayers") then
                    for _, v in pairs(child:GetChildren()) do
                        if v:IsA("TextLabel") and v.TextSize == 16 then playersLabel = v end
                    end
                end
                if titleObj.Text == getText("totalRuns") then
                    for _, v in pairs(child:GetChildren()) do
                        if v:IsA("TextLabel") and v.TextSize == 16 then runsLabel = v end
                    end
                end
            end
        end
    end
    
    task.spawn(function()
        while menuScroll.Visible and menuScroll.Parent do
            task.wait(1)
            if pingLabel then 
                local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
                pingLabel.Text = math.floor(ping) .. " ms"
            end
            if playersLabel then playersLabel.Text = #Players:GetPlayers() end
            if runsLabel then runsLabel.Text = totalRuns end
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

    local function addScriptCategory(title)
        local cat = Instance.new("Frame")
        cat.Size = UDim2.new(1, -10, 0, 40)
        cat.BackgroundTransparency = 1
        cat.Parent = scriptsScroll
        
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 2)
        line.Position = UDim2.new(0, 0, 1, -2)
        line.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
        line.BorderSizePixel = 0
        line.Parent = cat
        
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = title
        text.TextColor3 = Color3.fromRGB(200, 200, 210)
        text.TextSize = 14
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.Font = Enum.Font.GothamBold
        text.Parent = cat
    end

    local function addScriptButton(name, url, color, icon)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 55)
        btn.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
        btn.BackgroundTransparency = 0.3
        btn.Text = ""
        btn.BorderSizePixel = 0
        btn.Parent = scriptsScroll
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 12)
        btnCorner.Parent = btn
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, 45, 1, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
        iconLabel.TextSize = 24
        iconLabel.Font = Enum.Font.Gotham
        iconLabel.Parent = btn
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -100, 0, 25)
        nameLabel.Position = UDim2.new(0, 55, 0, 8)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = name
        nameLabel.TextColor3 = Color3.fromRGB(235, 235, 245)
        nameLabel.TextSize = 14
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = btn
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(1, -100, 0, 18)
        descLabel.Position = UDim2.new(0, 55, 0, 30)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = getText("clickToStart")
        descLabel.TextColor3 = Color3.fromRGB(130, 130, 150)
        descLabel.TextSize = 10
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Font = Enum.Font.Gotham
        descLabel.Parent = btn
        
        local runBtn = Instance.new("TextButton")
        runBtn.Size = UDim2.new(0, 80, 0, 36)
        runBtn.Position = UDim2.new(1, -90, 0.5, -18)
        runBtn.BackgroundColor3 = color or Color3.fromRGB(0, 130, 80)
        runBtn.Text = getText("start")
        runBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        runBtn.TextSize = 12
        runBtn.Font = Enum.Font.GothamBold
        runBtn.BorderSizePixel = 0
        runBtn.Parent = btn
        
        local runCorner = Instance.new("UICorner")
        runCorner.CornerRadius = UDim.new(0, 8)
        runCorner.Parent = runBtn
        
        runBtn.MouseButton1Click:Connect(function()
            totalRuns = totalRuns + 1
            saveStats()
            pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            game.StarterGui:SetCore("SendNotification", {
                Title = "MANscript",
                Text = name .. " " .. getText("start"),
                Duration = 2
            })
        end)
    end

    addScriptCategory(getText("catShooters"))
    addScriptButton("BloxStrike", "https://raw.githubusercontent.com/polo242c/bloxstrike/refs/heads/main/blox", Color3.fromRGB(200, 80, 80), "⚡")
    addScriptButton("Dead Rails", "https://raw.githubusercontent.com/hungquan99/HungHub/main/loader.lua", Color3.fromRGB(100, 100, 200), "💀")
    addScriptButton("TSB (The Strongest Battlegrounds)", "https://raw.githubusercontent.com/COOLXPLO/DP-HUB-coolxplo/refs/heads/main/TSB.lua", Color3.fromRGB(200, 150, 50), "🥊")
    addScriptButton("Rivals", "https://soluna-script.vercel.app/main.lua", Color3.fromRGB(100, 150, 200), "🎯")
    addScriptButton("Evade", "https://raw.githubusercontent.com/thesigmacorex/Flashware/main/script", Color3.fromRGB(255, 100, 0), "🏃")

    addScriptCategory(getText("catRPG"))
    addScriptButton("Blox Fruit", "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua", Color3.fromRGB(0, 150, 100), "🍎")
    addScriptButton("Forsaken", "https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua", Color3.fromRGB(180, 120, 0), "🎭")
    addScriptButton("99 Nights", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", Color3.fromRGB(120, 60, 180), "🌙")
    addScriptButton("Bee Swarm Simulator", "https://raw.githubusercontent.com/DevKron/Kron_Hub/refs/heads/main/version_1.0", Color3.fromRGB(255, 200, 0), "🐝")

    addScriptCategory(getText("catFast"))
    addScriptButton("RexBR Hub (Fly+Collect)", "https://pastebin.com/raw/pCMCfnmV", Color3.fromRGB(0, 200, 150), "🚀")
    addScriptButton("ETFB (Escape Tsunami Brainrot)", "https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots", Color3.fromRGB(0, 150, 200), "🌊")
    addScriptButton("Steal a Brainrot (Duels)", "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/DUELWorld.lua", Color3.fromRGB(150, 50, 100), "🧠")

    -- ===== ВКЛАДКА 3: НАСТРОЙКИ =====
    local settingsScroll = Instance.new("ScrollingFrame")
    settingsScroll.Size = UDim2.new(1, 0, 1, 0)
    settingsScroll.BackgroundTransparency = 1
    settingsScroll.ScrollBarThickness = 5
    settingsScroll.Visible = false
    settingsScroll.Parent = contentFrame

    local settingsLayout = Instance.new("UIListLayout")
    settingsLayout.Padding = UDim.new(0, 10)
    settingsLayout.Parent = settingsScroll

    local function addSettingsButton(text, color, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 55)
        btn.BackgroundColor3 = color or Color3.fromRGB(28, 28, 35)
        btn.BackgroundTransparency = 0.3
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(240, 240, 240)
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.Parent = settingsScroll
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 12)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(callback)
    end

    local function addSettingsToggle(text, settingName, defaultValue)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -10, 0, 55)
        frame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
        frame.BackgroundTransparency = 0.3
        frame.Parent = settingsScroll
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 12)
        frameCorner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -80, 0, 25)
        label.Position = UDim2.new(0, 15, 0, 15)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(240, 240, 240)
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.GothamBold
        label.Parent = frame
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 70, 0, 36)
        toggleBtn.Position = UDim2.new(1, -80, 0.5, -18)
        toggleBtn.BackgroundColor3 = defaultValue and Color3.fromRGB(0, 130, 80) or Color3.fromRGB(130, 50, 50)
        toggleBtn.Text = defaultValue and "ON" or "OFF"
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleBtn.TextSize = 14
        toggleBtn.Font = Enum.Font.GothamBold
        toggleBtn.BorderSizePixel = 0
        toggleBtn.Parent = frame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = toggleBtn
        
        local state = defaultValue
        toggleBtn.MouseButton1Click:Connect(function()
            state = not state
            toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 130, 80) or Color3.fromRGB(130, 50, 50)
            toggleBtn.Text = state and "ON" or "OFF"
            if settingName == "animations" then animationsEnabled = state
            elseif settingName == "sounds" then soundEnabled = state end
        end)
    end

    addSettingsToggle(getText("animations"), "animations", true)
    addSettingsToggle(getText("sounds"), "sounds", true)
    
    addSettingsButton(getText("resetStats"), Color3.fromRGB(200, 80, 80), function()
        totalRuns = 0
        saveStats()
        game.StarterGui:SetCore("SendNotification", {
            Title = "MANscript",
            Text = getText("statResetDone"),
            Duration = 2
        })
        if runsLabel then runsLabel.Text = totalRuns end
    end)

    -- ===== ВКЛАДКА 4: ЦВЕТ ТЕМЫ =====
    local themeScroll = Instance.new("ScrollingFrame")
    themeScroll.Size = UDim2.new(1, 0, 1, 0)
    themeScroll.BackgroundTransparency = 1
    themeScroll.ScrollBarThickness = 5
    themeScroll.Visible = false
    themeScroll.Parent = contentFrame

    local themeLayout = Instance.new("UIListLayout")
    themeLayout.Padding = UDim.new(0, 10)
    themeLayout.Parent = themeScroll

    local themeColors = {
        {name = "🔴 Красный", key = "red"},
        {name = "🔵 Синий", key = "blue"},
        {name = "🟢 Зелёный", key = "green"},
        {name = "🟣 Фиолетовый", key = "purple"},
        {name = "🟠 Оранжевый", key = "orange"}
    }

    for _, theme in ipairs(themeColors) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 55)
        btn.BackgroundColor3 = themes[theme.key].main
        btn.BackgroundTransparency = 0.3
        btn.Text = theme.name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.Parent = themeScroll
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 12)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            currentTheme = theme.key
            local themeData = themes[currentTheme]
            tab1.BackgroundColor3 = themeData.main
            for _, btn in pairs({tgBtn, closeBtn}) do
                btn.BackgroundColor3 = themeData.accent
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "MANscript",
                Text = getText("themeSelect") .. ": " .. theme.name,
                Duration = 2
            })
        end)
    end

    -- Обновление высоты скроллов
    local function updateScrollHeight(scroll)
        task.wait(0.1)
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
    updateScrollHeight(settingsScroll)
    updateScrollHeight(themeScroll)

    -- Переключение вкладок с обновлением текста
    local function updateTabTexts()
        tab1.Text = getText("menu")
        tab2.Text = getText("scripts")
        tab3.Text = getText("settings")
        tab4.Text = getText("theme")
    end

    local function switchTab(tab)
        if tab == 1 then
            menuScroll.Visible = true
            scriptsScroll.Visible = false
            settingsScroll.Visible = false
            themeScroll.Visible = false
            tab1.BackgroundColor3 = themes[currentTheme].main
            tab2.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab3.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab4.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        elseif tab == 2 then
            menuScroll.Visible = false
            scriptsScroll.Visible = true
            settingsScroll.Visible = false
            themeScroll.Visible = false
            tab1.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab2.BackgroundColor3 = themes[currentTheme].main
            tab3.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab4.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            updateScrollHeight(scriptsScroll)
        elseif tab == 3 then
            menuScroll.Visible = false
            scriptsScroll.Visible = false
            settingsScroll.Visible = true
            themeScroll.Visible = false
            tab1.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab2.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab3.BackgroundColor3 = themes[currentTheme].main
            tab4.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            updateScrollHeight(settingsScroll)
        elseif tab == 4 then
            menuScroll.Visible = false
            scriptsScroll.Visible = false
            settingsScroll.Visible = false
            themeScroll.Visible = true
            tab1.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab2.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab3.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            tab4.BackgroundColor3 = themes[currentTheme].main
            updateScrollHeight(themeScroll)
        end
    end

    tab1.MouseButton1Click:Connect(function() switchTab(1) end)
    tab2.MouseButton1Click:Connect(function() switchTab(2) end)
    tab3.MouseButton1Click:Connect(function() switchTab(3) end)
    tab4.MouseButton1Click:Connect(function() switchTab(4) end)

    -- Обновление текста при смене языка
    local function updateAllTexts()
        updateTabTexts()
        for _, card in pairs(menuScroll:GetChildren()) do
            if card:IsA("Frame") then
                local titleObj = card:FindFirstChildOfClass("TextLabel")
                if titleObj and titleObj.TextSize == 12 then
                    if titleObj.Text:find(getText("nickname")) then titleObj.Text = getText("nickname")
                    elseif titleObj.Text:find(getText("userid")) then titleObj.Text = getText("userid")
                    elseif titleObj.Text:find(getText("accountAge")) then titleObj.Text = getText("accountAge")
                    elseif titleObj.Text:find(getText("totalPlayers")) then titleObj.Text = getText("totalPlayers")
                    elseif titleObj.Text:find(getText("ping")) then titleObj.Text = getText("ping")
                    elseif titleObj.Text:find(getText("totalRuns")) then titleObj.Text = getText("totalRuns")
                    end
                end
            end
        end
    end

    -- Кнопка смены языка в настройках
    local langBtn = Instance.new("TextButton")
    langBtn.Size = UDim2.new(1, -10, 0, 55)
    langBtn.Position = UDim2.new(0, 5, 0, 120)
    langBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    langBtn.BackgroundTransparency = 0.3
    langBtn.Text = getText("language") .. ": " .. (currentLanguage == "RU" and "Русский" or "English")
    langBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
    langBtn.TextSize = 14
    langBtn.Font = Enum.Font.GothamBold
    langBtn.Parent = settingsScroll

    local langCorner = Instance.new("UICorner")
    langCorner.CornerRadius = UDim.new(0, 12)
    langCorner.Parent = langBtn

    langBtn.MouseButton1Click:Connect(function()
        currentLanguage = currentLanguage == "RU" and "EN" or "RU"
        langBtn.Text = getText("language") .. ": " .. (currentLanguage == "RU" and "Русский" or "English")
        updateAllTexts()
        game.StarterGui:SetCore("SendNotification", {
            Title = "MANscript",
            Text = getText("needRestart"),
            Duration = 2
        })
    end)

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
            local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = fullSize,
                Position = fullPos
            })
            tween:Play()
            closeBtn.Text = "−"
            tabsFrame.Visible = true
            contentFrame.Visible = true
        else
            minimized = true
            local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 60, 0, 55),
                Position = UDim2.new(1, -70, 0, 60)
            })
            tween:Play()
            closeBtn.Text = "+"
            tabsFrame.Visible = false
            contentFrame.Visible = false
        end
    end)

    animate(mainFrame, {BackgroundTransparency = 0.05}, 0.3)
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "MANscript",
        Text = "Хаб загружен! 4 вкладки",
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