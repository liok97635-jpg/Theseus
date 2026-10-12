-- [-- [[ THESEUS HUB - BUILD AN ISLAND (สร้างเกาะ!) ]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

-- สร้าง UI โดยตรงในเกม (ไม่ต้องโหลด Fluent Library)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleClickBtn = Instance.new("TextButton")
local ToggleCollectBtn = Instance.new("TextButton")

ScreenGui.Name = "TheseusHubIslandUI"
ScreenGui.Parent = game:GetService("CoreGui") or player:WaitForChild("PlayerGui")

-- กรอบเมนูหลัก
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true

-- หัวข้อ THESEUS HUB
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(35, 45, 70)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "THESEUS HUB - สร้างเกาะ! 🏝️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- ปุ่ม 1: Auto Click / Farm
ToggleClickBtn.Parent = MainFrame
ToggleClickBtn.Position = UDim2.new(0.05, 0, 0.28, 0)
ToggleClickBtn.Size = UDim2.new(0.9, 0, 0.3, 0)
ToggleClickBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ToggleClickBtn.Font = Enum.Font.SourceSansBold
ToggleClickBtn.Text = "Auto Click / Farm: OFF"
ToggleClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleClickBtn.TextSize = 16

-- ปุ่ม 2: Auto Collect Items
ToggleCollectBtn.Parent = MainFrame
ToggleCollectBtn.Position = UDim2.new(0.05, 0, 0.62, 0)
ToggleCollectBtn.Size = UDim2.new(0.9, 0, 0.3, 0)
ToggleCollectBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ToggleCollectBtn.Font = Enum.Font.SourceSansBold
ToggleCollectBtn.Text = "Auto Collect Items: OFF"
ToggleCollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleCollectBtn.TextSize = 16

-- สถานะการทำงาน
local autoClick = false
local autoCollect = false

ToggleClickBtn.MouseButton1Click:Connect(function()
    autoClick = not autoClick
    if autoClick then
        ToggleClickBtn.Text = "Auto Click / Farm: ON"
        ToggleClickBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    else
        ToggleClickBtn.Text = "Auto Click / Farm: OFF"
        ToggleClickBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    end
end)

ToggleCollectBtn.MouseButton1Click:Connect(function()
    autoCollect = not autoCollect
    if autoCollect then
        ToggleCollectBtn.Text = "Auto Collect Items: ON"
        ToggleCollectBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    else
        ToggleCollectBtn.Text = "Auto Collect Items: OFF"
        ToggleCollectBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    end
end)

-- Anti-AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- ลูปการทำงานเบื้องหลัง
task.spawn(function()
    while true do
        if autoClick then
            local char = player.Character
            if char and char:FindFirstChildOfClass("Tool") then
                char:FindFirstChildOfClass("Tool"):Activate()
            else
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(500, 500))
            end
        end

        if autoCollect and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            for _, item in pairs(Workspace:GetChildren()) do
                if item:IsA("Part") or item:IsA("MeshPart") or item:IsA("Model") then
                    if item:FindFirstChild("TouchInterest") or item.Name:lower():find("drop") or item.Name:lower():find("wood") or item.Name:lower():find("stone") then
                        if (item:GetPivot().Position - hrp.Position).Magnitude < 40 then
                            item:PivotTo(hrp.CFrame)
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

print("[THESEUS] โหลดสคริปต์สร้างเกาะสำเร็จแล้ว!")
[ THESEUS HUB - BUILD AN ISLAND (สร้างเกาะ!) ]]

