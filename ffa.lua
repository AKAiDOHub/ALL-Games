-- Carrega a biblioteca MacLib
local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()

-- Configurações iniciais
getgenv().ToggleUI = Enum.KeyCode.K -- Tecla para alternar a UI

-- Cria a janela principal
local Window = MacLib:Window({
    Title = "KALIU-CHEATS 🔥",
    Subtitle = "[FPS] Campo de Armas FFA",
    Size = UDim2.fromOffset(650, 420),
    DragStyle = 2,
    DisabledWindowControls = {},
    ShowUserInfo = true,
    Keybind = getgenv().ToggleUI, -- Usa a mesma tecla configurada
    AcrylicBlur = false,
})

-- Variável para armazenar o botão mobile
local mobileButton = nil

-- Função para criar o botão mobile
local function createMobileButton()
    -- Remove o botão existente se houver
    if mobileButton then
        mobileButton:Destroy()
    end
    
    -- Cria o botão mobile
    local OpenUI = Instance.new("ScreenGui")
    OpenUI.Name = "MobileToggleUI"
    OpenUI.Parent = game:GetService("CoreGui")
    OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local OpenBt = Instance.new("TextButton")
    OpenBt.Parent = OpenUI
    OpenBt.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    OpenBt.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenBt.BackgroundTransparency = 0
    OpenBt.Position = UDim2.new(0.9, 0, 0.1, 0)
    OpenBt.Size = UDim2.new(0, 70, 0, 70)
    OpenBt.Text = "Open"
    OpenBt.TextSize = 16
    OpenBt.Draggable = true
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = OpenBt
    
    -- Sistema melhorado de simulação de tecla
    local function simulateKeyPress()
        -- Pressiona a tecla
        game:GetService("VirtualInputManager"):SendKeyEvent(true, getgenv().ToggleUI, false, game)
        task.wait(0.05)
        -- Libera a tecla
        game:GetService("VirtualInputManager"):SendKeyEvent(false, getgenv().ToggleUI, false, game)
    end
    
    OpenBt.MouseButton1Click:Connect(simulateKeyPress)
    
    mobileButton = OpenUI
end


-- Configurações globais
local globalSettings = {
    UIBlurToggle = Window:GlobalSetting({
        Name = "UI Blur",
        Default = Window:GetAcrylicBlurState(),
        Callback = function(bool)
            Window:SetAcrylicBlurState(bool)
            Window:Notify({
                Title = Window.Settings.Title,
                Description = (bool and "Enabled" or "Disabled") .. " UI Blur",
                Lifetime = 5
            })
        end,
    }),
    NotificationToggler = Window:GlobalSetting({
        Name = "Notifications",
        Default = Window:GetNotificationsState(false),
        Callback = function(bool)
            Window:SetNotificationsState(bool)
            Window:Notify({
                Title = Window.Settings.Title,
                Description = (bool and "Enabled" or "Disabled") .. " Notifications",
                Lifetime = 5
            })
        end,
    }),
    ShowUserInfo = Window:GlobalSetting({
        Name = "Show User Info",
        Default = Window:GetUserInfoState(),
        Callback = function(bool)
            Window:SetUserInfoState(bool)
            Window:Notify({
                Title = Window.Settings.Title,
                Description = (bool and "Showing" or "Redacted") .. " User Info",
                Lifetime = 5
            })
        end,
    }),
    MobileButtonToggle = Window:GlobalSetting({
        Name = "Mobile Button",
        Default = true,
        Callback = function(bool)
            if bool then
                createMobileButton()
            else
                if mobileButton then
                    mobileButton:Destroy()
                end
            end
            Window:Notify({
                Title = Window.Settings.Title,
                Description = (bool and "Enabled" or "Disabled") .. " Mobile Button",
                Lifetime = 5
            })
        end,
    })
}

createMobileButton()

--//--------------• Variables •--------------\\--

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Cam = game.Workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local cache = {}
local bones = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "LowerTorso"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"}
}

--//--------------• Activation •--------------\\--

