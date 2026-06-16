-- ============================================
-- СПРОЩЕНИЙ СКРИПТ ДЛЯ BLOX FRUITS
-- ============================================

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ========== НАЛАШТУВАННЯ ==========
local settings = {
    AutoFarm = false,
    FarmRadius = 50,
    FlyHeight = 5
}

-- ========== СТВОРЕННЯ GUI ==========
local function createGUI()
    -- Головний екран
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BloxFruitsGUI"
    screenGui.Parent = playerGui
    
    -- Головне вікно
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BackgroundTransparency = 0.1
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
    title.BackgroundTransparency = 0.3
    title.Text = "⚡ BLOX FRUITS ⚡"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Кнопка закриття
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Функція створення кнопки
    local function createButton(name, yPos, color, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.85, 0, 0, 35)
        btn.Position = UDim2.new(0.075, 0, 0, yPos)
        btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 70)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 15
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(80, 80, 90)
        btn.Parent = mainFrame
        btn.MouseButton1Click:Connect(callback)
        return btn
    end
    
    -- Кнопка Авто-фарм
    local yPos = 50
    local farmBtn = createButton("🤖 АВТО-ФАРМ [ВИКЛ]", yPos, Color3.fromRGB(60, 60, 70), function()
        settings.AutoFarm = not settings.AutoFarm
        farmBtn.Text = settings.AutoFarm and "🤖 АВТО-ФАРМ [ВКЛ]" or "🤖 АВТО-ФАРМ [ВИКЛ]"
        farmBtn.BackgroundColor3 = settings.AutoFarm and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(60, 60, 70)
    end)
    
    -- Статус
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.85, 0, 0, 30)
    statusLabel.Position = UDim2.new(0.075, 0, 0, 230)
    statusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    statusLabel.BackgroundTransparency = 0.5
    statusLabel.Text = "Статус: Очікування..."
    statusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Parent = mainFrame
    
    return statusLabel, screenGui
end

-- ========== ОСНОВНІ ФУНКЦІЇ ==========

-- Отримання рівня
local function getPlayerLevel()
    local level = 0
    local stats = player:FindFirstChild("Stats")
    if stats then
        local levelStat = stats:FindFirstChild("Level")
        if levelStat then
            level = levelStat.Value
        end
    end
    if level == 0 then
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local levelStat = leaderstats:FindFirstChild("Level")
            if levelStat then
                level = levelStat.Value
            end
        end
    end
    return level
end

-- Пошук ворогів
local function getNearestEnemy()
    local character = player.Character
    if not character then return nil end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end
    
    local nearest = nil
    local shortestDist = settings.FarmRadius
    
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            local hum = v:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 and v.Name ~= player.Name then
                local hrp = v:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (rootPart.Position - hrp.Position).Magnitude
                    if dist < shortestDist then
                        nearest = v
                        shortestDist = dist
                    end
                end
            end
        end
    end
    return nearest
end

-- Телепорт на висоту
local function flyToEnemy(target)
    local character = player.Character
    if not character then return false end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
    if target and target:FindFirstChild("HumanoidRootPart") then
        local targetPos = target.HumanoidRootPart.Position
        rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, settings.FlyHeight, 0))
        return true
    end
    return false
end

-- Атака
local function attack()
    pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "Q", false, nil)
        wait(0.1)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "Q", false, nil)
    end)
end

-- ========== ГОЛОВНИЙ ЦИКЛ ==========

local function mainLoop(statusLabel)
    while wait(0.5) do
        if settings.AutoFarm then
            local enemy = getNearestEnemy()
            local character = player.Character
            
            if enemy and character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    -- Перевіряємо, чи ми вже на висоті
                    local currentPos = rootPart.Position
                    local targetPos = enemy.HumanoidRootPart.Position
                    local heightDiff = currentPos.Y - targetPos.Y
                    
                    -- Якщо ми не на потрібній висоті - телепортуємо
                    if heightDiff < settings.FlyHeight - 1 or heightDiff > settings.FlyHeight + 1 then
                        flyToEnemy(enemy)
                    end
                    
                    attack()
                    
                    if statusLabel then
                        statusLabel.Text = "Статус: ⚔️ Атака " .. enemy.Name
                    end
                end
            else
                if statusLabel then
                    statusLabel.Text = "Статус: 🔍 Пошук ворогів..."
                end
            end
        else
            if statusLabel then
                statusLabel.Text = "Статус: ⏸ Очікування..."
            end
        end
    end
end

-- ========== ЗАПУСК ==========

print("⚠️ ЗАПУСК СКРИПТА...")

-- Створюємо GUI
local statusLabel = createGUI()

print("✅ GUI СТВОРЕНО!")

-- Запускаємо цикл
spawn(function()
    mainLoop(statusLabel)
end)

print("✅ СКРИПТ ГОТОВИЙ ДО РОБОТИ!")
print("✅ Шукайте вікно в грі!")