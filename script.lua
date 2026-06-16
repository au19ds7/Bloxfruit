-- ============================================
-- ПОКРАЩЕНИЙ СКРИПТ З АВТО-ФАРМОМ ПО РІВНЮ
-- АВТОМАТИЧНЕ ВИЗНАЧЕННЯ ВОРОГІВ ТА КВЕСТІВ
-- ============================================

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local userInput = game:GetService("UserInputService")
local virtualInput = game:GetService("VirtualInputManager")
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

-- ========== НАЛАШТУВАННЯ ==========
local settings = {
    AutoFarm = false,
    AutoCollect = false,
    AutoTeleport = false,
    AutoKillAura = false,
    AutoEat = false,
    AutoQuest = false,
    FarmRadius = 50,
    Language = "UA",
    Theme = "dark",
    MenuOpen = true,
    FlyHeight = 5 -- Висота польоту над ворогами
}

-- ========== ДАНІ ПРО РІВНІ ТА ВОРОГІВ ==========
local enemyData = {
    -- Рівень 1-10: Бандити
    {minLevel = 1, maxLevel = 10, enemyNames = {"Bandit", "Brute", "Pirate"}, questGiver = "Bandit Quest", questName = "Bandit"},
    -- Рівень 10-25: Морські пірати
    {minLevel = 10, maxLevel = 25, enemyNames = {"Marine", "Sailor", "Captain"}, questGiver = "Marine Quest", questName = "Marine"},
    -- Рівень 25-40: Гали
    {minLevel = 25, maxLevel = 40, enemyNames = {"Galley", "Crew", "Navigator"}, questGiver = "Galley Quest", questName = "Galley"},
    -- Рівень 40-60: Мавпи
    {minLevel = 40, maxLevel = 60, enemyNames = {"Monkey", "Gorilla", "Ape"}, questGiver = "Monkey Quest", questName = "Monkey"},
    -- Рівень 60-80: Пірати
    {minLevel = 60, maxLevel = 80, enemyNames = {"Pirate", "Corsair", "Buccaneer"}, questGiver = "Pirate Quest", questName = "Pirate"},
    -- Рівень 80-100: Мечники
    {minLevel = 80, maxLevel = 100, enemyNames = {"Swordsman", "Samurai", "Ninja"}, questGiver = "Swordsman Quest", questName = "Swordsman"},
    -- Рівень 100-125: Маги
    {minLevel = 100, maxLevel = 125, enemyNames = {"Mage", "Wizard", "Sorcerer"}, questGiver = "Mage Quest", questName = "Mage"},
    -- Рівень 125-150: Лицарі
    {minLevel = 125, maxLevel = 150, enemyNames = {"Knight", "Paladin", "Warrior"}, questGiver = "Knight Quest", questName = "Knight"},
    -- Рівень 150-175: Дракони
    {minLevel = 150, maxLevel = 175, enemyNames = {"Dragon", "Wyvern", "Drake"}, questGiver = "Dragon Quest", questName = "Dragon"},
    -- Рівень 175-200: Асарди
    {minLevel = 175, maxLevel = 200, enemyNames = {"Asard", "Astaroth", "Demon"}, questGiver = "Asard Quest", questName = "Asard"},
    -- Рівень 200-225: Титани
    {minLevel = 200, maxLevel = 225, enemyNames = {"Titan", "Giant", "Colossus"}, questGiver = "Titan Quest", questName = "Titan"},
    -- Рівень 225-250: Боги
    {minLevel = 225, maxLevel = 250, enemyNames = {"God", "Deity", "Angel"}, questGiver = "God Quest", questName = "God"},
    -- Рівень 250-275: Імператори
    {minLevel = 250, maxLevel = 275, enemyNames = {"Emperor", "King", "Lord"}, questGiver = "Emperor Quest", questName = "Emperor"},
    -- Рівень 275-300: Легенди
    {minLevel = 275, maxLevel = 300, enemyNames = {"Legend", "Myth", "Hero"}, questGiver = "Legend Quest", questName = "Legend"},
}