local Settings = {
    Aim = {
    --// ---• Aimbot •--- \\--
    
        Enabled = false,
        
    --// ---• Checks •--- \\--
    
        WallCheck = false,
        AliveCheck = false,
        TeamCheck = false,
        
    --// ----• Exotics •---- \\--

        AutoAdjustment = false,
        PlayersTrajectory = false,
        
    --// -----• Texts •----- \\--
    
        CamType = "LockCam", --// "TweenCam", or "LockCam" \\--
        
        LockPart = "Head", --// "Head", or "HumanoidRootPart" \\--
        
        Bind = "E", 
        
    --// ----• Number •---- \\--
        
        Sensitivity = 1, --// 0.1 up to 1 \\--
        Delay = 0, --// 0.1 up to 1 \\--
        MaxDistance = 400,
        
        IgnorePlayer = {
            "Slafuibanidomsm", 
            "player001",
        },
    }, 
    
    Fov = {
        Enabled = false,
        Filled = false,
    
        Transparency = 0.7,
        MaxTransparency = 0.1,
        Thickness = 2,
        Radius = 190,
        
        Color = Color3.fromRGB(128, 0, 0),
        
        Position = Cam.ViewportSize / 2,
    },
    
    Visual = {
        Enabled = false,
        
        TeamColors = false,
        WallColors = false,
        
        TeamCheck = false,
        
        Tracers = false,
        Box = false,
        Health = false,
        Skeleton = false,
        Name = false,
    },
    
    Config = {
        
        TracersPositions = "Top", -- Top, Bottom, Left, Right ou Center
        
        
        BoxStyle = "Corner", -- Corner ou 2d
        
        
        HealthBarPosition = "Left", -- Left ou Right
        
        
        NamePosition = "Top",
        
        TracersSize = 1,
        TransparencyTracers = 0.9
    },
    
    Colors = {
        WallColors = {
            Visible = Color3.fromRGB(0, 255, 0), -- Verde para visível d
            Invis = Color3.fromRGB(255, 0, 0) -- Vermelho para invisível
        },
        
        HealthColors = {
            HealthOutline = Color3.fromRGB(0, 0, 0),
            HealthHigh = Color3.fromRGB(0, 255, 0),
            HealthLow = Color3.fromRGB(128, 25, 25),
        },
        
        Tracers = Color3.fromRGB(255, 0, 0),
        Box = Color3.fromRGB(255, 0, 0),
        BoxOutline = Color3.fromRGB(0, 0, 0),
        Skeleton = Color3.fromRGB(255, 0, 0),
        Name = Color3.fromRGB(255, 0, 0)
    }
}

--//--------------• ScreenGui •--------------\\--

local Fov = Drawing.new("Circle")
local function initializeDrawings()
    Fov.Visible = Settings.Fov.Enabled
    Fov.Filled = Settings.Fov.Filled
    Fov.Transparency = Settings.Fov.Transparency
    Fov.Thickness = Settings.Fov.Thickness
    Fov.Radius = Settings.Fov.Radius
    Fov.Color = Settings.Fov.Color
    Fov.Position = Settings.Fov.Position
end

initializeDrawings()

--//---------------• Updates •---------------\\--

local function updateDrawings()
    Fov.Position = Cam.ViewportSize / 2
end

--//------------• System Checks •------------\\--

function isPlayerVisible(player)
    if not Settings.Aim.WallCheck then
        return true
    end

    if player.Character and player.Character:FindFirstChild(Settings.Aim.LockPart) then
        local startPos = Cam.CFrame.p
        local endPos = player.Character[Settings.Aim.LockPart].Position
        local direction = (endPos - startPos).unit * (endPos - startPos).magnitude
        local ray = Ray.new(startPos, direction)
        local ignoreList = {game.Players.LocalPlayer.Character}

        local hitPart, hitPos = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
        
        return hitPart == nil or hitPart:IsDescendantOf(player.Character)
    end
    
    return false
end

function isPlayerAlive(player)
    return player.Character and player.Character:FindFirstChildOfClass("Humanoid") and player.Character.Humanoid.Health > 0
end

local function isWithinMaxDistance(player)
    if player.Character and player.Character:FindFirstChild(Settings.Aim.LockPart) then
        local lockPart = player.Character[Settings.Aim.LockPart]
        local distance = (Cam.CFrame.p - lockPart.Position).Magnitude
        return distance <= Settings.Aim.MaxDistance
    end
    return false
end

--//------------• Players Forecast •------------\\--

local function predictPlayerPosition(player, delay)
    local character = player.Character
    if character and character:FindFirstChild(Settings.Aim.LockPart) then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local lockPart = character[Settings.Aim.LockPart]

        if humanoid and lockPart then
            local velocity = humanoid.RootPart.Velocity
            return lockPart.Position + (velocity * delay)
        end
    end
    return nil
end

local function adjustSensitivityAndDelay(distance)
    if Settings.Aim.AutoAdjustment then
        -- Ajusta a sensibilidade com base na distância
        Settings.Aim.Sensitivity = math.clamp(1 - (distance / Settings.Aim.MaxDistance), 0.1, 1)
        -- Ajusta o delay com base na distância
        Settings.Aim.Delay = math.clamp(distance / 1000, 0, 1)
    end
end

--//--------------• Functions •--------------\\--

local function lookAt(target)
    if not target then return end
    
    local lookVector = (target - Cam.CFrame.Position).unit
    local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
    local sensitivityAdjustment = Settings.Aim.Sensitivity

    if Settings.Aim.CamType == "TweenCam" then
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out) 
        local tween = TweenService:Create(Cam, tweenInfo, {CFrame = newCFrame})
        tween:Play()
    elseif Settings.Aim.CamType == "LockCam" then
        Cam.CFrame = Cam.CFrame:Lerp(newCFrame, sensitivityAdjustment) 
    end
end

