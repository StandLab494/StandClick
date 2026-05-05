-- MANscript Hub | Компактная версия 350x200 (все функции)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local VirtualInput = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")

if getgenv().MANSCRIPT_LOADED then return end
getgenv().MANSCRIPT_LOADED = true

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

-- Звук клика
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://9120373326"
clickSound.Volume = 0.4
clickSound.Parent = CoreGui

local soundEnabled = true
local function playClick()
    if soundEnabled then pcall(function() clickSound:Stop(); clickSound:Play() end) end
end

-- ===== ПЕРЕМЕННЫЕ =====
local currentLanguage = "RU"
local currentTheme = "purple"
local animationsEnabled = true
local fpsBoostEnabled = false
local autoRejoinEnabled = false
local antiAFKEnabled = false
local totalRuns = 0

local themes = {
    red = {main = Color3.fromRGB(180, 50, 50), accent = Color3.fromRGB(220, 80, 80)},
    blue = {main = Color3.fromRGB(50, 100, 200), accent = Color3.fromRGB(80, 130, 230)},
    green = {main = Color3.fromRGB(50, 180, 80), accent = Color3.fromRGB(80, 210, 110)},
    purple = {main = Color3.fromRGB(120, 50, 200), accent = Color3.fromRGB(150, 80, 230)},
    orange = {main = Color3.fromRGB(220, 120, 40), accent = Color3.fromRGB(250, 150, 70)}
}

-- TWEAKOS функции
local noclipEnabled = false
local flyEnabled = false
local infiniteJumpEnabled = false
local autoClickEnabled = false
local autoDeliveryEnabled = false
local speedValue = 16
local flyBodyVel = nil
local flyConn = nil
local clickConn = nil
local deliveryPos = nil
local wasHolding = false
local jumpConn = nil
local noclipConn = nil
local noclipBv = nil

local function toggleNoclip(state)
    noclipEnabled = state
    local char = LocalPlayer.Character
    if char then
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = not noclipEnabled
            end
        end
    end
    if noclipEnabled and char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and not noclipBv then
            noclipBv = Instance.new("BodyVelocity")
            noclipBv.MaxForce = Vector3.new(100000, 100000, 100000)
            noclipBv.Parent = hrp
            if noclipConn then noclipConn:Disconnect() end
            noclipConn = RunService.Stepped:Connect(function()
                if not noclipEnabled or not noclipBv then return end
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                if hum then
                    local dir = hum.MoveDirection
                    noclipBv.Velocity = dir * speedValue
                end
            end)
        end
    elseif not noclipEnabled and noclipBv then
        noclipBv:Destroy()
        noclipBv = nil
        if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
    end
end

local function toggleFly(state)
    flyEnabled = state
    if flyEnabled then
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                flyBodyVel = Instance.new("BodyVelocity")
                flyBodyVel.MaxForce = Vector3.new(100000, 100000, 100000)
                flyBodyVel.Parent = hrp
                if flyConn then flyConn:Disconnect() end
                flyConn = RunService.RenderStepped:Connect(function()
                    if not flyEnabled or not flyBodyVel then return end
                    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                    if hum then
                        local dir = hum.MoveDirection
                        flyBodyVel.Velocity = dir * 60
                    end
                end)
            end
        end
    else
        if flyBodyVel then flyBodyVel:Destroy(); flyBodyVel = nil end
        if flyConn then flyConn:Disconnect(); flyConn = nil end
    end
end

