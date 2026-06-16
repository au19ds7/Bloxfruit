-- ============================================
-- РОБОЧИЙ СКРИПТ ДЛЯ BLOX FRUITS
-- З ДІАГНОСТИКОЮ ТА РЕЗЕРВНИМИ МЕТОДАМИ
-- ============================================

print("=" .. string.rep("=", 60))
print("🚀 ЗАПУСК СКРИПТА")
print("=" .. string.rep("=", 60))

-- [1] ОТРИМУЄМО ГРАВЦЯ
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
print("✅ Гравець: " .. player.Name)

-- [2] НАЛАШТУВАННЯ
local settings = {
    AutoFarm = false,
    AutoTeleport = false,
    AutoCollect = false,
    AutoQuest = false,
    FarmRadius = 50,
    FlyHeight = 5,
    AttackKey = "Q",
    CollectKey = "E"
}

-- [3] ЗМІННІ ДЛЯ GUI
local screenGui = nil
local statusLabel = nil
local farmBtn = nil
local tpBtn = nil
local collectBtn = nil
local questBtn = nil

-- [4] ДІАГНОСТИЧНА ФУНКЦІЯ
local function log(message, color)
    print("[LOG] " .. message)
    pcall(function()
        if statusLabel then
            statusLabel.Text = "📊 " .. message
        end
    end)
end

-- ============================================
-- СТВОРЕННЯ МЕНЮ
-- ============================================
local function createGUI()
    print("🔄 Створення GUI...")
    
    -- Видаляємо старе GUI
    local oldGui = playerGui:FindFirstChild("BloxFruitsGUI")
    if oldGui then oldGui:Destroy() end
    
    -- Створюємо нове
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BloxFruitsGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    print("✅ ScreenGui створено")
    
    -- Головне вікно
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 420)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -210)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 170, 0)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- Заголовок
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
    
    -- Кнопка закриття
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
    
    -- Функція створення кнопки
    local function createButton(text, yPos, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.85, 0, 0, 35)
        btn.Position = UDim2.new(0.075, 0, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 15
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(65, 65, 80)
        btn.Parent = mainFrame
        btn.MouseButton1Click:Connect(callback)
        return btn
    end
    
    -- СТВОРЮЄМО КНОПКИ
    local yPos = 50
    
    -- 1. Авто-фарм
    farmBtn = createButton("🤖 АВТО-ФАРМ [ВИКЛ]", yPos, function()
        settings.AutoFarm = not settings.AutoFarm
        farmBtn.Text = settings.AutoFarm and "🤖 АВТО-ФАРМ [ВКЛ]" or "🤖 АВТО-ФАРМ [ВИКЛ]"
        farmBtn.BackgroundColor3 = settings.AutoFarm and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 60)
        log(settings.AutoFarm and "Авто-фарм УВІМКНЕНО" or "Авто-фарм ВИМКНЕНО")
    end)
    yPos = yPos + 45
    
    -- 2. Телепорт
    tpBtn = createButton("🌀 ТЕЛЕПОРТ [ВИКЛ]", yPos, function()
        settings.AutoTeleport = not settings.AutoTeleport
        tpBtn.Text = settings.AutoTeleport and "🌀 ТЕЛЕПОРТ [ВКЛ]" or "🌀 ТЕЛЕПОРТ [ВИКЛ]"
        tpBtn.BackgroundColor3 = settings.AutoTeleport and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 60)
        log(settings.AutoTeleport and "Телепорт УВІМКНЕНО" or "Телепорт ВИМКНЕНО")
    end)
    yPos = yPos + 45
    
    -- 3. Збір фруктів
    collectBtn = createButton("🍎 ЗБІР ФРУКТІВ [ВИКЛ]", yPos, function()
        settings.AutoCollect = not settings.AutoCollect
        collectBtn.Text = settings.AutoCollect and "🍎 ЗБІР ФРУКТІВ [ВКЛ]" or "🍎 ЗБІР ФРУКТІВ [ВИКЛ]"
        collectBtn.BackgroundColor3 = settings.AutoCollect and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 60)
        log(settings.AutoCollect and "Збір фруктів УВІМКНЕНО" or "Збір фруктів ВИМКНЕНО")
    end)
    yPos = yPos + 45
    
    -- 4. Авто-квест
    questBtn = createButton("📋 АВТО-КВЕСТ [ВИКЛ]", yPos, function()
        settings.AutoQuest = not settings.AutoQuest
        questBtn.Text = settings.AutoQuest and "📋 АВТО-КВЕСТ [ВКЛ]" or "📋 АВТО-КВЕСТ [ВИКЛ]"
        questBtn.BackgroundColor3 = settings.AutoQuest and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(45, 45, 60)
        log(settings.AutoQuest and "Авто-квест УВІМКНЕНО" or "Авто-квест ВИМКНЕНО")
    end)
    yPos = yPos + 45
    
    -- 5. Тестова кнопка (для перевірки)
    local testBtn = createButton("🔧 ТЕСТ КНОПКИ", yPos, function()
        log("🔧 Тестова кнопка НАТИСНУТА!")
        testBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
        wait(0.5)
        testBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    end)
    yPos = yPos + 45
    
    -- 6. Статус
    statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.85, 0, 0, 30)
    statusLabel.Position = UDim2.new(0.075, 0, 0, yPos + 10)
    statusLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    statusLabel.BackgroundTransparency = 0.5
    statusLabel.Text = "📊 Статус: Очікування..."
    statusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Parent = mainFrame
    
    print("✅ GUI створено успішно!")
    log("Меню створено! Натискайте кнопки")
    
    return true