local function getClosestPlayerInFOV(trg_part)
    local nearest = nil
    local last = math.huge
    local playerMousePos = Cam.ViewportSize / 2

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and not table.find(Settings.Aim.IgnorePlayer, player.Name) then
            if isWithinMaxDistance(player) and isPlayerAlive(player) then
                local part = player.Character and player.Character:FindFirstChild(trg_part)
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                
                if part and humanoid then
                    local ePos, isVisible = Cam:WorldToViewportPoint(part.Position)
                    local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude

                    if isVisible and distance < Settings.Fov.Radius then
                        local shouldCheckTeam = not Settings.Aim.TeamCheck or player.Team ~= LocalPlayer.Team
                        local shouldCheckAlive = not Settings.Aim.AliveCheck or humanoid.Health > 0
                        
                        if shouldCheckTeam and shouldCheckAlive and isPlayerVisible(player) then
                            if distance < last then
                                last = distance
                                nearest = player
                            end
                        end
                    end
                end
            end
        end
    end

    return nearest
end

RunService.RenderStepped:Connect(function()
    updateDrawings()
    
    local closest = getClosestPlayerInFOV(Settings.Aim.LockPart)
   
    if Settings.Aim.Enabled and closest and closest.Character then
        local lockPart = closest.Character:FindFirstChild(Settings.Aim.LockPart)
        if lockPart then
            local targetPosition
            if Settings.Aim.PlayersTrajectory then
                targetPosition = predictPlayerPosition(closest, Settings.Aim.Delay) or lockPart.Position
                if Settings.Aim.AutoAdjustment then
                    local distance = (Cam.CFrame.Position - lockPart.Position).Magnitude
                    adjustSensitivityAndDelay(distance)
                end
            else
                targetPosition = lockPart.Position
            end
            lookAt(targetPosition)
        end
    end
end)

-- Input binding
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode[Settings.Aim.Bind] then
            Settings.Aim.Enabled = not Settings.Aim.Enabled
        end
    end
end)

-- ESP

local function create(class, properties)
    local drawing = Drawing.new(class)
    for property, value in pairs(properties) do
        drawing[property] = value
    end
    return drawing
end

local function createEsp(player)
    local esp = {
        boxOutline = create("Square", {
            Color = Settings.Colors.BoxOutline,
            Thickness = 3,
            Filled = false
        }),
        box = create("Square", {
            Color = Settings.Colors.Box,
            Thickness = 1,
            Filled = false
        }),
        name = create("Text", {
            Color = Settings.Colors.Name,
            Outline = true,
            Center = true,
            Size = 13
        }),
        healthOutline = create("Line", {
            Thickness = 3,
            Color = Settings.Colors.HealthColors.HealthOutline
        }),
        health = create("Line", {
            Thickness = 1
        }),
        line = create("Line", {
            Thickness = 1,
            Color = Settings.Colors.Tracers
        }),
        boxLines = {},
        skeletonLines = {}
    }
    cache[player] = esp
end

local function removeEsp(player)
    local esp = cache[player]
    if not esp then return end
    for _, drawing in pairs(esp) do
        if type(drawing) == "table" then
            for _, line in pairs(drawing) do
                line:Remove()
            end
        else
            drawing:Remove()
        end
    end
    cache[player] = nil
end