-- ========== ПЕРЕКЛАДИ ==========
local translations = {
    UA = {
        title = "⚡ BLOX FRUITS МЕНЮ ⚡",
        autoFarm = "🤖 АВТО-ФАРМ [РІВЕНЬ]",
        autoCollect = "🍎 ЗБІР ФРУКТІВ",
        autoTeleport = "🌀 ТЕЛЕПОРТ",
        killAura = "💀 КІЛЛ-АУРА",
        autoEat = "🍖 АВТО-ЇЖА",
        autoQuest = "📋 АВТО-КВЕСТ",
        radius = "📏 РАДІУС",
        status = "Статус",
        waiting = "Очікування...",
        attacking = "Атака",
        searching = "Пошук ворогів...",
        collecting = "Збір фруктів...",
        eating = "Їжа...",
        quest = "Квест взято!",
        level = "Рівень",
        on = "ВКЛ",
        off = "ВИКЛ",
        language = "🌐 МОВА",
        theme = "🎨 ТЕМА",
        flyHeight = "⬆ ВИСОТА"
    },
    EN = {
        title = "⚡ BLOX FRUITS MENU ⚡",
        autoFarm = "🤖 AUTO FARM [LEVEL]",
        autoCollect = "🍎 COLLECT FRUITS",
        autoTeleport = "🌀 TELEPORT",
        killAura = "💀 KILL AURA",
        autoEat = "🍖 AUTO EAT",
        autoQuest = "📋 AUTO QUEST",
        radius = "📏 RADIUS",
        status = "Status",
        waiting = "Waiting...",
        attacking = "Attacking",
        searching = "Searching enemies...",
        collecting = "Collecting fruits...",
        eating = "Eating...",
        quest = "Quest taken!",
        level = "Level",
        on = "ON",
        off = "OFF",
        language = "🌐 LANGUAGE",
        theme = "🎨 THEME",
        flyHeight = "⬆ HEIGHT"
    },
    RU = {
        title = "⚡ BLOX FRUITS МЕНЮ ⚡",
        autoFarm = "🤖 АВТО-ФАРМ [УРОВЕНЬ]",
        autoCollect = "🍎 СБОР ФРУКТОВ",
        autoTeleport = "🌀 ТЕЛЕПОРТ",
        killAura = "💀 КИЛЛ-АУРА",
        autoEat = "🍖 АВТО-ЕДА",
        autoQuest = "📋 АВТО-КВЕСТ",
        radius = "📏 РАДИУС",
        status = "Статус",
        waiting = "Ожидание...",
        attacking = "Атака",
        searching = "Поиск врагов...",
        collecting = "Сбор фруктов...",
        eating = "Еда...",
        quest = "Квест взят!",
        level = "Уровень",
        on = "ВКЛ",
        off = "ВЫКЛ",
        language = "🌐 ЯЗЫК",
        theme = "🎨 ТЕМА",
        flyHeight = "⬆ ВЫСОТА"
    }
}

-- ========== ТЕМИ ==========
local themes = {
    dark = {
        bg = Color3.fromRGB(30, 30, 40),
        bg2 = Color3.fromRGB(50, 50, 60),
        text = Color3.fromRGB(255, 255, 255),
        accent = Color3.fromRGB(255, 170, 0),
        button = Color3.fromRGB(60, 60, 70),
        buttonOn = Color3.fromRGB(0, 200, 0),
        buttonOff = Color3.fromRGB(200, 50, 50),
        border = Color3.fromRGB(80, 80, 90)
    },
    light = {
        bg = Color3.fromRGB(240, 240, 245),
        bg2 = Color3.fromRGB(220, 220, 225),
        text = Color3.fromRGB(30, 30, 40),
        accent = Color3.fromRGB(255, 170, 0),
        button = Color3.fromRGB(200, 200, 210),
        buttonOn = Color3.fromRGB(0, 200, 0),
        buttonOff = Color3.fromRGB(200, 50, 50),
        border = Color3.fromRGB(180, 180, 190)
    },
    blue = {
        bg = Color3.fromRGB(20, 30, 60),
        bg2 = Color3.fromRGB(30, 50, 90),
        text = Color3.fromRGB(200, 220, 255),
        accent = Color3.fromRGB(0, 150, 255),
        button = Color3.fromRGB(40, 60, 100),
        buttonOn = Color3.fromRGB(0, 200, 0),
        buttonOff = Color3.fromRGB(200, 50, 50),
        border = Color3.fromRGB(60, 80, 120)
    },
    red = {
        bg = Color3.fromRGB(60, 20, 20),
        bg2 = Color3.fromRGB(90, 30, 30),
        text = Color3.fromRGB(255, 200, 200),
        accent = Color3.fromRGB(255, 50, 50),
        button = Color3.fromRGB(100, 40, 40),
        buttonOn = Color3.fromRGB(0, 200, 0),
        buttonOff = Color3.fromRGB(200, 50, 50),
        border = Color3.fromRGB(120, 60, 60)
    }
}

