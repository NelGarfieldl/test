print("Hello, world!") 
local TDS = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- События, которые будут использоваться для взаимодействия с сервером
TDS.Events = {
    PlaceTower = ReplicatedStorage:WaitForChild("PlaceTower"),
    UpgradeTower = ReplicatedStorage:WaitForChild("UpgradeTower"),
    SellTower = ReplicatedStorage:WaitForChild("SellTower"),
    SkipWave = ReplicatedStorage:WaitForChild("SkipWave"),
    SelectMap = ReplicatedStorage:WaitForChild("SelectMap"),
    Loadout = ReplicatedStorage:WaitForChild("SelectLoadout")
}

-- Создаем интерфейс для отображения логов
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Size = UDim2.new(0, 400, 0, 300)
ConsoleFrame.Position = UDim2.new(0, 50, 0, 50)
ConsoleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ConsoleFrame.Parent = ScreenGui

local ConsoleTextBox = Instance.new("TextBox")
ConsoleTextBox.Size = UDim2.new(1, -10, 1, -10)
ConsoleTextBox.Position = UDim2.new(0, 5, 0, 5)
ConsoleTextBox.BackgroundTransparency = 1
ConsoleTextBox.TextXAlignment = Enum.TextXAlignment.Left
ConsoleTextBox.TextYAlignment = Enum.TextYAlignment.Top
ConsoleTextBox.TextSize = 14
ConsoleTextBox.TextWrapped = true
ConsoleTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ConsoleTextBox.Text = "Console Log:\n"
ConsoleTextBox.Parent = ConsoleFrame

-- Функция для логирования сообщений
local function Log(msg)
    print("[TDS] " .. msg)
    if ConsoleTextBox then
        ConsoleTextBox.Text = ConsoleTextBox.Text .. msg .. "\n"
    end
end

-- Функция для выбора карты
function TDS:Map(mapName, isHardcore, mode)
    if self.Events.SelectMap then
        Log("Selecting map: " .. mapName .. " | Hardcore: " .. tostring(isHardcore) .. " | Mode: " .. mode)
        self.Events.SelectMap:FireServer(mapName, isHardcore, mode)
    end
end

-- Функция для загрузки комплекта башен
function TDS:Loadout(towers)
    if self.Events.Loadout then
        Log("Loading towers: " .. table.concat(towers, ", "))
        self.Events.Loadout:FireServer(towers)
    end
end

-- Функция для размещения башни
function TDS:Place(towerName, x, y, z)
    if self.Events.PlaceTower then
        Log("Placing tower: " .. towerName .. " at X: " .. x .. ", Y: " .. y .. ", Z: " .. z)
        self.Events.PlaceTower:FireServer(towerName, Vector3.new(x, y, z))
    end
end

-- Функция для улучшения башни
function TDS:Upgrade(towerId)
    if self.Events.UpgradeTower then
        Log("Upgrading tower ID: " .. towerId)
        self.Events.UpgradeTower:FireServer(towerId)
    end
end

-- Функция для продажи башни
function TDS:Sell(towerId)
    if self.Events.SellTower then
        Log("Selling tower ID: " .. towerId)
        self.Events.SellTower:FireServer(towerId)
    end
end

-- Функция для пропуска волны
function TDS:SkipWave()
    if self.Events.SkipWave then
        Log("Skipping wave")
        self.Events.SkipWave:FireServer()
    end
end

-- Вернем объект TDS, чтобы все методы были доступны
return TDS