local function isPlayerVisible(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local startPos = camera.CFrame.p
        local endPos = player.Character.HumanoidRootPart.Position
        local ray = Ray.new(startPos, (endPos - startPos).Unit * (endPos - startPos).Magnitude)
        local hit = workspace:FindPartOnRayWithIgnoreList(ray, {localPlayer.Character})
        return hit == nil or hit:IsDescendantOf(player.Character)
    end
    return false
end

local function updateEsp()
    for player, esp in pairs(cache) do
        local character, team = player.Character, player.Team
        if character and (not Settings.Visual.TeamCheck or (team and team ~= localPlayer.Team)) then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            local head = character:FindFirstChild("Head")
            local humanoid = character:FindFirstChild("Humanoid")
            local isVisible = isPlayerVisible(player)
            local shouldShow = Settings.Visual.Enabled
            if rootPart and head and humanoid and shouldShow then
                local position, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local hrp2D = camera:WorldToViewportPoint(rootPart.Position)
                    local charSize = (camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0)).Y - camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 2.6, 0)).Y) / 2
                    local boxSize = Vector2.new(math.floor(charSize * 1.8), math.floor(charSize * 1.9))
                    local boxPosition = Vector2.new(math.floor(hrp2D.X - charSize * 1.8 / 2), math.floor(hrp2D.Y - charSize * 1.6 / 2))
                    
                    local nameOffset = (Settings.Config.NamePosition == "Top") and -16 or boxSize.Y + 16

                    -- Determine color based on visibility if WallColors is enabled
                    local currentColor = Settings.Colors.Box
                    if Settings.Visual.WallColors then
                        currentColor = isVisible and Settings.Colors.WallColors.Visible or Settings.Colors.WallColors.Invis
                    end

                    -- ESP Name Position Logic
                    if Settings.Visual.Name and Settings.Visual.Enabled then
                        esp.name.Visible = true
                        esp.name.Text = string.lower(player.Name)
                        esp.name.Position = Vector2.new(boxSize.X / 2 + boxPosition.X, boxPosition.Y + nameOffset)
                        esp.name.Color = Settings.Visual.WallColors and (isVisible and Settings.Colors.WallColors.Visible or Settings.Colors.WallColors.Invis) or Settings.Colors.Name
                    else
                        esp.name.Visible = false
                    end
                    
                    if Settings.Visual.Box and Settings.Visual.Enabled then
                        if Settings.Config.BoxStyle == "2D" then
                            esp.boxOutline.Size = boxSize
                            esp.boxOutline.Position = boxPosition
                            esp.box.Size = boxSize
                            esp.box.Position = boxPosition
                            esp.box.Color = currentColor
                            esp.box.Visible = true
                            esp.boxOutline.Visible = true
                            for _, line in ipairs(esp.boxLines) do
                                line.Visible = false
                            end
                        elseif Settings.Config.BoxStyle == "Corner" then
                            -- Corner box implementation
                            local lineW = (boxSize.X / 5)
                            local lineH = (boxSize.Y / 6)
                            local lineT = 1
                            if #esp.boxLines == 0 then
                                for i = 1, 8 do
                                    local boxLine = create("Line", { Thickness = 1, Color = currentColor, Transparency = 1 })
                                    esp.boxLines[#esp.boxLines + 1] = boxLine
                                end
                            end
                            local boxLines = esp.boxLines
                            -- top left
                            boxLines[1].From = Vector2.new(boxPosition.X - lineT, boxPosition.Y - lineT)
                            boxLines[1].To = Vector2.new(boxPosition.X + lineW, boxPosition.Y - lineT)
                            boxLines[2].From = Vector2.new(boxPosition.X - lineT, boxPosition.Y - lineT)
                            boxLines[2].To = Vector2.new(boxPosition.X - lineT, boxPosition.Y + lineH)
                            -- top right
                            boxLines[3].From = Vector2.new(boxPosition.X + boxSize.X - lineW, boxPosition.Y - lineT)
                            boxLines[3].To = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y - lineT)
                            boxLines[4].From = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y - lineT)
                            boxLines[4].To = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y + lineH)
                            -- bottom left
                            boxLines[5].From = Vector2.new(boxPosition.X - lineT, boxPosition.Y + boxSize.Y - lineH)
                            boxLines[5].To = Vector2.new(boxPosition.X - lineT, boxPosition.Y + boxSize.Y + lineT)
                            boxLines[6].From = Vector2.new(boxPosition.X - lineT, boxPosition.Y + boxSize.Y + lineT)
                            boxLines[6].To = Vector2.new(boxPosition.X + lineW, boxPosition.Y + boxSize.Y + lineT)
                            -- bottom right
                            boxLines[7].From = Vector2.new(boxPosition.X + boxSize.X - lineW, boxPosition.Y + boxSize.Y + lineT)
                            boxLines[7].To = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y + boxSize.Y + lineT)
                            boxLines[8].From = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y + boxSize.Y - lineH)
                            boxLines[8].To = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y + boxSize.Y + lineT)
                            for _, line in ipairs(boxLines) do
                                line.Color = currentColor
                                line.Visible = true
                            end
                            esp.box.Visible = false
                            esp.boxOutline.Visible = false
                        end
                    else
                        esp.box.Visible = false
                        esp.boxOutline.Visible = false
                        for _, line in ipairs(esp.boxLines) do
                            line.Visible = false
                        end
                    end
                    
                    if Settings.Visual.Health and Settings.Visual.Enabled then
                        esp.healthOutline.Visible = true
                        esp.health.Visible = true
                        local healthPercentage = humanoid.Health / humanoid.MaxHealth
                        local from, to

                        if Settings.Config.HealthBarPosition == "Left" then
                            from = Vector2.new(boxPosition.X - 6, boxPosition.Y + boxSize.Y)
                            to = Vector2.new(from.X, from.Y - boxSize.Y)
                            esp.healthOutline.From = from
                            esp.healthOutline.To = to
                            esp.health.From = Vector2.new((boxPosition.X - 5), boxPosition.Y + boxSize.Y)
                            esp.health.To = Vector2.new(esp.health.From.X, esp.health.From.Y - healthPercentage * boxSize.Y)
                        elseif Settings.Config.HealthBarPosition == "Right" then
                            from = Vector2.new(boxPosition.X + boxSize.X + 6, boxPosition.Y + boxSize.Y)
                            to = Vector2.new(from.X, from.Y - boxSize.Y)
                            esp.healthOutline.From = from
                            esp.healthOutline.To = to
                            esp.health.From = Vector2.new((boxPosition.X + boxSize.X + 5), boxPosition.Y + boxSize.Y)
                            esp.health.To = Vector2.new(esp.health.From.X, esp.health.From.Y - healthPercentage * boxSize.Y)
                        end

                        esp.health.Color = Settings.Colors.HealthColors.HealthLow:Lerp(Settings.Colors.HealthColors.HealthHigh, healthPercentage)
                    else
                        esp.healthOutline.Visible = false
                        esp.health.Visible = false
                    end
                    
                    if Settings.Visual.Skeleton and Settings.Visual.Enabled then
                        if #esp.skeletonLines == 0 then
                            for _, bonePair in ipairs(bones) do
                                local parentBone, childBone = bonePair[1], bonePair[2]
                                if character:FindFirstChild(parentBone) and character:FindFirstChild(childBone) then
                                    local skeletonLine = create("Line", { Thickness = 1, Color = currentColor, Transparency = 1 })
                                    table.insert(esp.skeletonLines, {skeletonLine, parentBone, childBone})
                                end
                            end
                        end
                        for _, lineData in ipairs(esp.skeletonLines) do
                            local skeletonLine = lineData[1]
                            local parentBone, childBone = lineData[2], lineData[3]
                            if character:FindFirstChild(parentBone) and character:FindFirstChild(childBone) then
                                local parentPosition = camera:WorldToViewportPoint(character[parentBone].Position)
                                local childPosition = camera:WorldToViewportPoint(character[childBone].Position)
                                skeletonLine.From = Vector2.new(parentPosition.X, parentPosition.Y)
                                skeletonLine.To = Vector2.new(childPosition.X, childPosition.Y)
                                skeletonLine.Color = currentColor
                                skeletonLine.Visible = true
                            else
                                skeletonLine.Visible = false
                            end
                        end
                    else
                        for _, lineData in ipairs(esp.skeletonLines) do
                            lineData[1].Visible = false
                        end
                    end

                    if Settings.Visual.Tracers and Settings.Visual.Enabled then
                        esp.line.Visible = true
                        local lineFrom

                        if Settings.Config.TracersPositions == "Left" then
                            lineFrom = Vector2.new(0, camera.ViewportSize.Y / 2)
                        elseif Settings.Config.TracersPositions == "Right" then
                            lineFrom = Vector2.new(camera.ViewportSize.X, camera.ViewportSize.Y / 2)
                        elseif Settings.Config.TracersPositions == "Top" then
                            lineFrom = Vector2.new(camera.ViewportSize.X / 2, 0)
                        elseif Settings.Config.TracersPositions == "Bottom" then
                            lineFrom = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                        elseif Settings.Config.TracersPositions == "Center" then
                            lineFrom = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                        end

                        esp.line.From = lineFrom
                        esp.line.To = Vector2.new(hrp2D.X, hrp2D.Y)
                        esp.line.Color = currentColor
                    else
                        esp.line.Visible = false
                    end
                else
                    esp.box.Visible = false
                    esp.boxOutline.Visible = false
                    esp.name.Visible = false
                    esp.healthOutline.Visible = false
                    esp.health.Visible = false
                    esp.line.Visible = false
                    for _, line in ipairs(esp.boxLines) do
                        line.Visible = false
                    end
                    for _, lineData in ipairs(esp.skeletonLines) do
                        lineData[1].Visible = false
                    end
                end
            else
                esp.box.Visible = false
                esp.boxOutline.Visible = false
                esp.name.Visible = false
                esp.healthOutline.Visible = false
                esp.health.Visible = false
                esp.line.Visible = false
                for _, line in ipairs(esp.boxLines) do
                    line.Visible = false
                end
                for _, lineData in ipairs(esp.skeletonLines) do
                    lineData[1].Visible = false
                end
            end
        else
            esp.box.Visible = false
            esp.boxOutline.Visible = false
            esp.name.Visible = false
            esp.healthOutline.Visible = false
            esp.health.Visible = false
            esp.line.Visible = false
            for _, line in ipairs(esp.boxLines) do
                line.Visible = false
            end
            for _, lineData in ipairs(esp.skeletonLines) do
                lineData[1].Visible = false
            end
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        createEsp(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= localPlayer then
        createEsp(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeEsp(player)
end)

RunService.RenderStepped:Connect(updateEsp)

local tabGroups = {
    MG = Window:TabGroup(),
    GGroup = Window:TabGroup(),
}

local tabs = {
    Main = tabGroups.MG:Tab({ 
	    Name = "Credits", 
	    Image = "rbxassetid://18821914323" 
	}),

	G = tabGroups.GGroup:Tab({ 
	    Name = "General", 
	    Image = "rbxassetid://18821914323" 
	}),
	V = tabGroups.GGroup:Tab({ 
	    Name = "Visuais", 
	    Image = "rbxassetid://18821914323" 
	}),
	H = tabGroups.GGroup:Tab({ 
	    Name = "Hitbox", 
	    Image = "rbxassetid://18821914323" 
	}),
	M = tabGroups.GGroup:Tab({ 
	    Name = "Misc", 
	    Image = "rbxassetid://18821914323" 
	}),
}

local sections = {
    MM1 = tabs.Main:Section({ Side = "Left" }),
	MM2 = tabs.Main:Section({ Side = "Right" }),

    G1 = tabs.G:Section({ Side = "Left" }),
	G2 = tabs.G:Section({ Side = "Right" }),
	
	V1 = tabs.V:Section({ Side = "Left" }),
	V2 = tabs.V:Section({ Side = "Right" }),
	
	V3 = tabs.V:Section({ Side = "Right" }),
	
	G3 = tabs.G:Section({ Side = "Left" }),
	G4 = tabs.G:Section({ Side = "Right" }),
	
	H1 = tabs.H:Section({ Side = "Left" }),
	H2 = tabs.H:Section({ Side = "Right" }),
	
	M1 = tabs.M:Section({ Side = "Left" }),
}

sections.MM1:Paragraph({
	Header = "Credits",
	Body = " Give credit to the official creator of the script!!\n •KALIU-CHEATS\n Follow on social media↓\n• Instagram: Kaliu_041\n• Youtube: KALIU-TEAM\nTo open the menu follow me on social media 🔥🔥."
})

sections.MM2:Paragraph({
	Header = "Créditos",
	Body = " Dê crédito ao criador oficial do script!!\n •KALIU-CHEATS\n Siga nas redes sociais↓\n• Instagram: Kaliu_041\n• Youtube: KALIU-TEAM\nPara abrir o menu, siga-me nas redes sociais 🔥🔥."
})

sections.G1:Toggle({ "Aimbot",
	Name = "Aimbot",
	Default = false,
	Callback = function(Value)
		Settings.Aim.Enabled = Value
	end,
})

sections.G1:Divider()

sections.G1:Toggle({ "Wall",
	Name = "Wall Check",
	Default = false,
	Callback = function(Value)
		Settings.Aim.WallCheck = Value
	end,
})

sections.G1:Toggle({ "Alive",
	Name = "Alive Check",
	Default = false,
	Callback = function(Value)
		Settings.Aim.AliveCheck = Value
	end,
})

local PartHit = {
    ["Arm"] = "LeftArm",
    ["Torso"] = "HumanoidRootPart",
    ["Head"] = "Head",
}

local optionTable = {}
for key, _ in pairs(PartHit) do
    table.insert(optionTable, key)
end

local Dropdown = sections.G2:Dropdown({
    Name = "Target",
    Multi = false,
    Required = true,
    Options = optionTable,  -- Mostra apenas: Head, Torso, Arms, Legs
    Default = 3,  -- Seleciona a primeira opção por padrão
    Callback = function(Value)
        local SelectedValue = PartHit[Value]  -- Pega o valor correspondente
        Settings.Aim.hitPart = SelectedValue
    end
})

local AimMode = {
    ["Robot"] = "LockCam",
    ["Human"] = "TweenCam",
}

local opt = {}
for keyk, _ in pairs(AimMode) do
    table.insert(opt, keyk)
end

local Dropdown = sections.G2:Dropdown({
    Name = "Aimbot Mode",
    Multi = false,
    Required = true,
    Options = opt,  -- Mostra apenas: Head, Torso, Arms, Legs
    Default = 1,  -- Seleciona a primeira opção por padrão
    Callback = function(Value)
        local SV = AimMode[Value]  -- Pega o valor correspondente
        Settings.Aim.CamType = SV
    end
})

sections.G2:Slider({
	Name = "Sensitivity",
	Default = 50,
	Minimum = 0,
	Maximum = 100,
	DisplayMethod = "Value",
	Precision = 0,
	Callback = function(Value)
		Settings.Aim.Sensitivity = Value / 100
	end
}, "Slider")

sections.G3:Toggle({ "Fov",
	Name = "Fov",
	Default = false,
	Callback = function(Value)
		Fov.Visible = Value
	end,
})

sections.G3:Toggle({ "Filled",
	Name = "Filled",
	Default = false,
	Callback = function(Value)
		Fov.Filled = Value
	end,
})


local alphaColorPicker = sections.G4:Colorpicker({
	Name = "Color",
	Default = Color3.fromRGB(255,0,0),
	Alpha = 0,
	Callback = function(color, alpha)
		Fov.Color = color
	end,
}, "Color")

local rainbowActive
local rainbowConnection
local hue = 0

sections.G4:Toggle({
	Name = "Rainbow",
	Default = false,
	Callback = function(value)
		rainbowActive = value

		if rainbowActive then
			rainbowConnection = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
				hue = (hue + deltaTime * 0.1) % 1
				alphaColorPicker:SetColor(Color3.fromHSV(hue, 1, 1))
				Fov.Color = Color3.fromHSV(hue, 1, 1)
			end)
		elseif rainbowConnection then
			rainbowConnection:Disconnect()
			rainbowConnection = nil
		end
	end,
}, "RainbowToggle")

