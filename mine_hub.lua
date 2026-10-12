--[[ 
    THESEUS HUB - MINE GAME & CUT GRASS GAME
    Auto-generated script for Roblox
]]

-- 1. Load Fluent UI Library
local success, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/Fluent.lua"))()
end)

if not success then
    warn("Failed to load Fluent UI")
    return
end

-- 2. Create Window UI
local Window = Fluent:CreateWindow({
    Title = "THESEUS HUB",
    SubTitle = "Mine & Cut Grass Game",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- 3. Add Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main Features", Icon = "home" }),
    Resources = Window:AddTab({ Title = "Items & Ores", Icon = "package" })
}

-- Services & Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Cmdr = ReplicatedStorage:FindFirstChild("CmdrClient") or ReplicatedStorage:FindFirstChild("Cmdr")

local function sendCmd(commandStr)
    pcall(function()
        if Cmdr then
            local remote = Cmdr:FindFirstChild("RemoteFunction", true) or Cmdr:FindFirstChild("RemoteEvent", true)
            if remote then
                if remote:IsA("RemoteFunction") then
                    remote:InvokeServer(commandStr)
                elseif remote:IsA("RemoteEvent") then
                    remote:FireServer(commandStr)
                end
            end
        end
    end)
end

-- 4. Main Tab Functions (ฟังก์ชันเพิ่มพลังและดาเมจ)
Tabs.Main:AddButton({
    Title = "Max Stats & Damage",
    Description = "Set tap, pickaxe, and mine stats to maximum",
    Callback = function()
        sendCmd("SetTap 999999999")
        sendCmd("SetPickaxe 999999999")
        sendCmd("MineStats 999999999")
        sendCmd("MaxMine")
        Fluent:Notify({ Title = "Success", Content = "Stats and Damage maximized!", Duration = 3 })
    end
})

Tabs.Main:AddButton({
    Title = "Give Money & Gems",
    Description = "Add massive amount of money and gems",
    Callback = function()
        sendCmd("GiveMoney 999999999999")
        sendCmd("GiveGems 999999999999")
        Fluent:Notify({ Title = "Success", Content = "Money and Gems added!", Duration = 3 })
    end
})

-- 5. Resources Tab Functions (ฟังก์ชันเสกไอเทมและแร่)
Tabs.Resources:AddButton({
    Title = "Give All Items & Enchants",
    Description = "Unlock all items and titan enchant",
    Callback = function()
        sendCmd("GiveAllItems")
        sendCmd("SetEnchant Titan")
        Fluent:Notify({ Title = "Success", Content = "All items and enchants given!", Duration = 3 })
    end
})

Tabs.Resources:AddButton({
    Title = "Give All Zone Items (1-12)",
    Description = "Claim items and ores from zone 1 to 12",
    Callback = function()
        task.spawn(function()
            for zone = 1, 12 do
                sendCmd("GiveZoneItems " .. tostring(zone))
                task.wait(0.1)
            end
            Fluent:Notify({ Title = "Success", Content = "All zone items claimed!", Duration = 3 })
        end)
    end
})

Fluent:Notify({
    Title = "Theseus Hub Loaded",
    Content = "Script executed successfully!",
    Duration = 5
})