-- ========== ЗМІННІ GUI ==========
local screenGui = nil
local mainFrame = nil
local statusLabel = nil
local levelLabel = nil
local themeColors = themes[settings.Theme]
local lang = translations[settings.Language]

-- ========== ОТРИМАННЯ РІВНЯ ГРАВЦЯ ==========
local function getPlayerLevel()
    local level = 0
    -- Спроба отримати рівень з різних джерел
    local stats = player:FindFirstChild("Stats")
    if stats then
        local levelStat = stats:FindFirstChild("Level")
        if levelStat then
            level = levelStat.Value
        end
    end
    
    -- Якщо не знайшли, спробуємо через Leaderstats
    if level == 0 then
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local levelStat = leaderstats:FindFirstChild("Level")
            if levelStat then
                level = levelStat.Value
            end
        end
    end
    
    -- Якщо все ще 0, спробуємо через інші можливі шляхи
    if level == 0 then
        for _, v in pairs(player:GetChildren()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                if string.find(v.Name:lower(), "level") or string.find(v.Name:lower(), "lvl") then
                    level = v.Value
                    break
                end
            end
        end
    end
    
    return level
end

-- ========== ВИЗНАЧЕННЯ ВОРОГІВ ДЛЯ РІВНЯ ==========
local function getEnemiesForLevel(level)
    local enemies = {}
    for _, data in pairs(enemyData) do
        if level >= data.minLevel and level <= data.maxLevel then
            for _, name in pairs(data.enemyNames) do
                table.insert(enemies, name)
            end
        end
    end
    return enemies
end

-- ========== ПОШУК ВОРОГІВ ДЛЯ ПОТОЧНОГО РІВНЯ ==========
local function getTargetEnemies()
    local level = getPlayerLevel()
    local targetNames = getEnemiesForLevel(level)
    local enemies = {}
    
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            local hum = v:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 and not players:FindFirstChild(v.Name) then
                -- Перевіряємо, чи є цей ворог у списку цілей
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

-- ========== ПОШУК НАЙБЛИЖЧОГО ВОРОГА З РІВНЯ ==========
local function getNearestTargetEnemy()
    local enemies = getTargetEnemies()
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

-- ========== ТЕЛЕПОРТ НА ВИСОТУ 5 МЕТРІВ ==========
local function flyToEnemy(target)
    if target and target:FindFirstChild("HumanoidRootPart") then
        local targetPos = target.HumanoidRootPart.Position
        -- Телепортуємо на 5 метрів вище ворога
        local flyPos = targetPos + Vector3.new(0, settings.FlyHeight, 0)
        rootPart.CFrame = CFrame.new(flyPos)
        return true
    end
    return false
end

-- ========== ВЗЯТТЯ КВЕСТУ ==========
local function takeQuest()
    local level = getPlayerLevel()
    local questData = nil
    
    -- Знаходимо квест для поточного рівня
    for _, data in pairs(enemyData) do
        if level >= data.minLevel and level <= data.maxLevel then
            questData = data
            break
        end
    end
    
    if not questData then return false end
    
    -- Шукаємо видавця квесту
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            -- Перевіряємо, чи це видавець квесту
            if string.find(v.Name, questData.questGiver) or string.find(v.Name, "NPC") then
                -- Телепортуємося до NPC
                local hrp = v:FindFirstChild("HumanoidRootPart")
                if hrp then
                    rootPart.CFrame = hrp.CFrame * CFrame.new(0, 2, 3)
                    wait(0.5)
                    -- Натискаємо E для взаємодії
                    pcall(function()
                        virtualInput:SendKeyEvent(true, "E", false, nil)
                        wait(0.2)
                        virtualInput:SendKeyEvent(false, "E", false, nil)
                    end)
                    wait(0.5)
                    -- Шукаємо квест у GUI
                    local playerGui = player:FindFirstChild("PlayerGui")
                    if playerGui then
                        for _, gui in pairs(playerGui:GetChildren()) do
                            if gui:IsA("ScreenGui") then
                                -- Шукаємо кнопку квесту
                                local questButton = findQuestButton(gui, questData.questName)
                                if questButton then
                                    questButton:Activate()
                                    return true
                                end
                            end
                        end
                    end
                    return true
                end
            end
        end
    end
    return false
end

-- ========== ПОШУК КНОПКИ КВЕСТУ В GUI ==========
function findQuestButton(gui, questName)
    for _, child in pairs(gui:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("ImageButton") then
            if string.find(child.Name, questName) or string.find(child.Text, questName) then
                return child
            end
        end
        -- Рекурсивний пошук
        if child:GetChildren() then
            local found = findQuestButton(child, questName)
            if found then return found end
        end
    end
    return nil
end

-- ========== АТАКА ==========
function attack()
    pcall(function()
        virtualInput:SendKeyEvent(true, "Q", false, nil)
        wait(0.1)
        virtualInput:SendKeyEvent(false, "Q", false, nil)
    end)
end

-- ========== ЗБІР ФРУКТІВ ==========
function collectFruits()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") then
            local name = v.Name:lower()
            if name:find("fruit") or name:find("apple") or name:find("banana") or 
               name:find("bomb") or name:find("chest") or v:FindFirstChild("Fruit") then
                local hrp = v:FindFirstChild("Handle")
                if hrp then
                    local dist = (rootPart.Position - hrp.Position).Magnitude
                    if dist < 25 then
                        rootPart.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 2, 0))
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