sections.G4:Slider({
	Name = "Size",
	Default = 70,
	Minimum = 10,
	Maximum = 360,
	DisplayMethod = "Value",
	Precision = 0,
	Callback = function(Value)
		Fov.Radius = Value
	end
}, "Slider")

-- ESP TAB V

sections.V1:Toggle({ "EspL",
	Name = "Enabled",
	Default = false,
	Callback = function(Value)
		Settings.Visual.Enabled = Value
	end,
})

sections.V1:Toggle({ "EspL",
	Name = "Wall Colors",
	Default = false,
	Callback = function(Value)
		Settings.Visual.WallColors = Value
	end,
})

sections.V1:Divider()

sections.V1:Toggle({ "EspL",
	Name = "Tracers",
	Default = false,
	Callback = function(Value)
		Settings.Visual.Tracers = Value
	end,
})

sections.V1:Toggle({ "EspL",
	Name = "Box",
	Default = false,
	Callback = function(Value)
		Settings.Visual.Box = Value
	end,
})

sections.V1:Toggle({ "EspL",
	Name = "Skeleton",
	Default = false,
	Callback = function(Value)
		Settings.Visual.Skeleton = Value
	end,
})

sections.V1:Toggle({ "EspL",
	Name = "Health",
	Default = false,
	Callback = function(Value)
		Settings.Visual.Health = Value
	end,
})

