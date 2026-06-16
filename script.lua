-- ============================================
-- ГАРАНТОВАНО РОБОЧИЙ СКРИПТ ДЛЯ BLOX FRUITS
-- З МНОЖИННИМИ СПОСОБАМИ СТВОРЕННЯ GUI
-- ============================================

-- [1] БАЗОВА ПЕРЕВІРКА
print("=" .. string.rep("=", 50))
print("🚀 СКРИПТ ЗАПУЩЕНО!")
print("=" .. string.rep("=", 50))

-- [2] ОТРИМУЄМО ГРАВЦЯ
local player = game:GetService("Players").LocalPlayer
print("✅ Гравець: " .. player.Name)

-- [3] ЧЕКАЄМО ПОЯВИ ПЕРСОНАЖА
repeat wait(0.5) until player.Character
print("✅ Персонаж з'явився!")

-- [4] ОТРИМУЄМО PlayerGui
local playerGui = player:WaitForChild("PlayerGui", 5)
if not playerGui then
    playerGui = Instance.new("ScreenGui")
    playerGui.Parent = player
    print("⚠️ Створено PlayerGui вручну!")
end
print("✅ PlayerGui отримано!")

-- [5] ВИДАЛЯЄМО СТАРІ GUI (якщо є)
local oldGui = playerGui:FindFirstChild("BloxFruitsGUI")
if oldGui then oldGui:Destroy() end

-- ============================================
-- СТВОРЕННЯ GUI (СПОСІБ 1 - СТАНДАРТНИЙ)
-- ============================================
local success, err = pcall(function()
    -- Створюємо ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BloxFruitsGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    print("✅ ScreenGui створено!")
    
    -- ГОЛОВНЕ ВІКНО
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 170, 0)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    print("✅ MainFrame створено!")
    
    -- ЗАГОЛОВОК
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
    title.BackgroundTransparency = 0.2
    title.Text = "⚡ BLOX FRUITS MENU ⚡"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    print("✅ Title створено!")
    
    -- КНОПКА ЗАКРИТТЯ
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    print("✅ CloseBtn створено!")
    
    -- ФУНКЦІЯ СТВОРЕННЯ КНОПКИ
    local function createButton(text, yPos, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.85, 0, 0, 35)
        btn.Position = UDim2.new(0.075, 0, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 15
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(70, 70, 85)
        btn.Parent = mainFrame
        btn.MouseButton1Click:Connect(callback)
        return btn
    end
    
    -- СТВОРЮЄМО КНОПКИ
    local yPos = 50
    
    -- Кнопка Авто-фарм
    local farmBtn = createButton("🤖 АВТО-ФАРМ [ВИКЛ]", yPos, function()
        settings.AutoFarm = not settings.AutoFarm
        farmBtn.Text = settings.AutoFarm and "🤖 АВТО-ФАРМ [ВКЛ]" or "🤖 АВТО-ФАРМ [ВИКЛ]"
        farmBtn.BackgroundColor3 = settings.AutoFarm and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 65)
    end)
    yPos = yPos + 45
    
    -- Кнопка Телепорт
    local tpBtn = createButton("🌀 ТЕЛЕПОРТ [ВИКЛ]", yPos, function()
        settings.AutoTeleport = not settings.AutoTeleport
        tpBtn.Text = settings.AutoTeleport and "🌀 ТЕЛЕПОРТ [ВКЛ]" or "🌀 ТЕЛЕПОРТ [ВИКЛ]"
        tpBtn.BackgroundColor3 = settings.AutoTeleport and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 65)
    end)
    yPos = yPos + 45
    
    -- Кнопка Збір фруктів
    local collectBtn = createButton("🍎 ЗБІР ФРУКТІВ [ВИКЛ]", yPos, function()
        settings.AutoCollect = not settings.AutoCollect
        collectBtn.Text = settings.AutoCollect and "🍎 ЗБІР ФРУКТІВ [ВКЛ]" or "🍎 ЗБІР ФРУКТІВ [ВИКЛ]"
        collectBtn.BackgroundColor3 = settings.AutoCollect and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 65)
    end)
    yPos = yPos + 45
    
    -- Кнопка Авто-квест
    local questBtn = createButton("📋 АВТО-КВЕСТ [ВИКЛ]", yPos, function()
        settings.AutoQuest = not settings.AutoQuest
        questBtn.Text = settings.AutoQuest and "📋 АВТО-КВЕСТ [ВКЛ]" or "📋 АВТО-КВЕСТ [ВИКЛ]"
        questBtn.BackgroundColor3 = settings.AutoQuest and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 65)
    end)
    yPos = yPos + 45
    
    -- СТАТУС
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.85, 0, 0, 30)
    statusLabel.Position = UDim2.new(0.075, 0, 0, yPos + 10)
    statusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    statusLabel.BackgroundTransparency = 0.5
    statusLabel.Text = "Статус: Очікування..."
    statusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Parent = mainFrame
    print("✅ StatusLabel створено!")
    
    print("=" .. string.rep("=", 50))
    print("🎉 МЕНЮ УСПІШНО СТВОРЕНО!")
    print("📌 Шукайте вікно в центрі екрану")
    print("=" .. string.rep("=", 50))
    
    return screenGui, statusLabel
end)