local function toggleJump(state)
    infiniteJumpEnabled = state
    if infiniteJumpEnabled and not jumpConn then
        jumpConn = UserInputService.JumpRequest:Connect(function()
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    elseif not infiniteJumpEnabled and jumpConn then
        jumpConn:Disconnect()
        jumpConn = nil
    end
end

local function toggleAutoClick(state)
    autoClickEnabled = state
    if autoClickEnabled and not clickConn then
        clickConn = RunService.RenderStepped:Connect(function()
            if autoClickEnabled then
                pcall(function()
                    VirtualInput:SendMouseButtonEvent(0, 0, 0, true, Enum.UserInputType.MouseButton1, 1)
                    task.wait(0.05)
                    VirtualInput:SendMouseButtonEvent(0, 0, 0, false, Enum.UserInputType.MouseButton1, 1)
                end)
            end
        end)
    elseif not autoClickEnabled and clickConn then
        clickConn:Disconnect()
        clickConn = nil
    end
end

local function toggleAutoDelivery(state)
    autoDeliveryEnabled = state
    if not autoDeliveryEnabled then wasHolding = false end
end

-- FPS Boost
local function setFPSBoost(enabled)
    fpsBoostEnabled = enabled
    if enabled then
        Lighting.FogEnd = 0
        Lighting.FogStart = 999999
        Lighting.GlobalShadows = false
        for _, e in pairs(Lighting:GetChildren()) do
            if e:IsA("BloomEffect") or e:IsA("BlurEffect") then e.Enabled = false end
        end
        task.spawn(function()
            while fpsBoostEnabled and RunService:IsRunning() do
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") then obj.Enabled = false
                    elseif obj:IsA("Decal") then obj.Transparency = 1 end
                end
                task.wait(5)
            end
        end)
    else
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
    end
end

-- Авто-перезаход
local rejoinActive = false
local function startRejoin()
    if rejoinActive then return end
    rejoinActive = true
    task.wait(3)
    rejoinActive = false
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end
game:GetService("CoreGui").ChildRemoved:Connect(function()
    if autoRejoinEnabled and not rejoinActive then
        task.wait(0.5)
        if not game.CoreGui:FindFirstChild("MANscriptMenu") then startRejoin() end
    end
end)

-- Анти-АФК
local antiAFKCon = nil
local function toggleAntiAFK(state)
    antiAFKEnabled = state
    if antiAFKEnabled and not antiAFKCon then
        antiAFKCon = RunService.RenderStepped:Connect(function()
            if antiAFKEnabled then
                local cam = workspace.CurrentCamera
                cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(0.1), 0)
            end
        end)
    elseif not antiAFKEnabled and antiAFKCon then
        antiAFKCon:Disconnect()
        antiAFKCon = nil
    end
end

-- Счётчик запусков
local function loadStats()
    local s, d = pcall(readfile, "MANscript_stats.json")
    if s and d then
        local dec = HttpService:JSONDecode(d)
        totalRuns = dec.totalRuns or 0
        fpsBoostEnabled = dec.fpsBoost or false
        currentTheme = dec.theme or "purple"
        currentLanguage = dec.language or "RU"
        autoRejoinEnabled = dec.autoRejoin or false
        antiAFKEnabled = dec.antiAFK or false
    end
    setFPSBoost(fpsBoostEnabled)
    if antiAFKEnabled then toggleAntiAFK(true) end
end
local function saveStats()
    pcall(function()
        writefile("MANscript_stats.json", HttpService:JSONEncode({
            totalRuns = totalRuns, fpsBoost = fpsBoostEnabled, theme = currentTheme,
            language = currentLanguage, autoRejoin = autoRejoinEnabled, antiAFK = antiAFKEnabled
        }))
    end)
end
loadStats()

-- Языки
local lang = {
    RU = {
        menu = "📊 Меню", scripts = "🎮 Скрипты", settings = "⚙️ Настройки", tweaks = "🛠️ Твики",
        nickname = "Ваш ник", userid = "ID", accountAge = "Аккаунт", days = "дней",
        totalPlayers = "Игроков", ping = "Пинг", totalRuns = "Запусков", fps = "FPS",
        fpsBoost = "FPS Boost", autoRejoin = "Авто-перезаход", antiAFK = "Анти-АФК",
        resetStats = "Сброс статистики", language = "Язык", sounds = "Звуки",
        noclip = "Noclip", fly = "Полёт", jump = "Беск. прыжки", autoclick = "Автоклик",
        autodelivery = "Авто-сдача", setdelivery = "Уст. сдачу", speed = "Скорость",
        start = "СТАРТ", clickToStart = "нажми чтобы запустить →",
        catShooters = "⚔️ ШУТЕРЫ", catRPG = "🎮 РПГ", catFast = "🚀 СБОР/ПОЛЁТ", catMM2 = "🔪 MM2"
    },
    EN = {
        menu = "📊 Menu", scripts = "🎮 Scripts", settings = "⚙️ Settings", tweaks = "🛠️ Tweaks",
        nickname = "Nickname", userid = "ID", accountAge = "Account", days = "days",
        totalPlayers = "Players", ping = "Ping", totalRuns = "Runs", fps = "FPS",
        fpsBoost = "FPS Boost", autoRejoin = "Auto Rejoin", antiAFK = "Anti-AFK",
        resetStats = "Reset stats", language = "Language", sounds = "Sounds",
        noclip = "Noclip", fly = "Fly", jump = "Inf Jump", autoclick = "Auto Click",
        autodelivery = "Auto Delivery", setdelivery = "Set delivery", speed = "Speed",
        start = "START", clickToStart = "click to start →",
        catShooters = "⚔️ SHOOTERS", catRPG = "🎮 RPG", catFast = "🚀 FLY/COLLECT", catMM2 = "🔪 MM2"
    }
}
local function getText(key) return lang[currentLanguage][key] or key end

