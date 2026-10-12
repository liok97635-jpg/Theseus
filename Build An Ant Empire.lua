-- [[ THESEUS HUB - BUILD AN ISLAND (สร้างเกาะ!) ]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "THESEUS HUB",
    SubTitle = "สร้างเกาะ! 🏝️",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local autoClickEnabled = false
local autoCollectEnabled = false

local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" })
}

local ToggleClick = Tabs.Main:AddToggle("AutoClickToggle", {
    Title = "Auto Click / Farm (โจมตี/ขุด อัตโนมัติ)",
    Default = false
})

ToggleClick:OnChanged(function(Value)
    autoClickEnabled = Value
    if Value then
        Fluent:Notify({
            Title = "THESEUS HUB",
            Content = "เปิดใช้งานระบบ Auto Click เรียบร้อยแล้ว",
            Duration = 3
        })
    end
end)

local ToggleCollect = Tabs.Main:AddToggle("AutoCollectToggle", {
    Title = "Auto Collect Items (เก็บของรอบๆ อัตโนมัติ)",
    Default = false
})

ToggleCollect:OnChanged(function(Value)
    autoCollectEnabled = Value
end)

player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

task.spawn(function()
    while true do
        if autoClickEnabled then
            local char = player.Character
            if char and char:FindFirstChildOfClass("Tool") then
                char:FindFirstChildOfClass("Tool"):Activate()
            else
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(500, 500))
            end
        end

        if autoCollectEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            for _, item in pairs(Workspace:GetChildren()) do
                if item:IsA("Part") or item:IsA("MeshPart") or item:IsA("Model") then
                    if item:FindFirstChild("TouchInterest") or item.Name:lower():find("drop") or item.Name:lower():find("wood") or item.Name:lower():find("stone") then
                        if (item:GetPivot().Position - hrp.Position).Magnitude < 30 then
                            item:PivotTo(hrp.CFrame)
                        end
                    end
                end
            end
        end

        task.wait(0.1)
    end
end)

Window:SelectTab(1)
