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

-- STATS TAB
local statsTab = Window:MakeTab({
    Name = "Stats",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local PlayerModel = Character:WaitForChild('Playermodel')
local IntStats = PlayerModel.Intstats

local defaultValues = {
    Stamrate = 0.9; -- lower = better
    Speeddash = 90; -- higher = better; but not too high
    Stamcharge = 2;
}

local stamRegen = statsTab:AddTextbox {
    Name = "Stamine Regen Rate (lower = better)",
    Default = 0.9,
    TextDisappear = false,
    Callback = function(Value)
        IntStats['Stamrate'].Value = Value
    end
}

local stamCharge = statsTab:AddTextbox {
    Name = "Stamine Charges",
    Default = 2,
    TextDisappear = false,
    Callback = function(Value)
        IntStats['Stamcharge'].Value = Value
    end
}

local dashRange = statsTab:AddTextbox {
    Name = "Dash Range (non shift dash)",
    Default = 90,
    TextDisappear = false,
    Callback = function(Value)
        IntStats['Speeddash'].Value = Value
    end
}

statsTab:AddButton({
    Name = "Set Stats",
    Callback = function()
        IntStats['Speeddash'].Value = 200
        IntStats['Stamrate'].Value = 0.00001
        IntStats['Stamcharge'].Value = 5
    end
})

statsTab:AddButton({
    Name = "Reset Stats",
    Callback = function()
        IntStats['Speeddash'].Value = defaultValues["Speeddash"]
        IntStats['Stamrate'].Value = defaultValues["Stamrate"]
        IntStats['Stamcharge'].Value = defaultValues["Stamcharge"]
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