-- Очистка
for _, v in pairs(CoreGui:GetChildren()) do if v.Name == "MANscriptMenu" then v:Destroy() end end

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
titleText.TextSize = 14
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
tab1.Text = getText("menu")
tab1.TextColor3 = colors.text
tab1.TextSize = 10
tab1.Font = Enum.Font.GothamBold
tab1.BorderSizePixel = 0
tab1.Parent = tabsFrame

local tab2 = Instance.new("TextButton")
tab2.Size = UDim2.new(0.25, 0, 1, 0)
tab2.Position = UDim2.new(0.25, 0, 0, 0)
tab2.BackgroundColor3 = colors.tabInactive
tab2.Text = getText("scripts")
tab2.TextColor3 = colors.text
tab2.TextSize = 10
tab2.Font = Enum.Font.GothamBold
tab2.BorderSizePixel = 0
tab2.Parent = tabsFrame

local tab3 = Instance.new("TextButton")
tab3.Size = UDim2.new(0.25, 0, 1, 0)
tab3.Position = UDim2.new(0.5, 0, 0, 0)
tab3.BackgroundColor3 = colors.tabInactive
tab3.Text = getText("settings")
tab3.TextColor3 = colors.text
tab3.TextSize = 10
tab3.Font = Enum.Font.GothamBold
tab3.BorderSizePixel = 0
tab3.Parent = tabsFrame

local tab4 = Instance.new("TextButton")
tab4.Size = UDim2.new(0.25, 0, 1, 0)
tab4.Position = UDim2.new(0.75, 0, 0, 0)
tab4.BackgroundColor3 = colors.tabInactive
tab4.Text = getText("tweaks")
tab4.TextColor3 = colors.text
tab4.TextSize = 10
tab4.Font = Enum.Font.GothamBold
tab4.BorderSizePixel = 0
tab4.Parent = tabsFrame

-- Контент
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -16, 1, -90)
contentFrame.Position = UDim2.new(0, 8, 0, 80)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Вкладка 1: Меню
local menuScroll = Instance.new("ScrollingFrame")
menuScroll.Size = UDim2.new(1, 0, 1, 0)
menuScroll.BackgroundTransparency = 1
menuScroll.ScrollBarThickness = 3
menuScroll.Visible = true
menuScroll.Parent = contentFrame
local menuLayout = Instance.new("UIListLayout")
menuLayout.Padding = UDim.new(0, 6)
menuLayout.Parent = menuScroll

local function addMenuCard(title, value, icon)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 36)
    card.BackgroundColor3 = colors.card
    card.BackgroundTransparency = 0.3
    card.Parent = menuScroll
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = card
    local iconL = Instance.new("TextLabel")
    iconL.Size = UDim2.new(0, 30, 1, 0)
    iconL.BackgroundTransparency = 1
    iconL.Text = icon
    iconL.TextColor3 = colors.text
    iconL.TextSize = 16
    iconL.Font = Enum.Font.Gotham
    iconL.Parent = card
    local titleL = Instance.new("TextLabel")
    titleL.Size = UDim2.new(1, -90, 0, 18)
    titleL.Position = UDim2.new(0, 35, 0, 4)
    titleL.BackgroundTransparency = 1
    titleL.Text = title
    titleL.TextColor3 = colors.textDim
    titleL.TextSize = 10
    titleL.TextXAlignment = Enum.TextXAlignment.Left
    titleL.Font = Enum.Font.Gotham
    titleL.Parent = card
    local valL = Instance.new("TextLabel")
    valL.Size = UDim2.new(1, -90, 0, 18)
    valL.Position = UDim2.new(0, 35, 0, 18)
    valL.BackgroundTransparency = 1
    valL.Text = value
    valL.TextColor3 = colors.text
    valL.TextSize = 12
    valL.TextXAlignment = Enum.TextXAlignment.Left
    valL.Font = Enum.Font.GothamBold
    valL.Parent = card
    return valL
