local OrionLib = loadstring(game:HttpGet((
    'https://raw.githubusercontent.com/Rumblenex/UI-Lib/main/Source'
    )))()
local Window = OrionLib:MakeWindow({
    Name = "NexHub | Neon Knights",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "OrionTest",
    IntroEnabled = false
})
getgenv().init = false

getgenv().autoReload = false
getgenv().autoPickup = false
getgenv().autoOpen = false

local mainWindow = Window:MakeTab({
    Name = "Autos",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local mainSection = mainWindow:AddSection({
    Name = ""
})

mainSection:AddToggle({
    Name = "Auto Reload",
    Default = getgenv().autoReload,
    Callback = function(Value)
        getgenv().autoReload = Value
    end
})

mainSection:AddToggle({
    Name = "Auto Pickup",
    Default = getgenv().autoReload,
    Callback = function(Value)
        getgenv().autoPickup = Value
    end
})

mainSection:AddToggle({
    Name = "Auto Open Chests",
    Default = getgenv().autoReload,
    Callback = function(Value)
        getgenv().autoOpen = Value
    end
})

coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait(0.1) do
            if getgenv().autoReload then

                for i, v in pairs(game:GetService("Players").LocalPlayer.Character.Gunmain.Gunhotbar:GetChildren()) do
                    local args = {
                        [1] = "Reload",
                        [2] = 1669839430.608705,
                        [3] = 1,
                        [4] = v
                    }
                    game:GetService("Players").LocalPlayer.Character.Gunmain.Guninput:FireServer(unpack(args))
                end

            end
        end
    end)
end))

coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait() do
            wait(0.1)
            if getgenv().autoPickup then
                for i, v in pairs(game.workspace:GetDescendants()) do
                    if v:IsA("Model") and v.Name == "Lootbundle" then
                        for i, j in pairs(v:GetDescendants()) do
                            if j.Name == "Stats" then
                                local args = {
                                    [1] = "Gunopen",
                                    [2] = "Unequip",
                                    [3] = j.Parent,
                                    [4] = "Gunitem"
                                }
                                game:GetService("ReplicatedStorage").Ints.Interactcontrol:InvokeServer(unpack(args))
                            end

                            if j:IsA("RemoteEvent") and j.Name == "Purchase" then
                                j:FireServer(1000)
                            end
                        end

                    end
                end
            end
        end
    end)
end))

coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait(0.1) do
            if getgenv().autoOpen then
                for i, v in pairs(game.workspace:FindFirstChild("Dungeon"):GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Activate") then
                        local args = {
                            [1] = "Chestopen",
                            [2] = v
                        }
                        game:GetService("ReplicatedStorage").Ints.Interactcontrol:InvokeServer(unpack(args))
                    end
                end
            end
        end
    end)
end))


OrionLib:Init()