-- ========== АВТО-ЇЖА ==========
function autoEat()
    local hum = character:FindFirstChild("Humanoid")
    if hum and hum.Health < hum.MaxHealth * 0.4 then
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, item in pairs(backpack:GetChildren()) do
                if item:IsA("Tool") and (string.find(item.Name:lower(), "food") or 
                   string.find(item.Name:lower(), "apple") or 
                   string.find(item.Name:lower(), "bread")) then
                    player:FindFirstChild("Backpack"):FindFirstChild(item.Name):Activate()
                    wait(1)
                    return true
                end
            end
        end
    end
    return false
end

-- ========== КІЛЛ-АУРА ==========
function killAura()
    local enemies = getTargetEnemies()
    for _, enemy in pairs(enemies) do
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        if hrp then
            local dist = (rootPart.Position - hrp.Position).Magnitude
            if dist < settings.FarmRadius then
                flyToEnemy(enemy)
                attack()
                wait(0.1)
            end
        end
    end
end

-- ========== ФУНКЦІЯ ОНОВЛЕННЯ GUI ==========
local function updateGUI()
    if not mainFrame then return end
    
    local theme = themes[settings.Theme]
    local lang = translations[settings.Language]
    
    mainFrame.BackgroundColor3 = theme.bg
    mainFrame.BackgroundTransparency = 0.1
    
    for _, child in pairs(mainFrame:GetChildren()) do
        if child:IsA("TextButton") then
            if child.BackgroundColor3 ~= Color3.fromRGB(0, 200, 0) and 
               child.BackgroundColor3 ~= Color3.fromRGB(200, 50, 50) then
                child.BackgroundColor3 = theme.button
            end
            child.TextColor3 = theme.text
        elseif child:IsA("TextLabel") then
            if child.Text ~= lang.title then
                child.TextColor3 = theme.text
            end
        end
    end
end

