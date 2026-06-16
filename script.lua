-- ============================================
-- КРАСИВЕ МЕНЮ ДЛЯ BLOX FRUITS
-- З ПОВНОЦІННИМИ РОБОЧИМИ КНОПКАМИ
-- ============================================

print("🚀 ЗАПУСК СКРИПТА")

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local userInput = game:GetService("UserInputService")
local virtualInput = game:GetService("VirtualInputManager")

-- ========== НАЛАШТУВАННЯ ==========
local settings = {
    AutoFarm = false,
    AutoTeleport = false,
    AutoCollect = false,
    AutoQuest = false,
    FarmRadius = 50,
    FlyHeight = 5
}

-- ========== ЗМІННІ GUI ==========
local screenGui = nil
local mainFrame = nil
local statusLabel = nil
local buttons = {}

-- ========== СТВОРЕННЯ КРАСИВОГО GUI ==========
local function createBeautifulGUI()
    print("🔄 Створення красивого GUI...")
    
    -- Видаляємо старе GUI
    local oldGui = playerGui:FindFirstChild("BloxFruitsGUI")
    if oldGui then oldGui:Destroy() end
    
    -- ГОЛОВНИЙ ЕКРАН
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BloxFruitsGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- ===== ГОЛОВНЕ ВІКНО =====
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 380, 0, 480)
    mainFrame.Position = UDim2.new(0.5, -190, 0.5, -240)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 200, 50)
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- ТІНЬ (декорація)
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.5
    shadow.BorderSizePixel = 0
    shadow.Parent = mainFrame
    
    -- ===== ЗАГОЛОВОК =====
    local titleFrame = Instance.new("Frame")
    titleFrame.Size = UDim2.new(1, 0, 0, 50)
    titleFrame.Position = UDim2.new(0, 0, 0, 0)
    titleFrame.BackgroundColor3 = Color3.fromRGB(255, 180, 30)
    titleFrame.BackgroundTransparency = 0.15
    titleFrame.BorderSizePixel = 0
    titleFrame.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -60, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "⚡ BLOX FRUITS ⚡"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 22
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Parent = titleFrame
    
    -- КНОПКА ЗАКРИТТЯ
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -42, 0, 7)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    closeBtn.BackgroundTransparency = 0.8
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 20
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleFrame
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    closeBtn.MouseEnter:Connect(function()
        closeBtn.BackgroundTransparency = 0.3
    end)
    closeBtn.MouseLeave:Connect(function()
        closeBtn.BackgroundTransparency = 0.8
    end)
    
    -- КНОПКА ЗГОРТАННЯ
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
    minimizeBtn.Position = UDim2.new(1, -80, 0, 7)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    minimizeBtn.BackgroundTransparency = 0.8
    minimizeBtn.Text = "─"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.TextSize = 20
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = titleFrame
    minimizeBtn.MouseButton1Click:Connect(function()
        if mainFrame.Size.Y.Scale == 0 then
            mainFrame.Size = UDim2.new(0, 380, 0, 480)
        else
            mainFrame.Size = UDim2.new(0, 380, 0, 50)
        end
    end)
    minimizeBtn.MouseEnter:Connect(function()
        minimizeBtn.BackgroundTransparency = 0.3
    end)
    minimizeBtn.MouseLeave:Connect(function()
        minimizeBtn.BackgroundTransparency = 0.8
    end)
    
    -- ===== ІНФОРМАЦІЯ ПРО ГРАВЦЯ =====
    local infoFrame = Instance.new("Frame")
    infoFrame.Size = UDim2.new(1, -20, 0, 35)
    infoFrame.Position = UDim2.new(0, 10, 0, 55)
    infoFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    infoFrame.BackgroundTransparency = 0.5
    infoFrame.BorderSizePixel = 1
    infoFrame.BorderColor3 = Color3.fromRGB(60, 60, 80)
    infoFrame.Parent = mainFrame
    
    local levelLabel = Instance.new("TextLabel")
    levelLabel.Size = UDim2.new(0.5, 0, 1, 0)
    levelLabel.Position = UDim2.new(0, 5, 0, 0)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Text = "🎯 Рівень: " .. getPlayerLevel()
    levelLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    levelLabel.TextSize = 15
    levelLabel.Font = Enum.Font.GothamBold
    levelLabel.TextXAlignment = Enum.TextXAlignment.Left
    levelLabel.Parent = infoFrame
    
    local enemyLabel = Instance.new("TextLabel")
    enemyLabel.Size = UDim2.new(0.5, 0, 1, 0)
    enemyLabel.Position = UDim2.new(0.5, 0, 0, 0)
    enemyLabel.BackgroundTransparency = 1
    enemyLabel.Text = "👾 Ворогів: 0"
    enemyLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    enemyLabel.TextSize = 15
    enemyLabel.Font = Enum.Font.GothamBold
    enemyLabel.TextXAlignment = Enum.TextXAlignment.Right
    enemyLabel.Parent = infoFrame
    
    -- ===== ФУНКЦІЯ СТВОРЕННЯ КРАСИВОЇ КНОПКИ =====
    local function createStyledButton(text, yPos, icon, callback)
        local btnFrame = Instance.new("Frame")
        btnFrame.Size = UDim2.new(0.9, 0, 0, 40)
        btnFrame.Position = UDim2.new(0.05, 0, 0, yPos)
        btnFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        btnFrame.BackgroundTransparency = 0.3
        btnFrame.BorderSizePixel = 1
        btnFrame.BorderColor3 = Color3.fromRGB(65, 65, 85)
        btnFrame.Parent = mainFrame
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.Position = UDim2.new(0, 0, 0, 0)
        btn.BackgroundTransparency = 1
        btn.Text = icon .. " " .. text .. " [ВИКЛ]"
        btn.TextColor3 = Color3.fromRGB(220, 220, 230)
        btn.TextSize = 16
        btn.Font = Enum.Font.GothamBold
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = btnFrame
        
        -- Індикатор стану (кружечок)
        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 12, 0, 12)
        indicator.Position = UDim2.new(1, -25, 0.5, -6)
        indicator.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        indicator.BorderSizePixel = 0
        indicator.Parent = btnFrame
        
        local isOn = false
        
        btn.MouseButton1Click:Connect(function()
            isOn = not isOn
            btn.Text = icon .. " " .. text .. (isOn and " [ВКЛ]" or " [ВИКЛ]")
            btn.TextColor3 = isOn and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(220, 220, 230)
            indicator.BackgroundColor3 = isOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(200, 50, 50)
            btnFrame.BackgroundColor3 = isOn and Color3.fromRGB(30, 80, 30) or Color3.fromRGB(45, 45, 65)
            callback(isOn)
        end)
        
        btn.MouseEnter:Connect(function()
            btnFrame.BackgroundTransparency = 0.1
        end)
        btn.MouseLeave:Connect(function()
            btnFrame.BackgroundTransparency = isOn and 0.3 or 0.3
        end)
        
        return btn, indicator, btnFrame
    end
    
    -- ===== СТВОРЮЄМО ВСІ КНОПКИ =====
    local yPos = 100
    
    -- 1. Авто-фарм
    local farmBtn, farmInd, farmFrame = createStyledButton("АВТО-ФАРМ", yPos, "🤖", function(state)
        settings.AutoFarm = state
        print("🤖 Авто-фарм: " .. tostring(state))
        if state then
            statusLabel.Text = "📊 Статус: 🔍 Пошук ворогів..."
        else
            statusLabel.Text = "📊 Статус: ⏸ Очікування..."
        end
    end)
    yPos = yPos + 48
    
    -- 2. Телепорт
    local tpBtn, tpInd, tpFrame = createStyledButton("ТЕЛЕПОРТ", yPos, "🌀", function(state)
        settings.AutoTeleport = state
        print("🌀 Телепорт: " .. tostring(state))
    end)
    yPos = yPos + 48
    
    -- 3. Збір фруктів
    local collectBtn, collectInd, collectFrame = createStyledButton("ЗБІР ФРУКТІВ", yPos, "🍎", function(state)
        settings.AutoCollect = state
        print("🍎 Збір фруктів: " .. tostring(state))
    end)
    yPos = yPos + 48
    
    -- 4. Авто-квест
    local questBtn, questInd, questFrame = createStyledButton("АВТО-КВЕСТ", yPos, "📋", function(state)
        settings.AutoQuest = state
        print("📋 Авто-квест: " .. tostring(state))
    end)
    yPos = yPos + 55
    
    -- ===== СТАТУС =====
    local statusFrame = Instance.new("Frame")
    statusFrame.Size = UDim2.new(0.9, 0, 0, 35)
    statusFrame.Position = UDim2.new(0.05, 0, 0, yPos)
    statusFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
    statusFrame.BackgroundTransparency = 0.5
    statusFrame.BorderSizePixel = 1
    statusFrame.BorderColor3 = Color3.fromRGB(55, 55, 75)
    statusFrame.Parent = mainFrame
    
    statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -10, 1, 0)
    statusLabel.Position = UDim2.new(0, 5, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "📊 Статус: Очікування..."
    statusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = statusFrame
    
    -- ===== ДЕКОРАТИВНА ЛІНІЯ =====
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0.9, 0, 0, 1)
    line.Position = UDim2.new(0.05, 0, 0, yPos + 45)
    line.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    line.BackgroundTransparency = 0.5
    line.Parent = mainFrame
    
    -- ===== ТЕКСТ АВТОРА =====
    local authorText = Instance.new("TextLabel")
    authorText.Size = UDim2.new(1, 0, 0, 20)
    authorText.Position = UDim2.new(0, 0, 0, yPos + 50)
    authorText.BackgroundTransparency = 1
    authorText.Text = "💡 Натискайте кнопки для активації"
    authorText.TextColor3 = Color3.fromRGB(150, 150, 170)
    authorText.TextSize = 12
    authorText.Font = Enum.Font.Gotham
    authorText.Parent = mainFrame
    
    print("✅ Красиве GUI створено!")
    return statusLabel, enemyLabel, levelLabel