end

local nickVal = addMenuCard(getText("nickname"), LocalPlayer.Name, "👤")
local idVal = addMenuCard(getText("userid"), LocalPlayer.UserId, "🆔")
local ageVal = addMenuCard(getText("accountAge"), LocalPlayer.AccountAge .. " " .. getText("days"), "📅")
local playersVal = addMenuCard(getText("totalPlayers"), #Players:GetPlayers(), "🌍")
local pingVal = addMenuCard(getText("ping"), "0 ms", "📶")
local fpsVal = addMenuCard(getText("fps"), "0", "🎮")
local runsVal = addMenuCard(getText("totalRuns"), totalRuns, "🔥")

local lastTime = tick()
task.spawn(function()
    while menuScroll.Visible do
        task.wait(0.5)
        local now = tick()
        local fps = math.floor(1 / (now - lastTime))
        lastTime = now
        fpsVal.Text = fps .. " FPS"
        pingVal.Text = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) .. " ms"
        playersVal.Text = #Players:GetPlayers()
        runsVal.Text = totalRuns
    end
end)

-- Вкладка 2: Скрипты
local scriptsScroll = Instance.new("ScrollingFrame")
scriptsScroll.Size = UDim2.new(1, 0, 1, 0)
scriptsScroll.BackgroundTransparency = 1
scriptsScroll.ScrollBarThickness = 3
scriptsScroll.Visible = false
scriptsScroll.Parent = contentFrame
local scriptsLayout = Instance.new("UIListLayout")
scriptsLayout.Padding = UDim.new(0, 6)
scriptsLayout.Parent = scriptsScroll

local function addScriptCategory(title)
    local cat = Instance.new("Frame")
    cat.Size = UDim2.new(1, 0, 0, 28)
    cat.BackgroundTransparency = 1
    cat.Parent = scriptsScroll
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = colors.accent
    line.Parent = cat
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = title
    text.TextColor3 = colors.textDim
    text.TextSize = 11
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.Font = Enum.Font.GothamBold
    text.Parent = cat
end

local function addScriptButton(name, url, color, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = colors.card
    btn.BackgroundTransparency = 0.3
    btn.Text = icon .. "  " .. name
    btn.TextColor3 = colors.text
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
    btn.Parent = scriptsScroll
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    btn.MouseButton1Click:Connect(function()
        playClick()
        totalRuns = totalRuns + 1
        saveStats()
        pcall(function() loadstring(game:HttpGet(url))() end)
    end)
end

addScriptCategory(getText("catShooters"))
addScriptButton("BloxStrike", "https://raw.githubusercontent.com/polo242c/bloxstrike/refs/heads/main/blox", nil, "⚡")
addScriptButton("Dead Rails", "https://raw.githubusercontent.com/hungquan99/HungHub/main/loader.lua", nil, "💀")
addScriptButton("TSB", "https://raw.githubusercontent.com/COOLXPLO/DP-HUB-coolxplo/refs/heads/main/TSB.lua", nil, "🥊")
addScriptButton("Rivals", "https://soluna-script.vercel.app/main.lua", nil, "🎯")
addScriptButton("Evade", "https://raw.githubusercontent.com/thesigmacorex/Flashware/main/script", nil, "🏃")
addScriptCategory(getText("catRPG"))
addScriptButton("Blox Fruit", "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua", nil, "🍎")
addScriptButton("Forsaken", "https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua", nil, "🎭")
addScriptButton("99 Nights", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", nil, "🌙")
addScriptButton("Bee Swarm Simulator", "https://raw.githubusercontent.com/DevKron/Kron_Hub/refs/heads/main/version_1.0", nil, "🐝")
addScriptCategory(getText("catFast"))
addScriptButton("RexBR Hub", "https://pastebin.com/raw/pCMCfnmV", nil, "🚀")
addScriptButton("ETFB", "https://raw.githubusercontent.com/gumanba/Scripts/main/EscapeTsunamiForBrainrots", nil, "🌊")
addScriptButton("Steal a Brainrot", "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/DUELWorld.lua", nil, "🧠")
addScriptCategory(getText("catMM2"))
addScriptButton("Cherruscript (MM2)", "https://pastefy.app/btnXJiBS/raw", nil, "🔪")

-- Вкладка 3: Настройки
local settingsScroll = Instance.new("ScrollingFrame")
settingsScroll.Size = UDim2.new(1, 0, 1, 0)
settingsScroll.BackgroundTransparency = 1
settingsScroll.ScrollBarThickness = 3
settingsScroll.Visible = false
settingsScroll.Parent = contentFrame
local settingsLayout = Instance.new("UIListLayout")
settingsLayout.Padding = UDim.new(0, 6)
settingsLayout.Parent = settingsScroll

local function addSettingToggle(text, callback, defaultValue)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 34)
    frame.BackgroundColor3 = colors.card
    frame.BackgroundTransparency = 0.3
    frame.Parent = settingsScroll
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = colors.text
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.Parent = frame
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 26)
    btn.Position = UDim2.new(1, -58, 0.5, -13)
    btn.BackgroundColor3 = defaultValue and colors.green or colors.red
    btn.Text = defaultValue and "ON" or "OFF"
    btn.TextColor3 = colors.text
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    local state = defaultValue
    btn.MouseButton1Click:Connect(function()
        playClick()
        state = not state
        btn.BackgroundColor3 = state and colors.green or colors.red
        btn.Text = state and "ON" or "OFF"
        callback(state)
    end)
