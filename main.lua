local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local enabled = false
local clickInterval = 0.02
local lastClickTime = 0
local mousePos = Vector2.new(0, 0)
local clicking = false
local language = "ru"
local scriptVisible = true

local texts = {
    ru = {
        title = "AUTO CLICKER",
        status = "Статус",
        enabled = "ВКЛЮЧЕНО",
        disabled = "ВЫКЛЮЧЕНО",
        speed = "Скорость (мс):",
        hotkeys = "F6-Вкл F5-Выкл F4-Закр",
        author = "by - SkLp"
    },
    en = {
        title = "AUTO CLICKER",
        status = "Status",
        enabled = "ENABLED",
        disabled = "DISABLED",
        speed = "Speed (ms):",
        hotkeys = "F6-On F5-Off F4-Close",
        author = "by - SkLp"
    }
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoClickerGUI"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 250, 0, 220)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 28)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 10)
topBarCorner.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 12, 0, 12)
closeButton.Position = UDim2.new(0, 10, 0, 8)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 95, 87)
closeButton.BorderSizePixel = 0
closeButton.Text = ""
closeButton.ZIndex = 2
closeButton.Parent = topBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 12, 0, 12)
minimizeButton.Position = UDim2.new(0, 27, 0, 8)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 189, 46)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = ""
minimizeButton.ZIndex = 2
minimizeButton.Parent = topBar

local maximizeButton = Instance.new("TextButton")
maximizeButton.Name = "MaximizeButton"
maximizeButton.Size = UDim2.new(0, 12, 0, 12)
maximizeButton.Position = UDim2.new(0, 44, 0, 8)
maximizeButton.BackgroundColor3 = Color3.fromRGB(40, 201, 65)
maximizeButton.BorderSizePixel = 0
maximizeButton.Text = ""
maximizeButton.ZIndex = 2
maximizeButton.Parent = topBar

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(1, 0)
buttonCorner.Parent = closeButton
buttonCorner:Clone().Parent = minimizeButton
buttonCorner:Clone().Parent = maximizeButton

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, -60, 0, 28)
titleLabel.Position = UDim2.new(0, 60, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = texts[language].title
titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
titleLabel.Font = Enum.Font.Cartoon
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextStrokeTransparency = 0
titleLabel.Parent = topBar

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -28)
contentFrame.Position = UDim2.new(0, 0, 0, 28)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 20)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = texts[language].status .. ": " .. texts[language].disabled
statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
statusLabel.Font = Enum.Font.Cartoon
statusLabel.TextSize = 18
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
statusLabel.TextStrokeTransparency = 0
statusLabel.Parent = contentFrame

local speedFrame = Instance.new("Frame")
speedFrame.Name = "SpeedFrame"
speedFrame.Size = UDim2.new(1, -20, 0, 60)
speedFrame.Position = UDim2.new(0, 10, 0, 60)
speedFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedFrame.BorderSizePixel = 0
speedFrame.Parent = contentFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speedFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(1, 0, 0, 25)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = texts[language].speed
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Font = Enum.Font.Cartoon
speedLabel.TextSize = 16
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
speedLabel.TextStrokeTransparency = 0
speedLabel.Parent = speedFrame

local speedValue = Instance.new("TextBox")
speedValue.Name = "SpeedValue"
speedValue.Size = UDim2.new(0.35, 0, 0, 25)
speedValue.Position = UDim2.new(0.65, 0, 0, 0)
speedValue.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
speedValue.BorderColor3 = Color3.fromRGB(100, 100, 100)
speedValue.Text = "20"
speedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
speedValue.Font = Enum.Font.Cartoon
speedValue.TextSize = 16
speedValue.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
speedValue.TextStrokeTransparency = 0
speedValue.Parent = speedFrame

local speedValueCorner = Instance.new("UICorner")
speedValueCorner.CornerRadius = UDim.new(0, 6)
speedValueCorner.Parent = speedValue