end

-- ============================================
-- ФУНКЦІЇ ДЛЯ РОБОТИ
-- ============================================

-- Отримання рівня
function getPlayerLevel()
    local level = 0
    pcall(function()
        local stats = player:FindFirstChild("Stats")
        if stats then
            local levelStat = stats:FindFirstChild("Level")
            if levelStat then level = levelStat.Value end
        end
        if level == 0 then
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats then
                local levelStat = leaderstats:FindFirstChild("Level")
                if levelStat then level = levelStat.Value end
            end
        end
    end)
    return level
end

-- Список ворогів за рівнем
local function getEnemiesForLevel(level)
    local enemies = {}
    local enemyList = {
        {min = 0, max = 10, names = {"Bandit", "Brute"}},
        {min = 10, max = 25, names = {"Marine", "Sailor"}},
        {min = 25, max = 40, names = {"Galley", "Crew"}},
        {min = 40, max = 60, names = {"Monkey", "Gorilla"}},
        {min = 60, max = 80, names = {"Pirate", "Corsair"}},
        {min = 80, max = 100, names = {"Swordsman", "Samurai"}},
        {min = 100, max = 125, names = {"Mage", "Wizard"}},
        {min = 125, max = 150, names = {"Knight", "Paladin"}},
        {min = 150, max = 175, names = {"Dragon", "Wyvern"}},
        {min = 175, max = 200, names = {"Asard", "Demon"}},
        {min = 200, max = 225, names = {"Titan", "Giant"}},
        {min = 225, max = 250, names = {"God", "Deity"}},
        {min = 250, max = 275, names = {"Emperor", "King"}},
        {min = 275, max = 300, names = {"Legend", "Myth"}}
    }
    
    for _, data in pairs(enemyList) do
        if level >= data.min and level <= data.max then
            for _, name in pairs(data.names) do
                table.insert(enemies, name)
            end
        end
    end
    return enemies