end

-- ============================================
-- ОСНОВНІ ФУНКЦІЇ
-- ============================================

-- [1] ОТРИМАННЯ РІВНЯ
local function getPlayerLevel()
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

-- [2] СПИСОК ВОРОГІВ ЗА РІВНЕМ
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

-- [3] ПОШУК ВОРОГІВ
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

-- [4] ПОШУК НАЙБЛИЖЧОГО ВОРОГА
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

-- [5] ТЕЛЕПОРТ НА ВИСОТУ
local function flyToEnemy(target)
    if not target then return false end
    local character = player.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
    local hrp = target:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local targetPos = hrp.Position
    rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, settings.FlyHeight, 0))
    return true
end

-- [6] АТАКА (3 СПОСОБИ)
local function attack()
    local success = false
    
    -- Спосіб 1: VirtualInputManager
    pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, settings.AttackKey, false, nil)
        wait(0.1)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, settings.AttackKey, false, nil)
        success = true
    end)
    
    -- Спосіб 2: UserInputService
    if not success then
        pcall(function()
            local uis = game:GetService("UserInputService")
            uis.InputBegan:Fire(Enum.KeyCode[settings.AttackKey], Enum.UserInputState.Begin, nil)
            wait(0.1)
            uis.InputEnded:Fire(Enum.KeyCode[settings.AttackKey], Enum.UserInputState.End, nil)
            success = true
        end)
    end
    
    -- Спосіб 3: Натискання через ContextActionService
    if not success then
        pcall(function()
            local cas = game:GetService("ContextActionService")
            cas:BindAction("Attack", function() end, false, Enum.KeyCode[settings.AttackKey])
            cas:FireAction("Attack", Enum.UserInputState.Begin, nil)
            wait(0.1)
            cas:FireAction("Attack", Enum.UserInputState.End, nil)
            success = true
        end)
    end
    
    return success
end