end

addSettingToggle(getText("fpsBoost"), setFPSBoost, fpsBoostEnabled)
addSettingToggle(getText("autoRejoin"), function(s) autoRejoinEnabled = s; saveStats() end, autoRejoinEnabled)
addSettingToggle(getText("antiAFK"), toggleAntiAFK, antiAFKEnabled)
addSettingToggle(getText("sounds"), function(s) soundEnabled = s end, true)

local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(1, 0, 0, 34)
resetBtn.BackgroundColor3 = colors.red
resetBtn.BackgroundTransparency = 0.5
resetBtn.Text = getText("resetStats")
resetBtn.TextColor3 = colors.text
resetBtn.TextSize = 11
resetBtn.Font = Enum.Font.GothamBold
resetBtn.BorderSizePixel = 0
resetBtn.Parent = settingsScroll
local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 6)
resetCorner.Parent = resetBtn
resetBtn.MouseButton1Click:Connect(function()
    totalRuns = 0
    saveStats()
    runsVal.Text = totalRuns
end)

local langBtn = Instance.new("TextButton")
langBtn.Size = UDim2.new(1, 0, 0, 34)
langBtn.BackgroundColor3 = colors.accent
langBtn.BackgroundTransparency = 0.5
langBtn.Text = getText("language") .. ": " .. (currentLanguage == "RU" and "Русский" or "English")
langBtn.TextColor3 = colors.text
langBtn.TextSize = 11
langBtn.Font = Enum.Font.GothamBold
langBtn.BorderSizePixel = 0
langBtn.Parent = settingsScroll
local langCorner = Instance.new("UICorner")
langCorner.CornerRadius = UDim.new(0, 6)
langCorner.Parent = langBtn
langBtn.MouseButton1Click:Connect(function()
    currentLanguage = currentLanguage == "RU" and "EN" or "RU"
    langBtn.Text = getText("language") .. ": " .. (currentLanguage == "RU" and "Русский" or "English")
    tab1.Text = getText("menu"); tab2.Text = getText("scripts"); tab3.Text = getText("settings"); tab4.Text = getText("tweaks")
    nickVal.Text = getText("nickname"); idVal.Text = getText("userid"); ageVal.Text = getText("accountAge")
    playersVal.Text = getText("totalPlayers"); pingVal.Text = getText("ping"); fpsVal.Text = getText("fps"); runsVal.Text = getText("totalRuns")
    resetBtn.Text = getText("resetStats")
end)

-- Вкладка 4: Твики
local tweaksScroll = Instance.new("ScrollingFrame")
tweaksScroll.Size = UDim2.new(1, 0, 1, 0)
tweaksScroll.BackgroundTransparency = 1
tweaksScroll.ScrollBarThickness = 3
tweaksScroll.Visible = false
tweaksScroll.Parent = contentFrame
local tweaksLayout = Instance.new("UIListLayout")
tweaksLayout.Padding = UDim.new(0, 6)
tweaksLayout.Parent = tweaksScroll