end

-- Пошук ворогів
local function getTargetEnemies()
    local level = getPlayerLevel()
    local targetNames = getEnemiesForLevel(level)
    local enemies = {}
    local character = player.Character
    if not character then return enemies end
    
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            local hum = v:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 and v.Name ~= player.Name then
                for _, name in pairs(targetNames) do
                    if string.find(v.Name, name) then
                        local hrp = v:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            table.insert(enemies, v)
                            break
                        end
                    end
                end
            end
        end
    end
    return enemies
end

-- Найближчий ворог
local function getNearestEnemy()
    local enemies = getTargetEnemies()
    local character = player.Character
    if not character then return nil end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end
    
    local nearest = nil
    local shortestDist = settings.FarmRadius
    
    for _, enemy in pairs(enemies) do
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        if hrp then
            local dist = (rootPart.Position - hrp.Position).Magnitude
            if dist < shortestDist then
                nearest = enemy
                shortestDist = dist
            end
        end
    end
    return nearest
end

-- Телепорт
local function flyToEnemy(target)
    if not target then return false end
    local character = player.Character
    if not character then return false end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    local hrp = target:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    rootPart.CFrame = CFrame.new(hrp.Position + Vector3.new(0, settings.FlyHeight, 0))
    return true
end

-- Атака
local function attack()
    local success = false
    pcall(function()
        virtualInput:SendKeyEvent(true, "Q", false, nil)
        wait(0.1)
        virtualInput:SendKeyEvent(false, "Q", false, nil)
        success = true
    end)
    return success
