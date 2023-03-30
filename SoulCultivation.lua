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

local mainSection = mainWindow:AddSection({
    Name = ""
})


mainSection:AddToggle({
    Name = "Auto Combat (Bandit Quest)",
    Default = getgenv().auto1,
    Callback = function(Value)
        getgenv().auto1 = Value
    end
})

mainSection:AddToggle({
    Name = "Auto Cultivate",
    Default = getgenv().auto2,
    Callback = function(Value)
        getgenv().auto2 = Value
    end
})



coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait(1) do
            if getgenv().auto1 then
                local args = {
                    [1] = workspace:FindFirstChild("Quest NPCS"):FindFirstChild("Xavier - Quest").HumanoidRootPart.QuestActivator.Quest
                }
                
                game:GetService("ReplicatedStorage"):FindFirstChild("Quest Remote Events").EnableQuest:FireServer(unpack(args))
                
               
                
                local args = {
                    [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Right Arm")
                }
                
                game:GetService("Players").LocalPlayer.Character.Combat.Combo.C0:FireServer(unpack(args))
                
                
            end
        end
    end)
end))

coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait(0.5) do
            if getgenv().auto2 then
                local args = {
                    [1] = true
                }
                
                game:GetService("ReplicatedStorage"):FindFirstChild("Qi Remote Events").Cultivate:FireServer(unpack(args))
            end
        end
    end)
end))


OrionLib:Init()