sections.V1:Toggle({ "EspL",
	Name = "Name",
	Default = false,
	Callback = function(Value)
		Settings.Visual.Name = Value
	end,
})

local Dropdown = sections.V2:Dropdown({
	Name = "Box Type",
	Multi = false,
	Required = true,
	Options = {
	    "Corner",
        "2D"
	},
	Default = 1,
	Callback = function(Value)
		Settings.Config.BoxStyle = Value
	end,
}, "Dropdown")

sections.V2:Divider()


local Dropdown = sections.V2:Dropdown({
	Name = "Tracers",
	Multi = false,
	Required = true,
	Options = {
	    "Top",
        "Bottom",
        "Center",
        "Left",
        "Right"
	},
	Default = 1,
	Callback = function(Value)
		Settings.Config.TracersPositions = Value
	end,
}, "Dropdown")

local Dropdown = sections.V2:Dropdown({
	Name = "Health",
	Multi = false,
	Required = true,
	Options = {
        "Left",
        "Right"
	},
	Default = 1,
	Callback = function(Value)
		Settings.Config.HealthBarPosition = Value
	end,
}, "Dropdown")

sections.V3:Colorpicker({
	Name = "In Wall",
	Default = Color3.fromRGB(255,0,0),
	Alpha = 0,
	Callback = function(color, alpha)
		Settings.Colors.WallColors.Invis = color
	end,
}, "HitC")

