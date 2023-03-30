local OrionLib = loadstring(game:HttpGet((
    'https://raw.githubusercontent.com/Rumblenex/UI-Lib/main/Source'
    )))()
local Window = OrionLib:MakeWindow({
    Name = "NexHub | Soul Cultivation",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "OrionTest",
    IntroEnabled = false
})
getgenv().init = false

getgenv().auto1 = false
getgenv().auto2 = false
getgenv().auto3 = false
getgenv().auto4 = false
local ToggleKey = Enum.KeyCode.F

local mainWindow = Window:MakeTab({
    Name = "Autos",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local tpWindow = Window:MakeTab({
    Name = "TPs",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local mainSection = mainWindow:AddSection({
    Name = ""
})

getgenv().Quests = {}
getgenv().SelectedQuest = ""

function getQuestList()
    for i,v in pairs (game:GetService("Workspace")["Quest NPCS"]:GetChildren()) do
        table.insert(getgenv().Quests, v.Name)
    end
end

getQuestList()

mainSection:AddDropdown({
    Name = "Quests",
    Default = getgenv().SelectedQuest,
    Options = getgenv().Quests,
    Callback = function(Value)
        getgenv().SelectedQuest = Value
    end
})

mainSection:AddToggle({
    Name = "Auto Quest",
    Default = getgenv().auto1,
    Callback = function(Value)
        getgenv().auto1 = Value

        if getgenv().auto1 then
 

            local args = {
                [1] = 1,
                [2] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Qi Release")
            }

            game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Manager.Toolbar:FireServer(unpack(args))

            task.wait(0.5)

            local args = {
                [1] = game:GetService("Players").LocalPlayer
            }

            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Qi Release").ReleaseQi:FireServer(unpack(args))


        end
    end
})

mainSection:AddToggle({
    Name = "Auto Cultivate",
    Default = getgenv().auto2,
    Callback = function(Value)
        getgenv().auto2 = Value

        if not Value then
            local args = {
                [1] = false
            }

            game:GetService("ReplicatedStorage"):FindFirstChild("Qi Remote Events").Cultivate:FireServer(unpack(args))
        end
    end
})

tpWindow:AddButton({
    Name = "Yin Yang Tree",
    Callback = function()
        local coords = CFrame.new(200.28537, 75.5624771, 811.163452, 0.654026151, -1.91790548e-08, -0.756471932, -1.02695656e-08, 1, -3.42320945e-08, 0.756471932, 3.01573237e-08, 0.654026151)
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = coords
    end
})



coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait(0.1) do
            if getgenv().auto1 then

                if game:GetService("Players").LocalPlayer.stats["Has Quest"].Value == false then
                    local args = {
                        [1] = workspace:FindFirstChild("Quest NPCS"):FindFirstChild(getgenv().SelectedQuest).HumanoidRootPart.QuestActivator.Quest
                    }
                
                    game:GetService("ReplicatedStorage"):FindFirstChild("Quest Remote Events").EnableQuest:FireServer(unpack(args))
                end
                
            end

            if getgenv().auto2 then
                local args = {
                    [1] = true
                }
                
                game:GetService("ReplicatedStorage"):FindFirstChild("Qi Remote Events").Cultivate:FireServer(unpack(args))

            end
        end
    end)
end))

coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait(0.5) do
            
        end
    end)
end))


OrionLib:Init()

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