local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(1, 0, 0, 50)
speedFrame.BackgroundColor3 = colors.card
speedFrame.BackgroundTransparency = 0.3
speedFrame.Parent = tweaksScroll
local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 6)
speedCorner.Parent = speedFrame
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -15, 0, 20)
speedLabel.Position = UDim2.new(0, 10, 0, 4)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ " .. getText("speed") .. ": 16"
speedLabel.TextColor3 = colors.text
speedLabel.TextSize = 11
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Parent = speedFrame
local sliderTrack = Instance.new("TextButton")
sliderTrack.Size = UDim2.new(1, -20, 0, 10)
sliderTrack.Position = UDim2.new(0, 10, 0, 30)
sliderTrack.BackgroundColor3 = colors.accent
sliderTrack.BorderSizePixel = 0
sliderTrack.Text = ""
sliderTrack.AutoButtonColor = false
sliderTrack.Parent = speedFrame
local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 5)
sliderCorner.Parent = sliderTrack
local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.027, 0, 1, 0)
sliderFill.BackgroundColor3 = colors.green
sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderTrack
local sliderFillCorner = Instance.new("UICorner")
sliderFillCorner.CornerRadius = UDim.new(0, 5)
sliderFillCorner.Parent = sliderFill
local sliderKnob = Instance.new("TextButton")
sliderKnob.Size = UDim2.new(0, 18, 0, 18)
sliderKnob.Position = UDim2.new(0.027, -9, 0.5, -9)
sliderKnob.BackgroundColor3 = colors.text
sliderKnob.BorderSizePixel = 0
sliderKnob.Text = ""
sliderKnob.AutoButtonColor = false
sliderKnob.Parent = sliderTrack
local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1, 0)
knobCorner.Parent = sliderKnob

local dragging = false
local function updateSpeed(inputPos)
    local tStart = sliderTrack.AbsolutePosition.X
    local tWidth = sliderTrack.AbsoluteSize.X
    local relX = math.clamp((inputPos.X - tStart) / tWidth, 0, 1)
    local newVal = math.floor(8 + (relX * 292))
    newVal = math.clamp(newVal, 8, 300)
    sliderFill.Size = UDim2.new(relX, 0, 1, 0)
    sliderKnob.Position = UDim2.new(relX, -9, 0.5, -9)
    speedLabel.Text = "⚡ " .. getText("speed") .. ": " .. newVal
    speedValue = newVal
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = speedValue end
end

sliderKnob.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
end)
sliderTrack.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; updateSpeed(i.Position) end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then updateSpeed(i.Position) end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

local function addTweakToggle(text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 34)
    frame.BackgroundColor3 = colors.card
    frame.BackgroundTransparency = 0.3
    frame.Parent = tweaksScroll
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = colors.text
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.Parent = frame
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 26)
    btn.Position = UDim2.new(1, -58, 0.5, -13)
    btn.BackgroundColor3 = colors.red
    btn.Text = "OFF"
    btn.TextColor3 = colors.text
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and colors.green or colors.red
        btn.Text = state and "ON" or "OFF"
        callback(state)
    end)
end

addTweakToggle(getText("noclip"), toggleNoclip)
addTweakToggle(getText("fly"), toggleFly)
addTweakToggle(getText("jump"), toggleJump)
addTweakToggle(getText("autoclick"), toggleAutoClick)
addTweakToggle(getText("autodelivery"), toggleAutoDelivery)

local setDeliveryBtn = Instance.new("TextButton")
setDeliveryBtn.Size = UDim2.new(1, 0, 0, 34)
setDeliveryBtn.BackgroundColor3 = colors.accent
setDeliveryBtn.BackgroundTransparency = 0.5
setDeliveryBtn.Text = getText("setdelivery")
setDeliveryBtn.TextColor3 = colors.text
setDeliveryBtn.TextSize = 11
setDeliveryBtn.Font = Enum.Font.GothamBold
setDeliveryBtn.BorderSizePixel = 0
setDeliveryBtn.Parent = tweaksScroll
local setDelCorner = Instance.new("UICorner")
setDelCorner.CornerRadius = UDim.new(0, 6)
setDelCorner.Parent = setDeliveryBtn
setDeliveryBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            deliveryPos = hrp.Position
            game.StarterGui:SetCore("SendNotification", {Title = "TWEAKOS", Text = "✅ Точка сдачи сохранена!", Duration = 2})
        end
    end