local speedSlider = Instance.new("TextButton")
speedSlider.Name = "SpeedSlider"
speedSlider.Size = UDim2.new(1, 0, 0, 20)
speedSlider.Position = UDim2.new(0, 0, 0, 35)
speedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
speedSlider.BorderSizePixel = 0
speedSlider.AutoButtonColor = false
speedSlider.Text = ""
speedSlider.Parent = speedFrame

local sliderFill = Instance.new("Frame")
sliderFill.Name = "SliderFill"
sliderFill.Size = UDim2.new(0.98, 0, 1, 0)
sliderFill.Position = UDim2.new(0, 0, 0, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = speedSlider

local sliderUICorner = Instance.new("UICorner")
sliderUICorner.CornerRadius = UDim.new(0, 4)
sliderUICorner.Parent = speedSlider

local hotkeysLabel = Instance.new("TextLabel")
hotkeysLabel.Name = "Hotkeys"
hotkeysLabel.Size = UDim2.new(1, -20, 0, 40)
hotkeysLabel.Position = UDim2.new(0, 10, 0, 130)
hotkeysLabel.BackgroundTransparency = 1
hotkeysLabel.Text = texts[language].hotkeys
hotkeysLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
hotkeysLabel.Font = Enum.Font.Cartoon
hotkeysLabel.TextSize = 14
hotkeysLabel.TextXAlignment = Enum.TextXAlignment.Center
hotkeysLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
hotkeysLabel.TextStrokeTransparency = 0
hotkeysLabel.Parent = contentFrame

local authorLabel = Instance.new("TextLabel")
authorLabel.Name = "AuthorLabel"
authorLabel.Size = UDim2.new(1, 0, 0, 20)
authorLabel.Position = UDim2.new(0, 0, 1, -25)
authorLabel.BackgroundTransparency = 1
authorLabel.Text = texts[language].author
authorLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
authorLabel.Font = Enum.Font.Cartoon
authorLabel.TextSize = 14
authorLabel.TextXAlignment = Enum.TextXAlignment.Center
authorLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
authorLabel.TextStrokeTransparency = 0
authorLabel.Parent = contentFrame

local cursor = Instance.new("Frame")
cursor.Name = "MacCursor"
cursor.Size = UDim2.new(0, 32, 0, 32)
cursor.Position = UDim2.new(0.5, -16, 0.5, -16)
cursor.BackgroundTransparency = 1
cursor.ZIndex = 10000
cursor.Active = true
cursor.Selectable = true
cursor.Visible = true
cursor.Parent = screenGui

local cursorCanvas = Instance.new("Frame")
cursorCanvas.Name = "CursorCanvas"
cursorCanvas.Size = UDim2.new(1, 0, 1, 0)
cursorCanvas.BackgroundTransparency = 1
cursorCanvas.Parent = cursor

local mainArrow = Instance.new("Frame")
mainArrow.Name = "MainArrow"
mainArrow.Size = UDim2.new(1, 0, 1, 0)
mainArrow.Position = UDim2.new(0, 0, 0, 0)
mainArrow.BackgroundTransparency = 1
mainArrow.Parent = cursorCanvas

local function createTriangle(name, size, position, color, rotation)
    local triangle = Instance.new("Frame")
    triangle.Name = name
    triangle.Size = size
    triangle.Position = position
    triangle.BackgroundColor3 = color
    triangle.BorderSizePixel = 0
    triangle.BackgroundTransparency = 0
    triangle.Rotation = rotation or 0
    triangle.Parent = mainArrow
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 1)
    uiCorner.Parent = triangle
    
    return triangle
end

local arrowMain = createTriangle("ArrowMain", 
    UDim2.new(0, 24, 0, 32), 
    UDim2.new(0, 0, 0, 0), 
    Color3.fromRGB(255, 255, 255),
    -45)