end

-- Збір фруктів
local function collectFruits()
    local character = player.Character
    if not character then return false end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") then
            local name = v.Name:lower()
            if name:find("fruit") or name:find("apple") or name:find("banana") or name:find("chest") then
                local handle = v:FindFirstChild("Handle")
                if handle then
                    local dist = (rootPart.Position - handle.Position).Magnitude
                    if dist < 25 then
                        rootPart.CFrame = CFrame.new(handle.Position + Vector3.new(0, 2, 0))
                        wait(0.2)
                        pcall(function()
                            virtualInput:SendKeyEvent(true, "E", false, nil)
                            wait(0.1)
                            virtualInput:SendKeyEvent(false, "E", false, nil)
                        end)
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- ============================================
-- ГОЛОВНИЙ ЦИКЛ
-- ============================================
local function mainLoop(enemyLabel, levelLabel)
    print("🔄 Запуск головного циклу...")
    
    while wait(0.5) do
        -- Оновлюємо інформацію
        pcall(function()
            if levelLabel then
                levelLabel.Text = "🎯 Рівень: " .. getPlayerLevel()
            end
        end)
        
        -- Оновлюємо персонажа
        if not player.Character then
            player.CharacterAdded:Wait()
        end
        
        local character = player.Character
        if not character then continue end
        
        -- Оновлюємо кількість ворогів
        pcall(function()
            if enemyLabel then
                local enemies = getTargetEnemies()
                enemyLabel.Text = "👾 Ворогів: " .. #enemies
            end
        end)
        
        -- АВТО-ФАРМ
        if settings.AutoFarm then
            local enemy = getNearestEnemy()
            if enemy then
                pcall(function()
                    if settings.AutoTeleport then
                        flyToEnemy(enemy)
                    end
                    attack()
                    if statusLabel then
                        statusLabel.Text = "📊 Статус: ⚔️ Атака " .. enemy.Name
                    end
                end)
            else
                if statusLabel then
                    statusLabel.Text = "📊 Статус: 🔍 Пошук ворогів..."
                end
            end
        end
        
        -- АВТО-ЗБІР
        if settings.AutoCollect then
            pcall(function()
                if collectFruits() then
                    if statusLabel then
                        statusLabel.Text = "📊 Статус: 🍎 Зібрано фрукт!"
                    end
                end
            end)
        end
    end
end

-- ============================================
-- ЗАПУСК
-- ============================================

print("=" .. string.rep("=", 50))
print("🚀 ЗАПУСК СКРИПТА")

-- Створюємо GUI
local statusLabel, enemyLabel, levelLabel = createBeautifulGUI()

-- Запускаємо цикл
spawn(function()
    mainLoop(enemyLabel, levelLabel)
end)

print("✅ СКРИПТ ГОТОВИЙ!")
print("📌 МЕНЮ З'ЯВИТЬСЯ В ЦЕНТРІ ЕКРАНУ")
print("=" .. string.rep("=", 50))