end)

-- Отслеживание предметов
task.spawn(function()
    while true do
        task.wait(0.2)
        if autoDeliveryEnabled and deliveryPos then
            local char = LocalPlayer.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                local hasItem = tool ~= nil
                if hasItem and not wasHolding then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.CFrame = CFrame.new(deliveryPos) end
                end
                wasHolding = hasItem
            end
        else
            wasHolding = false
        end
    end
end)

-- Переключение вкладок
local function switchTab(tab)
    playClick()
    if tab == 1 then
        menuScroll.Visible = true; scriptsScroll.Visible = false; settingsScroll.Visible = false; tweaksScroll.Visible = false
        tab1.BackgroundColor3 = colors.tabActive; tab2.BackgroundColor3 = colors.tabInactive
        tab3.BackgroundColor3 = colors.tabInactive; tab4.BackgroundColor3 = colors.tabInactive
    elseif tab == 2 then
        menuScroll.Visible = false; scriptsScroll.Visible = true; settingsScroll.Visible = false; tweaksScroll.Visible = false
        tab1.BackgroundColor3 = colors.tabInactive; tab2.BackgroundColor3 = colors.tabActive
        tab3.BackgroundColor3 = colors.tabInactive; tab4.BackgroundColor3 = colors.tabInactive
    elseif tab == 3 then
        menuScroll.Visible = false; scriptsScroll.Visible = false; settingsScroll.Visible = true; tweaksScroll.Visible = false
        tab1.BackgroundColor3 = colors.tabInactive; tab2.BackgroundColor3 = colors.tabInactive
        tab3.BackgroundColor3 = colors.tabActive; tab4.BackgroundColor3 = colors.tabInactive
    elseif tab == 4 then
        menuScroll.Visible = false; scriptsScroll.Visible = false; settingsScroll.Visible = false; tweaksScroll.Visible = true
        tab1.BackgroundColor3 = colors.tabInactive; tab2.BackgroundColor3 = colors.tabInactive
        tab3.BackgroundColor3 = colors.tabInactive; tab4.BackgroundColor3 = colors.tabActive
    end
end

tab1.MouseButton1Click:Connect(function() switchTab(1) end)
tab2.MouseButton1Click:Connect(function() switchTab(2) end)
tab3.MouseButton1Click:Connect(function() switchTab(3) end)
tab4.MouseButton1Click:Connect(function() switchTab(4) end)

-- Перетаскивание
local dragWin = false
local dragStart = nil
local frameStart = nil

titleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragWin = true
        dragStart = i.Position
        frameStart = mainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragWin and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = i.Position - dragStart
        mainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then dragWin = false end
end)

-- Сворачивание
local minimized = false
local fullSize = mainFrame.Size
local fullPos = mainFrame.Position

closeBtn.MouseButton1Click:Connect(function()
    if minimized then
        minimized = false
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = fullSize, Position = fullPos}):Play()
        closeBtn.Text = "−"
        tabsFrame.Visible = true
        contentFrame.Visible = true
    else
        minimized = true
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 60, 0, 40), Position = UDim2.new(1, -70, 0, 60)}):Play()
        closeBtn.Text = "+"
        tabsFrame.Visible = false
        contentFrame.Visible = false
    end
end)

-- Восстановление
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.2)
    local hum = char:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = speedValue end
    if noclipEnabled then
        task.wait(0.1)
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Обновление Canvas
task.wait(0.1)
local function updateCanvas(scroll)
    local h = 0
    for _, v in pairs(scroll:GetChildren()) do
        if v:IsA("Frame") or v:IsA("TextButton") then h = h + v.Size.Y.Offset + 6 end
    end
    scroll.CanvasSize = UDim2.new(0, 0, 0, h + 20)
end
updateCanvas(menuScroll)
updateCanvas(scriptsScroll)
updateCanvas(settingsScroll)
updateCanvas(tweaksScroll)

print("MANscript Hub | Компактная версия 350x200 загружена")
game.StarterGui:SetCore("SendNotification", {Title = "MANscript", Text = "Компактный хаб загружен! 350x200", Duration = 3})