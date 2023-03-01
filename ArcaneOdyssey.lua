local player = game.Players.LocalPlayer.Name
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Rumblenex/UI-Lib/main/Source')))()

local Window = OrionLib:MakeWindow({
    Name = "NexHub | Arcane Odyssey",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "OrionTest",
    IntroEnabled = false
})

local destroy = Window:MakeTab({
    Name = "Destroy"
})

destroy:AddButton({
    Name = "Destroy",
    Callback = function()
        OrionLib:Destroy()
    end
})

local tpTab = Window:MakeTab({
    Name = "Tp"
})

tpTab:AddButton({
    Name = "Quest Marker TP",
    Callback = function()
        local var = game:GetService("Workspace").Camera:FindFirstChild("StoryMarker1") or
                        game:GetService("Workspace").Camera:FindFirstChild("QuestMarker1")
        game:GetService("Workspace"):FindFirstChild(player).HumanoidRootPart.CFrame = var.CFrame
    end
})

local npcTable = {}

for i, v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
    table.insert(npcTable, v.Name)
end

tpTab:AddDropdown({
    Name = "NPCs Tp Dropdown",
    Default = "",
    Options = npcTable,
    Callback = function(Value)
        local npcCFrame = game:GetService("Workspace").NPCs:FindFirstChild(Value):FindFirstChild("CF").Value
        game:GetService("Workspace"):FindFirstChild(player).HumanoidRootPart.CFrame = npcCFrame
        -- for _, j in pairs(game:GetService("Workspace").NPCs:FindFirstChild(Value):GetDescendants()) do
        --     if j.Name == "HumanoidRootPart" then
        --         game:GetService("Workspace"):FindFirstChild(player).HumanoidRootPart.CFrame = j.CFrame
        --     end
        -- end
    end
})

tpTab:AddTextbox({
    Name = "NPCs Tp Type Name",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        local npcCFrame = game:GetService("Workspace").NPCs:FindFirstChild(Value):FindFirstChild("CF").Value
        game:GetService("Workspace"):FindFirstChild(player).HumanoidRootPart.CFrame = npcCFrame
        -- for _, j in pairs(game:GetService("Workspace").NPCs:FindFirstChild(Value):GetDescendants()) do
        --     if j.Name == "HumanoidRootPart" then
        --         game:GetService("Workspace"):FindFirstChild(player).HumanoidRootPart.CFrame = j.CFrame
        --     end
        -- end
    end
})

local enemieTable = {}

for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
    table.insert(enemieTable, v.Name)
end

tpTab:AddDropdown({
    Name = "Enemies",
    Default = "",
    Options = enemieTable,
    Callback = function(Value)
        for _, j in pairs(game:GetService("Workspace").Enemies:FindFirstChild(Value):GetDescendants()) do
            if j.Name == "HumanoidRootPart" then
                game:GetService("Workspace"):FindFirstChild(player).HumanoidRootPart.CFrame = j.CFrame
            end
        end
    end
})

tpTab:AddTextbox({
    Name = "Enemies Tp Type Name",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        for _, j in pairs(game:GetService("Workspace").Enemies:FindFirstChild(Value):GetDescendants()) do
            if j.Name == "HumanoidRootPart" then
                game:GetService("Workspace"):FindFirstChild(player).HumanoidRootPart.CFrame = j.CFrame
            end
        end
    end
})

local autoTab = Window:MakeTab({
    Name = "Misc"
})

local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
local NotificationLibrary = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()

for i, v in pairs(game:GetDescendants()) do
    if string.match(v.Name, " Chest") and v:FindFirstChild("Base") then
        ESP:Add(v:FindFirstChild("Base"), {
            Name = v.Name,
            Color = Color3.fromRGB(255, 0, 0),
            IsEnabled = "Chests"
        })
    end

    if v.Name == "Center" and v.Parent:FindFirstChild("DetailsLoaded") then
        ESP:Add(v, {
            Name = v.Parent.Name,
            Color = Color3.fromRGB(0, 255, 0),
            IsEnabled = "Islands"
        })

    end

end

autoTab:AddToggle({
    Name = "All Esp",
    Default = false,
    Callback = function(Value)
        ESP:Toggle(Value)
    end
})

autoTab:AddToggle({
    Name = "Player Esp",
    Default = false,
    Callback = function(Value)
        ESP.Players = Value
    end
})

autoTab:AddToggle({
    Name = "Chest Esp",
    Default = false,
    Callback = function(Value)
        ESP.Chests = Value
    end
})

autoTab:AddToggle({
    Name = "Island Esp",
    Default = false,
    Callback = function(Value)
        ESP.Islands = Value
    end
})

getgenv().autoFish = false
autoTab:AddToggle({
    Name = "Auto Fish",
    Default = false,
    Callback = function(Value)
        getgenv().autoFish = Value
    end
})

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if getgenv().autoFish then
            local rod = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Wooden Rod") or
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bronze Rod")
            if game:GetService("Workspace"):FindFirstChild(player):FindFirstChild("BobberVal") == null then
                local args = {
                    [1] = rod
                }

                game:GetService("ReplicatedStorage").RS.Remotes.Misc.ToolAction:FireServer(unpack(args))
            end

            local fishBiteGoal = game:GetService("Workspace"):FindFirstChild(player):FindFirstChild("FishBiteGoal")

            if fishBiteGoal ~= null then
                mouse1click()
            end
        end
    end
end))




OrionLib:Init()
