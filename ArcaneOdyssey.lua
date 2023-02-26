local player = game.Players.LocalPlayer.Name
local OrionLib = loadstring(game:HttpGet((
    'https://raw.githubusercontent.com/Rumblenex/UI-Lib/main/Source'
    )))()

local Window = OrionLib:MakeWindow({
    Name = "NexHub | Arcane Odyssey",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "OrionTest",
    IntroEnabled = false
})

local destroy = Window:MakeTab({
    Name = "Destroy",
})

destroy:AddButton({
    Name = "Destroy",
    Callback = function()
        OrionLib:Destroy()
    end
})


local tpTab = Window:MakeTab({
    Name = "Tp",
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
    Name = "Misc",
})

getgenv().esp = false
getgenv().chestesp = true
getgenv().islandesp = true
autoTab:AddToggle({
    Name = "All Esp",
    Default = false,
    Callback = function(Value)
        getgenv().esp = Value

        if Value == false then
            for _, v in pairs(game:GetService("Workspace").Map:GetDescendants()) do
                if v.Name == "chestesp" or v.Name == "islandesp" then
                    v:Destroy()
                end
            end
        end
    end
})

autoTab:AddToggle({
    Name = "Chest Esp",
    Default = false,
    Callback = function(Value)
        getgenv().chestesp = Value

        if Value == false then
            for _, v in pairs(game:GetService("Workspace").Map:GetDescendants()) do
                if v.Name == "chestesp" then
                    v:Destroy()
                end
            end
        end
    end
})

autoTab:AddToggle({
    Name = "Island Esp",
    Default = false,
    Callback = function(Value)
        getgenv().islandesp = Value

        if Value == false then
            for _, v in pairs(game:GetService("Workspace").Map:GetDescendants()) do
                if v.Name == "islandesp" then
                    v:Destroy()
                end
            end
        end
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

coroutine.resume(coroutine.create(function()
    while task.wait(1) do
        if game.workspace:FindFirstChild("BillboardGui") == null then
            local billboard = Instance.new("BillboardGui")
            local label = Instance.new("TextLabel")

            -- Set up billboard
            billboard.MaxDistance = 100000
            billboard.Adornee = part
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 50, 0, 20)

            -- Set up label
            label.Size = UDim2.new(1, 0, 1, 0)

            -- Set partents of objects
            billboard.Parent = game.Workspace
            label.Parent = game.workspace.BillboardGui

            label.Text = "test"
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(255, 0, 0)
            label.Font = "FredokaOne"
            label.TextSize = 15
        end

        task.wait(0.5)
        for _, v in pairs(game:GetService("Workspace").Map:GetDescendants()) do
            if getgenv().esp then
                if getgenv().chestesp then
                    if v.Name == "ChestObj" and v.Parent:FindFirstChild("Open") == null and v.Parent:FindFirstChild("chestesp") == null then
                        local chestesp = game.workspace.BillboardGui:Clone()
                        chestesp.Name = "chestesp"
                        chestesp.Parent = v.Parent
                        chestesp.TextLabel.Text = v.Parent.Name
                        -- local billboard = Instance.new("BillboardGui")
                        -- local label = Instance.new("TextLabel")


                        -- -- Set up billboard
                        -- billboard.MaxDistance = 100000
                        -- billboard.Adornee = part
                        -- billboard.AlwaysOnTop = true
                        -- billboard.Size = UDim2.new(0, 50, 0, 20)
                        -- billboard.Name = "chestesp"

                        -- -- Set up label
                        -- label.Size = UDim2.new(1, 0, 1, 0)

                        -- -- Set partents of objects
                        -- label.Parent = billboard
                        -- billboard.Parent = v.Parent

                        -- label.Text = v.Parent.Name
                        -- label.BackgroundTransparency = 1
                        -- label.TextColor3 = Color3.new(255, 0, 0)
                        -- label.Font = "FredokaOne"
                        -- label.TextSize = 15
                    end
                    if v.Name == "chestesp" and v.Parent:FindFirstChild("Open") then
                        v:Destroy()
                    end
                end

                if getgenv().islandesp and v.Name == "Center" and v.Parent:FindFirstChild("DetailsLoaded") and v:FindFirstChild("islandesp") == null then
                    local islandesp = game.workspace.BillboardGui:Clone()
                    islandesp.Name = "islandesp"
                    islandesp.Parent = v
                    islandesp.TextLabel.Text = v.Parent.Name
                    islandesp.TextLabel.TextColor3 = Color3.new(0, 255, 0)
                    -- local billboard = Instance.new("BillboardGui")
                    -- local label = Instance.new("TextLabel")


                    -- -- Set up billboard
                    -- billboard.MaxDistance = 100000
                    -- billboard.Adornee = part
                    -- billboard.AlwaysOnTop = true
                    -- billboard.Size = UDim2.new(0, 50, 0, 20)
                    -- billboard.Name = "islandesp"

                    -- -- Set up label
                    -- label.Size = UDim2.new(1, 0, 1, 0)

                    -- -- Set partents of objects
                    -- label.Parent = billboard
                    -- billboard.Parent = v

                    -- label.Text = v.Parent.Name
                    -- label.BackgroundTransparency = 1
                    -- label.TextColor3 = Color3.new(0, 255, 0)
                    -- label.Font = "FredokaOne"
                    -- label.TextSize = 15
                end
            else
                if v.Name == "chestesp" and v.Name == "islandesp" then
                    v:Destroy()
                end
            end
        end
    end
end))


OrionLib:Init()