local arrowOutline = createTriangle("ArrowOutline", 
    UDim2.new(0, 22, 0, 30), 
    UDim2.new(0, 1, 0, 1), 
    Color3.fromRGB(0, 0, 0),
    -45)

local arrowShadow = createTriangle("ArrowShadow", 
    UDim2.new(0, 24, 0, 32), 
    UDim2.new(0, 1, 0, 1), 
    Color3.fromRGB(0, 0, 0),
    -45)
arrowShadow.BackgroundTransparency = 0.3
arrowShadow.ZIndex = -1

local cursorTip = Instance.new("Frame")
cursorTip.Name = "CursorTip"
cursorTip.Size = UDim2.new(0, 4, 0, 4)
cursorTip.Position = UDim2.new(1, -6, 1, -6)
cursorTip.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
cursorTip.BackgroundTransparency = 0.7
cursorTip.BorderSizePixel = 0
cursorTip.ZIndex = 10001
cursorTip.Visible = false
cursorTip.Parent = cursor

local tipCorner = Instance.new("UICorner")
tipCorner.CornerRadius = UDim.new(1, 0)
tipCorner.Parent = cursorTip

local function updateLanguage()
    titleLabel.Text = texts[language].title
    statusLabel.Text = texts[language].status .. ": " .. (enabled and texts[language].enabled or texts[language].disabled)
    speedLabel.Text = texts[language].speed
    hotkeysLabel.Text = texts[language].hotkeys
    authorLabel.Text = texts[language].author
end

local rainbowHue = 0
local function updateRainbowHue()
    rainbowHue = (tick() * 0.5) % 1
end

local function applyRainbowColor(object, isCursor)
    if isCursor then
        arrowMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    else
        local color = Color3.fromHSV(rainbowHue, 0.8, 1)
        object.TextColor3 = color
    end
end

local function getCursorTipPosition()
    local cursorPos = cursor.AbsolutePosition
    local cursorSize = cursor.AbsoluteSize
    return Vector2.new(
        cursorPos.X + cursorSize.X - 8,
        cursorPos.Y + cursorSize.Y - 8
    )
end

local function performClick()
    if not clicking then
        clicking = true
        
        local cursorTipPos = getCursorTipPosition()
        
        local tweenInfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        local tween = TweenService:Create(cursor, tweenInfo, {
            Size = UDim2.new(0, 28, 0, 28),
            Rotation = -50
        })
        tween:Play()
        
        pcall(function()
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(
                cursorTipPos.X,
                cursorTipPos.Y,
                0,
                true,
                game,
                1
            )
        end)
        
        task.wait(0.001)
        
        pcall(function()
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(
                cursorTipPos.X,
                cursorTipPos.Y,
                0,
                false,
                game,
                1
            )
        end)
        
        local tween2 = TweenService:Create(cursor, tweenInfo, {
            Size = UDim2.new(0, 32, 0, 32),
            Rotation = -45
        })
        tween2:Play()
        
        clicking = false
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F6 then
        enabled = true
        statusLabel.Text = texts[language].status .. ": " .. texts[language].enabled
        statusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
    elseif input.KeyCode == Enum.KeyCode.F5 then
        enabled = false
        statusLabel.Text = texts[language].status .. ": " .. texts[language].disabled
        statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    elseif input.KeyCode == Enum.KeyCode.F4 then
        screenGui:Destroy()
        return
    end
end)

local isDraggingCursor = false
local dragStartPosition
local cursorStartPosition

cursor.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDraggingCursor = true
        dragStartPosition = Vector2.new(input.Position.X, input.Position.Y)
        cursorStartPosition = Vector2.new(cursor.Position.X.Offset, cursor.Position.Y.Offset)
        mainFrame.Draggable = false
        arrowMain.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDraggingCursor and input.UserInputType == Enum.UserInputType.MouseMovement then
        local currentMousePos = Vector2.new(input.Position.X, input.Position.Y)
        local delta = currentMousePos - dragStartPosition
        
        local newX = math.clamp(cursorStartPosition.X + delta.X, 0, screenGui.AbsoluteSize.X - cursor.AbsoluteSize.X)
        local newY = math.clamp(cursorStartPosition.Y + delta.Y, 0, screenGui.AbsoluteSize.Y - cursor.AbsoluteSize.Y)
        
        cursor.Position = UDim2.new(0, newX, 0, newY)
        mousePos = Vector2.new(newX + 16, newY + 16)
    end
