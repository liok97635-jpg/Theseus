-- [[ THESEUS HUB - BUILD AN ANT EMPIRE ]]

-- 1. โหลด Fluent UI Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- 2. สร้างหน้าต่างหลัก THESEUS
local Window = Fluent:CreateWindow({
    Title = "THESEUS HUB",
    SubTitle = "Build An Ant Empire",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Services & Variables
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local autoFarmEnabled = false

-- Functions ค้นหาไอเทมและแปลง
local function getHoneydripSeeds()
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        return backpack:FindFirstChild("Honeydrip Stalk Seeds")
    end
    return nil
end

local function getPlayerPlot()
    local plots = Workspace:FindFirstChild("Plots")
    if plots and plots:FindFirstChild(player.Name) then
        return plots[player.Name]:FindFirstChild("Land")
    end
    return nil
end

-- 3. สร้าง แท็บ (Tab) ด้านข้าง
local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" })
}

-- 4. เพิ่มปุ่มสวิตช์ Toggle เปิด/ปิด
local Toggle = Tabs.Main:AddToggle("AutoFarmToggle", {
    Title = "Auto Farm Honeydrip Seeds",
    Default = false
})

Toggle:OnChanged(function(Value)
    autoFarmEnabled = Value
    if Value then
        Fluent:Notify({
            Title = "THESEUS HUB",
            Content = "เริ่มทำงานระบบ Auto Farm เรียบร้อยแล้ว",
            Duration = 3
        })
    end
end)

-- 5. ลูปทำงาน Auto Farm เบื้องหลัง
task.spawn(function()
    while true do
        if autoFarmEnabled then
            local seeds = getHoneydripSeeds()
            local land = getPlayerPlot()
            
            if seeds and land then
                print("[THESEUS] พบเมล็ดพันธุ์และแปลงปลูกแล้ว")
            end
        end
        task.wait(2)
    end
end)

Window:SelectTab(1)
