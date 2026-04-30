-- MANscript Hub с предупреждением (включая RexBR Hub)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ===== ЗАСТАВКА-ПРЕДУПРЕЖДЕНИЕ =====
local splashGui = Instance.new("ScreenGui")
splashGui.Name = "Warning"
splashGui.Parent = game.CoreGui
splashGui.ResetOnSpawn = false

local blur = Instance.new("BlurEffect")
blur.Size = 12
blur.Parent = game.Lighting

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.5
bg.Parent = splashGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0.5, -150, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
frame.BackgroundTransparency = 0.15
frame.Parent = splashGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = frame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 50)
logo.Position = UDim2.new(0, 0, 0, 20)
logo.BackgroundTransparency = 1
logo.Text = "MANscript"
logo.TextColor3 = Color3.fromRGB(200, 150, 255)
logo.TextSize = 32
logo.Font = Enum.Font.GothamBold
logo.Parent = frame

local warning = Instance.new("TextLabel")
warning.Size = UDim2.new(1, -40, 0, 60)
warning.Position = UDim2.new(0, 20, 0, 85)
warning.BackgroundTransparency = 1
warning.Text = "‼️ МЫ НЕ НЕСЁМ ОТВЕТСТВЕННОСТЬ ЗА ВАШ АККАУНТ ‼️"
warning.TextColor3 = Color3.fromRGB(255, 100, 100)
warning.TextSize = 13
warning.TextWrapped = true
warning.Font = Enum.Font.GothamBold
warning.Parent = frame

local advice = Instance.new("TextLabel")
advice.Size = UDim2.new(1, -40, 0, 40)
advice.Position = UDim2.new(0, 20, 0, 155)
advice.BackgroundTransparency = 1
advice.Text = "Попытайтесь не спалиться с использованием эксплойтеров!"
advice.TextColor3 = Color3.fromRGB(220, 180, 220)
advice.TextSize = 11
advice.Font = Enum.Font.Gotham
advice.Parent = frame

local acceptBtn = Instance.new("TextButton")
acceptBtn.Size = UDim2.new(0, 240, 0, 50)
acceptBtn.Position = UDim2.new(0.5, -120, 1, -65)
acceptBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 140)
acceptBtn.Text = "Я ПРОЧИТАЛ И НЕСУ ОТВЕТСТВЕННОСТЬ"
acceptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
acceptBtn.TextSize = 11
acceptBtn.TextWrapped = true
acceptBtn.Font = Enum.Font.GothamBold
acceptBtn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = acceptBtn

acceptBtn.MouseButton1Click:Connect(function()
    splashGui:Destroy()
    blur:Destroy()
    loadMenu()
end)

task.wait(4)
pcall(function() splashGui:Destroy() blur:Destroy() loadMenu() end)

function loadMenu()
    local gui = Instance.new("ScreenGui")
    gui.Name = "MANhub"
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 400, 0, 520)
    main.Position = UDim2.new(0, 10, 0, 60)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    main.Parent = gui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 14)
    mainCorner.Parent = main

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    titleBar.Parent = main

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 14)
    titleCorner.Parent = titleBar

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -120, 1, 0)
    title.Position = UDim2.new(0, 12, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "MANscript Hub"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.Parent = titleBar

    local tgBtn = Instance.new("TextButton")
    tgBtn.Size = UDim2.new(0, 70, 0, 30)
    tgBtn.Position = UDim2.new(1, -120, 0.5, -15)
    tgBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    tgBtn.Text = "📢 ТГК"
    tgBtn.TextColor3 = Color3.fromRGB(200, 180, 255)
    tgBtn.TextSize = 11
    tgBtn.Font = Enum.Font.GothamBold
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

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 30, 0, 30)
    minBtn.Position = UDim2.new(1, -42, 0, 7)
    minBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    minBtn.Text = "-"
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.TextSize = 20
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Parent = titleBar

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(1, 0)
    minCorner.Parent = minBtn

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -16, 1, -55)
    scroll.Position = UDim2.new(0, 8, 0, 50)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 3
    scroll.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = scroll

    local function addCat(name)
        local cat = Instance.new("Frame")
        cat.Size = UDim2.new(1, 0, 0, 35)
        cat.BackgroundTransparency = 1
        cat.Parent = scroll
        
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 2)
        line.Position = UDim2.new(0, 0, 1, -2)
        line.BackgroundColor3 = Color3.fromRGB(60, 60, 85)
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

    local function addScript(name, url, color)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 50)
        btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 45)
        btn.Text = "▶ " .. name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.GothamBold
        btn.Parent = scroll
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 10)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
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

    addCat("=== ШУТЕРЫ ===")
    addScript("BloxStrike", "https://raw.githubusercontent.com/polo242c/bloxstrike/refs/heads/main/blox", Color3.fromRGB(180, 60, 60))
    addScript("Dead Rails", "https://raw.githubusercontent.com/hungquan99/HungHub/main/loader.lua", Color3.fromRGB(80, 80, 180))
    addScript("TSB", "https://raw.githubusercontent.com/COOLXPLO/DP-HUB-coolxplo/refs/heads/main/TSB.lua", Color3.fromRGB(200, 100, 50))
    addScript("Rivals", "https://soluna-script.vercel.app/main.lua", Color3.fromRGB(100, 150, 200))

    addCat("=== РПГ ===")
    addScript("Blox Fruit", "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua", Color3.fromRGB(0, 150, 100))
    addScript("Forsaken", "https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua", Color3.fromRGB(180, 120, 0))
    addScript("99 Nights", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", Color3.fromRGB(120, 60, 180))
    addScript("Steal a Brainrot", "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/DUELWorld.lua", Color3.fromRGB(150, 50, 100))
    
    addCat("=== БЫСТРЫЙ СБОР / ПОЛЁТ ===")
    addScript("RexBR Hub (Fly+Collect)", "https://pastebin.com/raw/pCMCfnmV", Color3.fromRGB(0, 200, 150))

    addCat("=== ИНФО ===")
    local info = Instance.new("TextButton")
    info.Size = UDim2.new(1, 0, 0, 40)
    info.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    info.Text = "  @MANscript  |  tg: @manscripthub"
    info.TextColor3 = Color3.fromRGB(160, 160, 180)
    info.TextSize = 11
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Font = Enum.Font.Gotham
    info.Parent = scroll

    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 10)
    infoCorner.Parent = info

    -- ПЕРЕТАСКИВАНИЕ
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

    -- СВОРАЧИВАНИЕ
    local minimized = false
    local fullSize = main.Size
    local fullPos = main.Position

    minBtn.MouseButton1Click:Connect(function()
        if minimized then
            minimized = false
            main.Size = fullSize
            main.Position = fullPos
            minBtn.Text = "-"
            scroll.Visible = true
        else
            minimized = true
            main.Size = UDim2.new(0, 55, 0, 45)
            main.Position = UDim2.new(1, -65, 0, 70)
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

    game.StarterGui:SetCore("SendNotification", {
        Title = "MANscript",
        Text = "Хаб загружен! Нажми на предупреждение",
        Duration = 3
    })
end