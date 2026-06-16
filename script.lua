-- ============================================
-- НАВЧАЛЬНИЙ СКРИПТ ДЛЯ BLOX FRUITS
-- ВСІ ФУНКЦІЇ ТІЛЬКИ ДЛЯ ДЕМОНСТРАЦІЇ
-- НЕ ВИКОРИСТОВУЙТЕ В РЕАЛЬНІЙ ГРІ!
-- ============================================

-- Отримуємо гравця
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Змінні для налаштувань
local settings = {
    AutoFarm = false,
    AutoCollect = false,
    AutoTeleport = false,
    FarmRadius = 50,
    AttackKey = "Q",
    CollectKey = "E"
}

-- ========== СТВОРЕННЯ GUI МЕНЮ ==========
local function createGUI()
    -- Головне вікно
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BloxFruitsGUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Основний фрейм
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
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
    
    -- Функція створення кнопки-перемикача
    local function createToggle(name, yPos, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.9, 0, 0, 35)
        frame.Position = UDim2.new(0.05, 0, 0, yPos)
        frame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        frame.BackgroundTransparency = 0.3
        frame.BorderSizePixel = 1
        frame.BorderColor3 = Color3.fromRGB(80, 80, 90)
        frame.Parent = mainFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 5, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 16
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 50, 0, 25)
        btn.Position = UDim2.new(0.7, 0, 0.5, -12.5)
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        btn.Text = "ВИКЛ"
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.Parent = frame
        
        local isOn = false
        btn.MouseButton1Click:Connect(function()
            isOn = not isOn
            btn.Text = isOn and "ВКЛ" or "ВИКЛ"
            btn.BackgroundColor3 = isOn and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(60, 60, 70)
            callback(isOn)
        end)
        
        return btn
    end
    
    -- ===== СТВОРЮЄМО ВСІ КНОПКИ =====
    local yOffset = 50
    
    -- Авто-фарм
    createToggle("🤖 Авто-фарм", yOffset, function(state)
        settings.AutoFarm = state
        print("Авто-фарм: " .. tostring(state))
    end)
    yOffset = yOffset + 45
    
    -- Авто-збір фруктів
    createToggle("🍎 Авто-збір фруктів", yOffset, function(state)
        settings.AutoCollect = state
        print("Авто-збір: " .. tostring(state))
    end)
    yOffset = yOffset + 45
    
    -- Авто-телепорт
    createToggle("🌀 Авто-телепорт", yOffset, function(state)
        settings.AutoTeleport = state
        print("Авто-телепорт: " .. tostring(state))
    end)
    yOffset = yOffset + 55
    
    -- Повзунок радіусу
    local radiusFrame = Instance.new("Frame")
    radiusFrame.Size = UDim2.new(0.9, 0, 0, 40)
    radiusFrame.Position = UDim2.new(0.05, 0, 0, yOffset)
    radiusFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    radiusFrame.BackgroundTransparency = 0.3
    radiusFrame.BorderSizePixel = 1
    radiusFrame.BorderColor3 = Color3.fromRGB(80, 80, 90)
    radiusFrame.Parent = mainFrame
    
    local radiusLabel = Instance.new("TextLabel")
    radiusLabel.Size = UDim2.new(0.6, 0, 1, 0)
    radiusLabel.Position = UDim2.new(0, 5, 0, 0)
    radiusLabel.BackgroundTransparency = 1
    radiusLabel.Text = "📏 Радіус: 50"
    radiusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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
            radiusLabel.Text = "📏 Радіус: " .. num
        else
            radiusSlider.Text = tostring(settings.FarmRadius)
        end
    end)
    
    yOffset = yOffset + 55
    
    -- Статус
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 30)
    statusLabel.Position = UDim2.new(0.05, 0, 0, yOffset)
    statusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    statusLabel.Text = "Статус: Очікування..."
    statusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Parent = mainFrame
    
    return statusLabel
end

-- ========== ОСНОВНІ ФУНКЦІЇ ==========

-- Пошук найближчого ворога
local function getNearestEnemy()
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

-- Телепорт до цілі
local function teleportTo(target)
    if target and target:FindFirstChild("HumanoidRootPart") then
        local targetPos = target.HumanoidRootPart.Position
        rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 5, 0))
        return true
    end
    return false
end

-- Атака
local function attackTarget(target)
    if target and target:FindFirstChild("HumanoidRootPart") then
        -- Повертаємо гравця до цілі
        rootPart.CFrame = CFrame.new(rootPart.Position, target.HumanoidRootPart.Position)
        wait(0.1)
        -- Симуляція атаки (тільки демонстрація)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, settings.AttackKey, false, nil)
        wait(0.15)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, settings.AttackKey, false, nil)
        return true
    end
    return false
end

-- Збір фруктів
local function collectFruits()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") then
            local name = v.Name:lower()
            if name:find("fruit") or name:find("apple") or name:find("banana") or name:find("bomb") then
                local dist = (rootPart.Position - v.Handle.Position).Magnitude
                if dist < 20 then
                    rootPart.CFrame = CFrame.new(v.Handle.Position + Vector3.new(0, 2, 0))
                    wait(0.2)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, settings.CollectKey, false, nil)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, settings.CollectKey, false, nil)
                    return true
                end
            end
        end
    end
    return false
end

-- ========== ГОЛОВНИЙ ЦИКЛ ==========

local function mainLoop(statusLabel)
    while true do
        wait(0.5)
        
        if not character or not character.Parent then
            character = player.Character or player.CharacterAdded:Wait()
            rootPart = character:WaitForChild("HumanoidRootPart")
        end
        
        local status = "Очікування..."
        
        -- Авто-фарм
        if settings.AutoFarm then
            local enemy = getNearestEnemy()
            if enemy then
                status = "⚔️ Атака: " .. enemy.Name
                if settings.AutoTeleport then
                    teleportTo(enemy)
                end
                attackTarget(enemy)
            else
                status = "🔍 Пошук ворогів..."
            end
        end
        
        -- Авто-збір
        if settings.AutoCollect then
            if collectFruits() then
                status = "🍎 Збір фруктів..."
            end
        end
        
        -- Оновлюємо статус
        if statusLabel then
            statusLabel.Text = "Статус: " .. status
        end
    end
end

-- ========== ЗАПУСК ==========

print("⚠️ НАВЧАЛЬНИЙ СКРИПТ ЗАПУЩЕНО!")
print("⚠️ ВИКОРИСТАННЯ В РЕАЛЬНІЙ ГРІ ЗАБОРОНЕНО!")

-- Створюємо GUI
local statusLabel = createGUI()

-- Запускаємо головний цикл у окремому потоці
spawn(function()
    mainLoop(statusLabel)
end)

-- Повідомлення про запуск
wait(1)
print("✅ Меню створено! Шукайте вікно в грі.")