sections.V3:Colorpicker({
	Name = "No Wall",
	Default = Color3.fromRGB(0,255,0),
	Alpha = 0,
	Callback = function(color, alpha)
		Settings.Colors.WallColors.Visible = color
	end,
}, "HitC")

sections.V3:Divider()

local TC = sections.V3:Colorpicker({
	Name = "Tracers",
	Default = Color3.fromRGB(255,0,0),
	Alpha = 0,
	Callback = function(color, alpha)
		Settings.Colors.Tracers = color
	end,
}, "HitC")

local BC = sections.V3:Colorpicker({
	Name = "Box",
	Default = Color3.fromRGB(255,0,0),
	Alpha = 0,
	Callback = function(color, alpha)
		Settings.Colors.Box = color
	end,
}, "HitC")

local SC = sections.V3:Colorpicker({
	Name = "Skeleton",
	Default = Color3.fromRGB(255,0,0),
	Alpha = 0,
	Callback = function(color, alpha)
		Settings.Colors.Skeleton = color
	end,
}, "HitC")

local NC = sections.V3:Colorpicker({
	Name = "Name",
	Default = Color3.fromRGB(255,0,0),
	Alpha = 0,
	Callback = function(color, alpha)
		Settings.Colors.Name = color
	end,
}, "HitC")

sections.V3:Toggle({
	Name = "Rainbow Area",
	Default = false,
	Callback = function(value)
		rainbowActive = value

		if rainbowActive then
			rainbowConnection = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
				hue = (hue + deltaTime * 0.1) % 1
				local EspC = Color3.fromHSV(hue, 1, 1)
				
				TC:SetColor(EspC)
				BC:SetColor(EspC)
				SC:SetColor(EspC)
				NC:SetColor(EspC)
				
				Settings.Colors.Tracers = EspC
				Settings.Colors.Box = EspC
				Settings.Colors.Skeleton = EspC
				Settings.Colors.Name = EspC
				
			end)
		elseif rainbowConnection then
			rainbowConnection:Disconnect()
			rainbowConnection = nil
		end
	end,
}, "RainbowToggle")

-- TAB H HITBOX
-- -- -- -- -- -- -- HITBOX -- -- -- -- -- -- --

local HitBox = {
    Enabled = false,
    TeamCheck = false,
    
    Color = Color3.fromRGB(128, 25, 25),
    
    Size = 15,
    Transparency = 1,
    
    Target = "HumanoidRootPart" 
}

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
local Teams = game:GetService('Teams')

local function isEnemy(player)
    if not HitBox.TeamCheck or not Teams:GetTeams() then
        return true -- Se HitboxTeam não estiver ativo, todos são considerados inimigos
    end

    -- Verifica se o jogador pertence a uma equipe diferente
    return player.Team ~= LocalPlayer.Team
end