-- ========== СТВОРЕННЯ МЕНЮ ==========
local function createGUI()
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BloxFruitsGUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -300)
    mainFrame.BackgroundColor3 = themeColors.bg
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = themeColors.accent
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = themeColors.accent
    title.BackgroundTransparency = 0.3
    title.Text = lang.title
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Кнопка закриття
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -40, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 20
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        settings.MenuOpen = false
        mainFrame.Visible = false
    end)
    
    -- Кнопка згортання
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
    minimizeBtn.Position = UDim2.new(1, -80, 0, 5)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    minimizeBtn.Text = "─"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.TextSize = 20
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Parent = mainFrame
    minimizeBtn.MouseButton1Click:Connect(function()
        mainFrame.Size = UDim2.new(0, 400, 0, 45)
        for _, child in pairs(mainFrame:GetChildren()) do
            if child ~= title and child ~= closeBtn and child ~= minimizeBtn then
                child.Visible = not child.Visible
            end
        end
    end)
    
    -- Рівень гравця
    levelLabel = Instance.new("TextLabel")
    levelLabel.Size = UDim2.new(1, 0, 0, 30)
    levelLabel.Position = UDim2.new(0, 0, 0, 48)
    levelLabel.BackgroundColor3 = themeColors.bg2
    levelLabel.BackgroundTransparency = 0.5
    levelLabel.Text = lang.level .. ": " .. getPlayerLevel()
    levelLabel.TextColor3 = themeColors.accent
    levelLabel.TextSize = 16
    levelLabel.Font = Enum.Font.GothamBold
    levelLabel.Parent = mainFrame
    
    -- ===== КНОПКИ ФУНКЦІЙ =====
    local function createButton(name, yPos, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 35)
        btn.Position = UDim2.new(0.05, 0, 0, yPos)
        btn.BackgroundColor3 = themeColors.button
        btn.Text = name
        btn.TextColor3 = themeColors.text
        btn.TextSize = 15
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 1
        btn.BorderColor3 = themeColors.border
        btn.Parent = mainFrame
        btn.MouseButton1Click:Connect(callback)
        return btn
    end
    
    local yOffset = 85
    
    -- 1. АВТО-ФАРМ (оновлений)
    local farmBtn = createButton(lang.autoFarm .. " [" .. lang.off .. "]", yOffset, function()
        settings.AutoFarm = not settings.AutoFarm
        farmBtn.Text = lang.autoFarm .. " [" .. (settings.AutoFarm and lang.on or lang.off) .. "]"
        farmBtn.BackgroundColor3 = settings.AutoFarm and themeColors.buttonOn or themeColors.button
    end)
    yOffset = yOffset + 45
    
    -- 2. АВТО-КВЕСТ (нова функція)
    local questBtn = createButton(lang.autoQuest .. " [" .. lang.off .. "]", yOffset, function()
        settings.AutoQuest = not settings.AutoQuest
        questBtn.Text = lang.autoQuest .. " [" .. (settings.AutoQuest and lang.on or lang.off) .. "]"
        questBtn.BackgroundColor3 = settings.AutoQuest and themeColors.buttonOn or themeColors.button
    end)
    yOffset = yOffset + 45
    
    -- 3. ЗБІР ФРУКТІВ
    local collectBtn = createButton(lang.autoCollect .. " [" .. lang.off .. "]", yOffset, function()
        settings.AutoCollect = not settings.AutoCollect
        collectBtn.Text = lang.autoCollect .. " [" .. (settings.AutoCollect and lang.on or lang.off) .. "]"
        collectBtn.BackgroundColor3 = settings.AutoCollect and themeColors.buttonOn or themeColors.button
    end)
    yOffset = yOffset + 45
    
    -- 4. ТЕЛЕПОРТ
    local teleportBtn = createButton(lang.autoTeleport .. " [" .. lang.off .. "]", yOffset, function()
        settings.AutoTeleport = not settings.AutoTeleport
        teleportBtn.Text = lang.autoTeleport .. " [" .. (settings.AutoTeleport and lang.on or lang.off) .. "]"
        teleportBtn.BackgroundColor3 = settings.AutoTeleport and themeColors.buttonOn or themeColors.button
    end)
    yOffset = yOffset + 45
    
    -- 5. КІЛЛ-АУРА
    local auraBtn = createButton(lang.killAura .. " [" .. lang.off .. "]", yOffset, function()
        settings.AutoKillAura = not settings.AutoKillAura
        auraBtn.Text = lang.killAura .. " [" .. (settings.AutoKillAura and lang.on or lang.off) .. "]"
        auraBtn.BackgroundColor3 = settings.AutoKillAura and themeColors.buttonOn or themeColors.button
    end)
    yOffset = yOffset + 45
    
    -- 6. АВТО-ЇЖА
    local eatBtn = createButton(lang.autoEat .. " [" .. lang.off .. "]", yOffset, function()
        settings.AutoEat = not settings.AutoEat
        eatBtn.Text = lang.autoEat .. " [" .. (settings.AutoEat and lang.on or lang.off) .. "]"
        eatBtn.BackgroundColor3 = settings.AutoEat and themeColors.buttonOn or themeColors.button
    end)
    yOffset = yOffset + 45
    
    -- 7. РАДІУС
    local radiusFrame = Instance.new("Frame")
    radiusFrame.Size = UDim2.new(0.9, 0, 0, 35)
    radiusFrame.Position = UDim2.new(0.05, 0, 0, yOffset)
    radiusFrame.BackgroundColor3 = themeColors.bg2
    radiusFrame.BackgroundTransparency = 0.3
    radiusFrame.BorderSizePixel = 1
    radiusFrame.BorderColor3 = themeColors.border
    radiusFrame.Parent = mainFrame
    
    local radiusLabel = Instance.new("TextLabel")
    radiusLabel.Size = UDim2.new(0.5, 0, 1, 0)
    radiusLabel.Position = UDim2.new(0, 10, 0, 0)
    radiusLabel.BackgroundTransparency = 1
    radiusLabel.Text = lang.radius .. ": 50"
    radiusLabel.TextColor3 = themeColors.text
    radiusLabel.TextSize = 14
    radiusLabel.Font = Enum.Font.Gotham
    radiusLabel.TextXAlignment = Enum.TextXAlignment.Left
    radiusLabel.Parent = radiusFrame
    
    local radiusSlider = Instance.new("TextBox")
    radiusSlider.Size = UDim2.new(0, 60, 0, 25)
    radiusSlider.Position = UDim2.new(0.7, 0, 0.5, -12.5)
    radiusSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    radiusSlider.Text = "50"
    radiusSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
    radiusSlider.TextSize = 14
    radiusSlider.Font = Enum.Font.GothamBold
    radiusSlider.Parent = radiusFrame
    radiusSlider.FocusLost:Connect(function()
        local num = tonumber(radiusSlider.Text)
        if num and num > 0 and num < 500 then
            settings.FarmRadius = num
            radiusLabel.Text = lang.radius .. ": " .. num
        else
            radiusSlider.Text = tostring(settings.FarmRadius)
        end
    end)
    yOffset = yOffset + 45
    
    -- 8. ВИСОТА ПОЛЬОТУ
    local heightFrame = Instance.new("Frame")
    heightFrame.Size = UDim2.new(0.9, 0, 0, 35)
    heightFrame.Position = UDim2.new(0.05, 0, 0, yOffset)
    heightFrame.BackgroundColor3 = themeColors.bg2
    heightFrame.BackgroundTransparency = 0.3
    heightFrame.BorderSizePixel = 1
    heightFrame.BorderColor3 = themeColors.border
    heightFrame.Parent = mainFrame
    
    local heightLabel = Instance.new("TextLabel")
    heightLabel.Size = UDim2.new(0.5, 0, 1, 0)
    heightLabel.Position = UDim2.new(0, 10, 0, 0)
    heightLabel.BackgroundTransparency = 1
    heightLabel.Text = lang.flyHeight .. ": 5"
    heightLabel.TextColor3 = themeColors.text
    heightLabel.TextSize = 14
    heightLabel.Font = Enum.Font.Gotham
    heightLabel.TextXAlignment = Enum.TextXAlignment.Left
    heightLabel.Parent = heightFrame
    
    local heightSlider = Instance.new("TextBox")
    heightSlider.Size = UDim2.new(0, 60, 0, 25)
    heightSlider.Position = UDim2.new(0.7, 0, 0.5, -12.5)
    heightSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    heightSlider.Text = "5"
    heightSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
    heightSlider.TextSize = 14
    heightSlider.Font = Enum.Font.GothamBold
    heightSlider.Parent = heightFrame
    heightSlider.FocusLost:Connect(function()
        local num = tonumber(heightSlider.Text)
        if num and num > 0 and num < 20 then
            settings.FlyHeight = num
            heightLabel.Text = lang.flyHeight .. ": " .. num
        else
            heightSlider.Text = tostring(settings.FlyHeight)
        end
    end)
    yOffset = yOffset + 45
    
    -- 9. ЗМІНА МОВИ
    local langBtn = createButton(lang.language .. ": " .. settings.Language, yOffset, function()
        local languages = {"UA", "EN", "RU"}
        local currentIndex = table.find(languages, settings.Language) or 1
        local nextIndex = currentIndex % #languages + 1
        settings.Language = languages[nextIndex]
        lang = translations[settings.Language]
        langBtn.Text = lang.language .. ": " .. settings.Language
        updateAllTexts()
    end)
    yOffset = yOffset + 45
    
    -- 10. ЗМІНА ТЕМИ
    local themeBtn = createButton(lang.theme .. ": " .. settings.Theme, yOffset, function()
        local themesList = {"dark", "light", "blue", "red"}
        local currentIndex = table.find(themesList, settings.Theme) or 1
        local nextIndex = currentIndex % #themesList + 1
        settings.Theme = themesList[nextIndex]
        themeColors = themes[settings.Theme]
        themeBtn.Text = lang.theme .. ": " .. settings.Theme
        updateGUI()
    end)
    yOffset = yOffset + 45
    
    -- 11. СТАТУС
    statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 30)
    statusLabel.Position = UDim2.new(0.05, 0, 0, yOffset)
    statusLabel.BackgroundColor3 = themeColors.bg2
    statusLabel.BackgroundTransparency = 0.5
    statusLabel.Text = lang.status ..