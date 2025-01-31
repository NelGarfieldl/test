local TDS = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Ищем RemoteEvents (примерные названия, нужно проверить в игре)
TDS.Events = {
    PlaceTower = ReplicatedStorage:FindFirstChild("PlaceTower"),
    UpgradeTower = ReplicatedStorage:FindFirstChild("UpgradeTower"),
    SellTower = ReplicatedStorage:FindFirstChild("SellTower"),
    SkipWave = ReplicatedStorage:FindFirstChild("SkipWave"),
    SelectMap = ReplicatedStorage:FindFirstChild("SelectMap"),
    Loadout = ReplicatedStorage:FindFirstChild("SelectLoadout")
}

-- Выбор карты
function TDS:Map(mapName, isHardcore, mode)
    if self.Events.SelectMap then
        self.Events.SelectMap:FireServer(mapName, isHardcore, mode)
    end
end

-- Выбор башен
function TDS:Loadout(towers)
    if self.Events.Loadout then
        self.Events.Loadout:FireServer(towers)
    end
end

-- Размещение башни
function TDS:Place(towerName, x, y, z)
    if self.Events.PlaceTower then
        self.Events.PlaceTower:FireServer(towerName, Vector3.new(x, y, z))
    end
end

-- Улучшение башни
function TDS:Upgrade(towerId)
    if self.Events.UpgradeTower then
        self.Events.UpgradeTower:FireServer(towerId)
    end
end

-- Продажа башни
function TDS:Sell(towerId)
    if self.Events.SellTower then
        self.Events.SellTower:FireServer(towerId)
    end
end

-- Пропуск волны
function TDS:SkipWave()
    if self.Events.SkipWave then
        self.Events.SkipWave:FireServer()
    end
end

return TDS