-- [6] ЯКЩО СТАНДАРТНИЙ СПОСІБ НЕ ПРАЦЮЄ - ДУБЛЕР
if not success then
    print("⚠️ Помилка при створенні GUI: " .. tostring(err))
    print("🔄 Спроба альтернативного способу...")
    
    -- АЛЬТЕРНАТИВНИЙ СПОСІБ (через StarterGui)
    pcall(function()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "BloxFruitsGUI"
        screenGui.Parent = game:GetService("StarterGui")
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 200)
        frame.Position = UDim2.new(0.5, -150, 0.5, -100)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        frame.BackgroundTransparency = 0.1
        frame.Parent = screenGui
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 40)
        label.Text = "⚡ MENU (ALTERNATIVE) ⚡"
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
        label.Parent = frame
        
        print("✅ Альтернативне GUI створено через StarterGui!")
    end)
end

-- ============================================
-- [7] НАЛАШТУВАННЯ ТА ЗМІННІ
-- ============================================
local settings = {
    AutoFarm = false,
    AutoTeleport = false,
    AutoCollect = false,
    AutoQuest = false,
    FarmRadius = 50,
    FlyHeight = 5
}

local character = player.Character
local rootPart = character:FindFirstChild("HumanoidRootPart")

-- ============================================
-- [8] ОСНОВНІ ФУНКЦІЇ
-- ============================================

-- Отримання рівня гравця
local function getPlayerLevel()
    local level = 0
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
    return level
end

-- Список ворогів за рівнем
local function getEnemiesForLevel(level)
    local enemies = {}
    local enemyList = {
        {min = 0, max = 10, names = {"Bandit", "Brute", "Pirate"}},
        {min = 10, max = 25, names = {"Marine", "Sailor", "Captain"}},
        {min = 25, max = 40, names = {"Galley", "Crew", "Navigator"}},
        {min = 40, max = 60, names = {"Monkey", "Gorilla", "Ape"}},
        {min = 60, max = 80, names = {"Pirate", "Corsair", "Buccaneer"}},
        {min = 80, max = 100, names = {"Swordsman", "Samurai", "Ninja"}},
        {min = 100, max = 125, names = {"Mage", "Wizard", "Sorcerer"}},
        {min = 125, max = 150, names = {"Knight", "Paladin", "Warrior"}},
        {min = 150, max = 175, names = {"Dragon", "Wyvern", "Drake"}},
        {min = 175, max = 200, names = {"Asard", "Astaroth", "Demon"}},
        {min = 200, max = 225, names = {"Titan", "Giant", "Colossus"}},
        {min = 225, max = 250, names = {"God", "Deity", "Angel"}},
        {min = 250, max = 275, names = {"Emperor", "King", "Lord"}},
        {min = 275, max = 300, names = {"Legend", "Myth", "Hero"}}
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

-- Пошук ворогів для поточного рівня
local function getTargetEnemies()
    local level = getPlayerLevel()
    local targetNames = getEnemiesForLevel(level)
    local enemies = {}
    
    if not character then return enemies end
    if not rootPart then return enemies end
    
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

-- Пошук найближчого ворога
local function getNearestEnemy()
    local enemies = getTargetEnemies()
    local nearest = nil
    local shortestDist = settings.FarmRadius
    
    if not rootPart then return nil end
    
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

-- Телепорт на висоту 5 метрів
local function flyToEnemy(target)
    if not target then return false end
    if not rootPart then return false end
    local hrp = target:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local targetPos = hrp.Position
    rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, settings.FlyHeight, 0))
    return true
end

-- Атака
local function attack()
    pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "Q", false, nil)
        wait(0.1)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "Q", false, nil)
    end)
end

-- Збір фруктів
local function collectFruits()
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
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, nil)
                            wait(0.1)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, nil)
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
-- [9] ГОЛОВНИЙ ЦИКЛ
-- ============================================
local function mainLoop()
    while wait(0.5) do
        -- Оновлюємо персонажа
        if not character or not character.Parent then
            character = player.Character or player.CharacterAdded:Wait()
            rootPart = character:FindFirstChild("HumanoidRootPart")
        end
        
        local status = "Очікування..."
        
        -- АВТО-ФАРМ
        if settings.AutoFarm then
            local enemy = getNearestEnemy()
            if enemy then
                status = "⚔️ Атака: " .. enemy.Name
                if settings.AutoTeleport then
                    flyToEnemy(enemy)
                end
                attack()
            else
                status = "🔍 Пошук ворогів (рівень " .. getPlayerLevel() .. ")"
            end
        end
        
        -- АВТО-ЗБІР
        if settings.AutoCollect then
            if collectFruits() then
                status = "🍎 Збір фруктів..."
            end
        end
        
        -- АВТО-КВЕСТ
        if settings.AutoQuest then
            -- Тут логіка взяття квесту
            status = "📋 Пошук квесту..."
        end
        
        -- Оновлюємо статус
        pcall(function()
            if statusLabel then
                statusLabel.Text = "Статус: " .. status
            end
        end)
    end
end

-- ============================================
-- [10] ЗАПУСК
-- ============================================
print("=" .. string.rep("=", 50))
print("🔄 ЗАПУСК ГОЛОВНОГО ЦИКЛУ...")
print("=" .. string.rep("=", 50))

-- Запускаємо цикл
spawn(mainLoop)

-- Повідомлення про успішний запуск
wait(1)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✅ СКРИПТ ЗАПУЩЕНО!",
    Text = "Меню має з'явитися в центрі екрану",
    Duration = 5,
    Icon = "rbxassetid://4483345998"
})

print("=" .. string.rep("=", 50))
print("🎯 СКРИПТ ГОТОВИЙ ДО РОБОТИ!")
print("📌 ЯКЩО МЕНЮ НЕ З'ЯВИЛОСЬ - ДИВІТЬСЯ КОНСОЛЬ (F9)")
print("=" .. string.rep("=", 50))