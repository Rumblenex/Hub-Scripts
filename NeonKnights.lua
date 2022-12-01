local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
-- Change Theme and create window
local colors = {
    SchemeColor = Color3.fromRGB(200, 200, 255),
    Background = Color3.fromRGB(0, 0, 0),
    Header = Color3.fromRGB(0, 0, 0),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(20, 20, 20)
}
local Window = Library.CreateLib("Neon Knights GUI, Made by Rumblenex", colors)
-- global variables

getgenv().auto1 = false
getgenv().auto2 = false
getgenv().player = ""

-- Tabs
local mainTab = Window:NewTab("Main")
local miscTab = Window:NewTab("Misc")
local mainSection = mainTab:NewSection("Main Scripts")
local miscSection = miscTab:NewSection("Misc")


mainSection:NewToggle("Auto Reload", "Auto 1", function(state)
    getgenv().auto1 = state
end)

mainSection:NewToggle("Auto Pickup", "Auto 2", function(state)
    getgenv().auto2 = state
end)

-- speed
miscSection:NewTextBox("Walkspeed", "Sets player walkspeed", function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)


coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait(0.1) do
            if getgenv().auto1 then
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
            if getgenv().auto2 then
                for i, v in pairs(game.workspace:GetChildren()) do
                    if v.Name == "Lootbundle" then
                        if workspace:FindFirstChild("Lootbundle"):FindFirstChild("Exp") then
                            local args = {
                                [1] = 10
                            }
                            workspace.Lootbundle.Exp.Purchase:FireServer(unpack(args))

                        end

                        if workspace:FindFirstChild("Lootbundle"):FindFirstChild("Money") then
                            local args = {
                                [1] = 10
                            }

                            workspace.Lootbundle.Money.Purchase:FireServer(unpack(args))

                        end

                        if workspace:FindFirstChild("Lootbundle"):FindFirstChild("Ammo") then
                            local args = {
                                [1] = 25
                            }

                            workspace.Lootbundle.Ammo.Purchase:FireServer(unpack(args))

                        end

                        if workspace:FindFirstChild("Lootbundle"):FindFirstChild("Health") then
                            local args = {
                                [1] = 1
                            }

                            workspace.Lootbundle.Health.Purchase:FireServer(unpack(args))

                        end
                    end
                end
            end
        end
    end)
end))