-- [7] ЗБІР ФРУКТІВ
local function collectFruits()
    local character = player.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") then
            local name = v.Name:lower()
            if name:find("fruit") or name:find("apple") or name:find("banana") or 
               name:find("bomb") or name:find("chest") then
                local handle = v:FindFirstChild("Handle")
                if handle then
                    local dist = (rootPart.Position - handle.Position).Magnitude
                    if dist < 25 then
                        rootPart.CFrame = CFrame.new(handle.Position + Vector3.new(0, 2, 0))
                        wait(0.2)
                        pcall(function()
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, settings.CollectKey, false, nil)
                            wait(0.1)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, settings.CollectKey, false, nil)
                        end)
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- [8] АВТО-КВЕСТ
local function autoQuest()
    local level = getPlayerLevel()
    local character = player.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
    -- Шукаємо NPC для квесту
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            local hrp = v:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (rootPart.Position - hrp.Position).Magnitude
                if dist < 30 then
                    -- Підходимо до NPC
                    rootPart.CFrame = hrp.CFrame * CFrame.new(0, 2, 3)
                    wait(0.5)
                    -- Натискаємо E
                    pcall(function()
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, nil)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, nil)
                    end)
                    return true
                end
            end
        end
    end
    return false
end

-- ============================================
-- ГОЛОВНИЙ ЦИКЛ (З ДІАГНОСТИКОЮ)
-- ============================================
local function mainLoop()
    local loopCount = 0
    
    while wait(1) do
        loopCount = loopCount + 1
        
        -- Оновлюємо персонажа
        if not player.Character then
            log("⏳ Очікування персонажа...")
            player.CharacterAdded:Wait()
            log("✅ Персонаж з'явився!")
        end
        
        local character = player.Character
        if not character then continue end
        
        local status = "Очікування..."
        local level = getPlayerLevel()
        
        -- [A] АВТО-ФАРМ
        if settings.AutoFarm then
            local enemy = getNearestEnemy()
            if enemy then
                local enemyName = enemy.Name
                status = "⚔️ Атака: " .. enemyName .. " (Рівень: " .. level .. ")"
                
                if settings.AutoTeleport then
                    flyToEnemy(enemy)
                end
                
                local attacked = attack()
                if attacked then
                    status = status .. " ✅"
                else
                    status = status .. " ❌ (помилка атаки)"
                end
            else
                local enemiesCount = #getTargetEnemies()
                status = "🔍 Пошук ворогів для рівня " .. level .. " (знайдено: " .. enemiesCount .. ")"
            end
        end
        
        -- [B] АВТО-ЗБІР
        if settings.AutoCollect then
            local collected = collectFruits()
            if collected then
                status = "🍎 Зібрано фрукт!"
            end
        end
        
        -- [C] АВТО-КВЕСТ
        if settings.AutoQuest then
            local questTaken = autoQuest()
            if questTaken then
                status = "📋 Квест взято!"
            end
        end
        
        -- Оновлюємо статус (з захистом від помилок)
        pcall(function()
            if statusLabel then
                statusLabel.Text = "📊 " .. status
            end
        end)
        
        -- Логування кожні 10 циклів
        if loopCount % 10 == 0 then
            log("🔄 Цикл " .. loopCount .. " | Рівень: " .. level .. " | Статус: " .. status)
        end
    end
end

-- ============================================
-- ЗАПУСК
-- ============================================

print("=" .. string.rep("=", 60))
print("🔄 ЗАПУСК ВСІХ СИСТЕМ...")
print("=" .. string.rep("=", 60))

-- Створюємо GUI
local guiCreated = pcall(createGUI)
if guiCreated then
    print("✅ GUI створено успішно!")
else
    print("❌ Помилка створення GUI! Спробуйте інший екзекутор.")
end

-- Запускаємо головний цикл
spawn(mainLoop)

-- Повідомлення
wait(2)
print("=" .. string.rep("=", 60))
print("🎯 СКРИПТ ГОТОВИЙ ДО РОБОТИ!")
print("📌 МЕНЮ ПОВИННО З'ЯВИТИСЯ В ЦЕНТРІ ЕКРАНУ")
print("📌 НАТИСНІТЬ F9 ДЛЯ ПЕРЕГЛЯДУ ЛОГІВ")
print("📌 ПЕРЕВІРТЕ, ЩО ВИ В ГРІ, А НЕ В ЛОБІ")
print("=" .. string.rep("=", 60))

-- Спроба показати сповіщення
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✅ СКРИПТ ЗАПУЩЕНО!",
        Text = "Меню в центрі екрану. Натисніть F9 для логів.",
        Duration = 5
    })
end)