local function updateHitbox(player, size, transparency, color, material, canCollide)
    pcall(function()
        if player.Character and player.Character:FindFirstChild(HitBox.Target) then
            local part = player.Character[HitBox.Target]
            part.Size = size
            part.Transparency = transparency
            part.BrickColor = BrickColor.new(color)
            part.Material = material
            part.CanCollide = canCollide
        end
    end)
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        -- Aguarda até que o personagem tenha a parte da hitbox
        character:WaitForChild(HitBox.Target)
        -- Atualiza a hitbox quando o personagem é adicionado
        if player ~= LocalPlayer and HitBox.Enabled and isEnemy(player) then
            updateHitbox(player, Vector3.new(HitBox.Size, HitBox.Size, HitBox.Size), HitBox.Transparency, HitBox.Color, "Neon", false)
        else
            updateHitbox(player, Vector3.new(2, 2, 2), 1, HitBox.Color, "Plastic", true)
        end
    end)
end

local function Hitbox()
    game:GetService('RunService').RenderStepped:Connect(function()
        for _, player in next, Players:GetPlayers() do
            if player ~= LocalPlayer and player.Character then
                if HitBox.Enabled and isEnemy(player) then
                    -- Modifica a hitbox apenas para jogadores adversários
                    updateHitbox(player, Vector3.new(HitBox.Size, HitBox.Size, HitBox.Size), HitBox.Transparency, HitBox.Color, "Neon", false)
                else
                    -- Modifica a hitbox para todos quando o Aimbot está desativado
                    updateHitbox(player, Vector3.new(2, 2, 2), 1, HitBox.Color, "Plastic", true)
                end
            end
        end
    end)
end

-- Conectar a função onPlayerAdded para jogadores que entram
Players.PlayerAdded:Connect(onPlayerAdded)

-- Conectar os jogadores que já estão no jogo
for _, player in next, Players:GetPlayers() do
    onPlayerAdded(player)
end

Hitbox()

sections.H1:Toggle({ "Hitbox",
	Name = "Magic Hit",
	Default = false,
	Callback = function(Value)
		HitBox.Enabled = Value
	end,
})

sections.H1:Toggle({ "Hitbox",
	Name = "Area Hit",
	Default = false,
	Callback = function(Value)
	    if Value == true then
		    HitBox.Transparency = 0.8
		else
		    HitBox.Transparency = 1
		end
	end,
})

local HitC = sections.H2:Colorpicker({
	Name = "Area Color",
	Default = Color3.fromRGB(255,0,0),
	Alpha = 0,
	Callback = function(color, alpha)
		HitBox.Color = color
	end,
}, "HitC")

local rainbowActive
local rainbowConnection
local hue = 0

sections.H2:Toggle({
	Name = "Rainbow Area",
	Default = false,
	Callback = function(value)
		rainbowActive = value

		if rainbowActive then
			rainbowConnection = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
				hue = (hue + deltaTime * 0.1) % 1
				HitC:SetColor(Color3.fromHSV(hue, 1, 1))
				HitBox.Color = Color3.fromHSV(hue, 1, 1)
			end)
		elseif rainbowConnection then
			rainbowConnection:Disconnect()
			rainbowConnection = nil
		end
	end,
}, "RainbowToggle")

sections.H2:Slider({
	Name = "Size",
	Default = 15,
	Minimum = 5,
	Maximum = 150,
	DisplayMethod = "Value",
	Precision = 0,
	Callback = function(Value)
		HitBox.Size = Value
	end
}, "Slider")

-- TAB MISC M 

sections.M1:Button({
	Name = "Replace Gun",
	Callback = function()
		Window:Dialog({
			Title = Window.Settings.Title,
			Description = "Are you sure you want to change weapons?",
			Buttons = {
				{
					Name = "Confirm",
					Callback = function()
						
					end,
				},
				{
					Name = "Cancel"
				}
			}
		})
	end,
})

sections.M1:Divider()

local Speed = 16
local Jumo = 50
local ToggleSpeed = false
local ToggleJump = false

function Velocity()
    if ToggleSpeed == true then
        while ToggleSpeed == true do
            wait()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed
        end
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end

function Jumping()
    if ToggleJump == true then
        while ToggleJump == true do
            wait()
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump
        end
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end

sections.M1:Toggle({ "Speed",
	Name = "Enable Speed",
	Default = false,
	Callback = function(Value)
	    ToggleSpeed = Value
	    Velocity()
	end,
})

sections.M1:Toggle({ "Jump",
	Name = "Enable Jump",
	Default = false,
	Callback = function(Value)
	    ToggleJump = Value
	    Jumping()
	end,
})

sections.M1:Slider({
	Name = "Speed",
	Default = 16,
	Minimum = 16,
	Maximum = 360,
	DisplayMethod = "Value",
	Precision = 0,
	Callback = function(Value)
		Speed = Value
	end
}, "Speed")

sections.M1:Slider({
	Name = "Junp",
	Default = 50,
	Minimum = 16,
	Maximum = 360,
	DisplayMethod = "Value",
	Precision = 0,
	Callback = function(Value)
		Jump = Value
	end
}, "Speed")

tabs.G:Select()