end)

local function endDragging()
    if isDraggingCursor then
        isDraggingCursor = false
        mainFrame.Draggable = true
        arrowMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end
end

cursor.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endDragging()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endDragging()
    end
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

minimizeButton.MouseButton1Click:Connect(function()
    scriptVisible = not scriptVisible
    if scriptVisible then
        contentFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 250, 0, 220)
        minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 189, 46)
    else
        contentFrame.Visible = false
        mainFrame.Size = UDim2.new(0, 250, 0, 28)
        minimizeButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

maximizeButton.MouseButton1Click:Connect(function()
    if language == "ru" then
        language = "en"
    else
        language = "ru"
    end
    updateLanguage()
end)

local function setupButtonHover(button, originalColor)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = originalColor
    end)
    
    button.MouseLeave:Connect(function()
        if button == minimizeButton and not scriptVisible then
            button.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        else
            button.BackgroundColor3 = originalColor
        end
    end)
end

setupButtonHover(closeButton, Color3.fromRGB(255, 95, 87))
setupButtonHover(minimizeButton, scriptVisible and Color3.fromRGB(255, 189, 46) or Color3.fromRGB(150, 150, 150))
setupButtonHover(maximizeButton, Color3.fromRGB(40, 201, 65))

speedValue.FocusLost:Connect(function(enterPressed)
    local value = tonumber(speedValue.Text)
    if value then
        value = math.clamp(value, 1, 1000)
        speedValue.Text = tostring(value)
        clickInterval = value / 1000
        sliderFill.Size = UDim2.new(1 - (value / 1000), 0, 1, 0)
    else
        speedValue.Text = "20"
        clickInterval = 0.02
        sliderFill.Size = UDim2.new(0.98, 0, 1, 0)
    end
end)

local sliderDragging = false
local function updateSlider(input)
    local sliderAbsolutePos = speedSlider.AbsolutePosition.X
    local sliderAbsoluteSize = speedSlider.AbsoluteSize.X
    local mouseAbsolutePos = input.Position.X
    
    local relativePos = math.clamp(mouseAbsolutePos - sliderAbsolutePos, 0, sliderAbsoluteSize)
    local percentage = relativePos / sliderAbsoluteSize
    
    local value = math.floor(1000 - (percentage * 1000))
    value = math.clamp(value, 1, 1000)
    
    speedValue.Text = tostring(value)
    clickInterval = value / 1000
    sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
end

speedSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliderDragging = true
        updateSlider(input)
    end
end)

speedSlider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliderDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateSlider(input)
    end
end)

RunService.RenderStepped:Connect(function()
    updateRainbowHue()
    
    applyRainbowColor(titleLabel, false)
    applyRainbowColor(statusLabel, false)
    applyRainbowColor(speedLabel, false)
    applyRainbowColor(hotkeysLabel, false)
    applyRainbowColor(authorLabel, false)
    applyRainbowColor(cursor, true)
    
    if enabled and not isDraggingCursor then
        local currentTime = tick()
        
        if currentTime - lastClickTime >= clickInterval then
            task.spawn(function()
                performClick()
            end)
            lastClickTime = currentTime
        end
    end
end)

mousePos = Vector2.new(cursor.Position.X.Offset + 16, cursor.Position.Y.Offset + 16)

task.spawn(function()
    task.wait(0.5)
    
    for i = 1, 3 do
        arrowMain.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(0.15)
        arrowMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        task.wait(0.15)
    end
end)
