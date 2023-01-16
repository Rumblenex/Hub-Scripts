--v9.0 Nex Hub
--Wait for game to load
local version = "9.0.4"
local updateNotes = "\nv9.0\n-Updated for Chainsaw man"
task.wait(2)
repeat task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then

    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):
        FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")

else
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
    repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end
-------------------------------------------

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

getgenv().savefilename = "Anime-Adventures_" .. game.Players.LocalPlayer.Name .. "_Custom.json"

-- get daily infinite
local function dailyInfinite()
    if (getgenv().world == "Planet Namak") then
        getgenv().namekDailyInfinite = true

    elseif (getgenv().world == "Shiganshinu District") then
        getgenv().aotDailyInfinite = true

    elseif (getgenv().world == "Snowy Town") then
        getgenv().demonslayerDailyInfinite = true

    elseif (getgenv().world == "Hidden Sand Village") then
        getgenv().narutoDailyInfinite = true

    elseif (getgenv().world == "Marine's Ford") then
        getgenv().marinefordDailyInfinite = true

    elseif (getgenv().world == "Ghoul City") then
        getgenv().tokyoGhoulDailyInfinite = true

    elseif (getgenv().world == "Hollow World") then
        getgenv().bleachDailyInfinite = true

    elseif (getgenv().world == "Ant Kingdom") then
        getgenv().hxhDailyInfinite = true

    elseif (getgenv().world == "Cursed Academy") then
        getgenv().jjkDailyInfinite = true

    elseif (getgenv().world == "Magic Town") then
        getgenv().fairytailDailyInfinite = true

    elseif (getgenv().world == "Clover Kingdom") then
        getgenv().blackCloverInfinite = true
    end
end

-- webhook
local function webhook()
    pcall(function()
        local url = tostring(getgenv().weburl) -- webhook url
        if url == "" then
            return
        end

        XP = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward
            .Main.Amount.Text)
        gems = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame
            .GemReward.Main.Amount.Text)

        cwaves = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text

        ctime = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text
        waves = cwaves:split(": ")
        ttime = ctime:split(": ")

        -- check if the game reached to set wave and set infinite for that map to true
        if ((tonumber(waves[2])) >= tonumber(getgenv().sellatwave) and tonumber(waves[2]) ~= 999) then
            dailyInfinite()
        end
        updatejson()
        local data = {
            ["content"] = "",
            ["username"] = "Anime Adventures",
            ["avatar_url"] = "https://tr.rbxcdn.com/e5b5844fb26df605986b94d87384f5fb/150/150/Image/Jpeg",
            ["embeds"] = {
                {
                    ["author"] = {
                        ["name"] = "Anime Adventures | Result ✔",
                        ["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
                    },
                    ["description"] = "🎮 **" .. game:GetService("Players").LocalPlayer.Name .. "** 🎮",
                    ["color"] = 110335,

                    ["thumbnail"] = {
                        ['url'] = "https://www.roblox.com/headshot-thumbnail/image?userId=" ..
                            game.Players.LocalPlayer.userId .. "&width=420&height=420&format=png"
                    },

                    ["fields"] = {
                        {
                            ["name"] = "Total Waves:",
                            ["value"] = tostring(waves[2]) ..
                                " <:wave:997136622363627530>",
                            ["inline"] = true
                        }, {
                            ["name"] = "Recieved Gems:",
                            ["value"] = gems ..
                                " <:gem:997123585476927558>\n",
                            ["inline"] = true
                        }, {
                            ["name"] = "Recieved XP:",
                            ["value"] = XP .. " 🧪",
                            ["inline"] = true
                        }, {
                            ["name"] = "Total Time:",
                            ["value"] = tostring(ttime[2]) .. " ⏳",
                            ["inline"] = true
                        }, {
                            ["name"] = "Current Gems:",
                            ["value"] = tostring(game.Players.LocalPlayer._stats.gem_amount.Value) ..
                                " <:gem:997123585476927558>\n" ..
                                tostring(game.Players.LocalPlayer._stats._resourceHolidayStars.Value) ..
                                " <:holidaystar:1057147821746307183>",
                            ["inline"] = true
                        }, {
                            ["name"] = "Current Level:",
                            ["value"] = tostring(game.Players.LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)
                                .. " ✨",
                            ["inline"] = true
                        }, {
                            ["name"] = "World: ",
                            ["value"] = tostring(getgenv().world) .. " 🌐",
                            ["inline"] = true
                        }
                    }
                }
            }
        }
        local getData = game:GetService("HttpService"):JSONEncode(data)


        local headers = { ["content-type"] = "application/json" }
        request = http_request or request or HttpPost or syn.request or http.request
        local sendData = { Url = url, Body = getData, Method = "POST", Headers = headers }
        warn("Sending webhook notification...")
        request(sendData)


    end)
end

--Buy Item Webhook
local function buyItemWebhook(itemBought, amount)
    pcall(function()
        local url = tostring(getgenv().weburl) --webhook
        print("webhook?")
        if url == "" then
            return
        end

        local data = {
            ["content"] = "",
            ["username"] = "Anime Adventures",
            ["avatar_url"] = "https://tr.rbxcdn.com/e5b5844fb26df605986b94d87384f5fb/150/150/Image/Jpeg",
            ["embeds"] = {
                {
                    ["author"] = {
                        ["name"] = "Anime Adventures | Result ✔",
                        ["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
                    },
                    ["description"] = "🎮 **" .. game:GetService("Players").LocalPlayer.Name .. "** 🎮",
                    ["color"] = 110335,

                    ["thumbnail"] = {
                        ['url'] = "https://www.roblox.com/headshot-thumbnail/image?userId=" ..
                            game.Players.LocalPlayer.userId .. "&width=420&height=420&format=png"
                    },

                    ["fields"] = {
                        {
                            ["name"] = "Item Bought",
                            ["value"] = itemBought .. "\nTotal: " .. amount,
                            ["inline"] = true
                        }
                    }
                }
            }
        }

        local getData = game:GetService("HttpService"):JSONEncode(data)

        local headers = { ["content-type"] = "application/json" }
        request = http_request or request or HttpPost or syn.request or http.request
        local sendData = { Url = url, Body = getData, Method = "POST", Headers = headers }
        warn("Sending webhook notification...")
        request(sendData)
    end)
end

--JSON File
function jsonFile()
    -- read json file
    local jsonData = readfile(savefilename)
    local data = HttpService:JSONDecode(jsonData)

    -- global values
    getgenv().disableautofarm = false

    getgenv().sellatwave = data.sellatwave
    getgenv().autosell = data.autosell
    getgenv().AutoFarm = data.autofarm
    getgenv().weburl = data.webhook
    getgenv().autostart = data.autostart
    getgenv().autoupgrade = data.autoupgrade
    getgenv().difficulty = data.difficulty
    getgenv().world = data.world
    getgenv().level = data.level
    getgenv().door = data.door

    getgenv().SpawnUnitPos = data.xspawnUnitPos
    getgenv().SelectedUnits = data.xselectedUnits
    getgenv().autoabilities = data.autoabilities

    getgenv().farmDailies = data.farmDailies
    getgenv().namekDailyInfinite = data.namekDailyInfinite
    getgenv().aotDailyInfinite = data.aotDailyInfinite
    getgenv().demonslayerDailyInfinite = data.demonslayerDailyInfinite
    getgenv().narutoDailyInfinite = data.narutoDailyInfinite
    getgenv().marinefordDailyInfinite = data.marinefordDailyInfinite
    getgenv().tokyoGhoulDailyInfinite = data.tokyoGhoulDailyInfinite
    getgenv().bleachDailyInfinite = data.bleachDailyInfinite
    getgenv().hxhDailyInfinite = data.hxhDailyInfinite
    getgenv().fairytailDailyInfinite = data.fairytailDailyInfinite
    getgenv().jjkDailyInfinite = data.jjkDailyInfinite
    getgenv().blackCloverInfinite = data.blackCloverInfinite
    getgenv().jojoDailyInfinite = data.jojoDailyInfinite

    getgenv().namekSpawnPos = data.xnamekSpawnPos
    getgenv().aotSpawnPos = data.xaotSpawnPos
    getgenv().demonslayerSpawnPos = data.xdemonslayerSpawnPos
    getgenv().narutoSpawnPos = data.xnarutoSpawnPos
    getgenv().marinefordSpawnPos = data.xmarinefordSpawnPos
    getgenv().tokyoGhoulSpawnPos = data.xtokyoGhoulSpawnPos
    getgenv().bleachSpawnPos = data.xbleachSpawnPos
    getgenv().hxhSpawnPos = data.xhxhSpawnPos
    getgenv().fairytailSpawnPos = data.xfairytailSpawnPos
    getgenv().jjkSpawnPos = data.xjjkSpawnPos
    getgenv().eventSpawnPos = data.xEventSpawnPos
    getgenv().blackCloverSpawnPos = data.xblackCloverSpawnPos
    getgenv().karakuraTownSpawnPos = data.xkarakuraTownSpawnPos
    getgenv().jojoSpawnPos = data.xjojoSpawnPos

    getgenv().buyStarRemnant = data.buyStarRemnant
    getgenv().buySummonTicket = data.buySummonTicket

    --
    getgenv().maxUpgrades = data.maxUpgrades
    getgenv().ignoreTiers = data.ignoreTiers
    getgenv().autoPortal = data.autoPortal
    getgenv().tier = data.tier
    getgenv().eventWorlds = data.eventWorlds

    getgenv().autochallenge = data.autochallenge
    getgenv().challengerewards = data.challengerewards
    getgenv().challengeWorlds = data.challengeWorlds
    getgenv().challengeDifficulty = data.challengeDifficulty
    getgenv().eventmission = data.eventmission
    getgenv().missionboard = data.missionboard
    getgenv().farmCastle = data.farmCastle
    getgenv().farmEvent = data.farmEvent
    getgenv().cursedWomb = data.cursedWomb
    getgenv().contractToBuy = data.contractToBuy
    getgenv().limitContracts = data.limitContracts
    getgenv().physicalTeam = data.physicalTeam
    getgenv().magicTeam = data.magicTeam



    ---// updates the json file
    function updatejson()

        local xdata = {
            -- unitname = getgenv().unitname,
            -- unitid = getgenv().unitid,
            sellatwave = getgenv().sellatwave,
            autosell = getgenv().autosell,
            webhook = getgenv().weburl,
            autofarm = getgenv().AutoFarm,
            autostart = getgenv().autostart,
            autoupgrade = getgenv().autoupgrade,
            difficulty = getgenv().difficulty,
            world = getgenv().world,
            level = getgenv().level,
            door = getgenv().door,
            xspawnUnitPos = getgenv().SpawnUnitPos,
            xselectedUnits = getgenv().SelectedUnits,
            autoabilities = getgenv().autoabilities,
            farmCastle = getgenv().farmCastle,
            farmEvent = getgenv().farmEvent,
            ignoreTiers = getgenv().ignoreTiers,
            tier = getgenv().tier,
            autoPortal = getgenv().autoPortal,
            eventWorlds = getgenv().eventWorlds,

            --store whether or not dailies for each map were completed
            farmDailies = getgenv().farmDailies,
            namekDailyInfinite = getgenv().namekDailyInfinite,
            aotDailyInfinite = getgenv().aotDailyInfinite,
            demonslayerDailyInfinite = getgenv().demonslayerDailyInfinite,
            narutoDailyInfinite = getgenv().narutoDailyInfinite,
            marinefordDailyInfinite = getgenv().marinefordDailyInfinite,
            tokyoGhoulDailyInfinite = getgenv().tokyoGhoulDailyInfinite,
            bleachDailyInfinite = getgenv().bleachDailyInfinite,
            hxhDailyInfinite = getgenv().hxhDailyInfinite,
            fairytailDailyInfinite = getgenv().fairytailDailyInfinite,
            jjkDailyInfinite = getgenv().jjkDailyInfinite,
            blackCloverInfinite = getgenv().blackCloverInfinite,
            jojoDailyInfinite = getgenv().jojoDailyInfinite,

            xnamekSpawnPos = getgenv().namekSpawnPos,
            xaotSpawnPos = getgenv().aotSpawnPos,
            xdemonslayerSpawnPos = getgenv().demonslayerSpawnPos,
            xnarutoSpawnPos = getgenv().narutoSpawnPos,
            xmarinefordSpawnPos = getgenv().marinefordSpawnPos,
            xtokyoGhoulSpawnPos = getgenv().tokyoGhoulSpawnPos,
            xbleachSpawnPos = getgenv().bleachSpawnPos,
            xhxhSpawnPos = getgenv().hxhSpawnPos,
            xfairytailSpawnPos = getgenv().fairytailSpawnPos,
            xjjkSpawnPos = getgenv().jjkSpawnPos,
            xEventSpawnPos = getgenv().eventSpawnPos,
            xblackCloverSpawnPos = getgenv().blackCloverSpawnPos,
            xkarakuraTownSpawnPos = getgenv().karakuraTownSpawnPos,
            xjojoSpawnPos = getgenv().jojoSpawnPos,

            buyStarRemnant = getgenv().buyStarRemnant,
            buySummonTicket = getgenv().buySummonTicket,

            maxUpgrades = getgenv().maxUpgrades,

            autochallenge = getgenv().autochallenge,
            challengerewards = getgenv().challengerewards,
            challengeWorlds = getgenv().challengeWorlds,
            challengeDifficulty = getgenv().challengeDifficulty,
            eventmission = getgenv().eventmission,
            missionboard = getgenv().missionboard,
            cursedWomb = getgenv().cursedWomb,
            contractToBuy = getgenv().contractToBuy or nil,
            limitContracts = getgenv().limitContracts or 1,
            physicalTeam = getgenv().physicalTeam or {},
            magicTeam = getgenv().magicTeam or {},

        }

        local json = HttpService:JSONEncode(xdata)
        writefile(savefilename, json)

    end

    -- IN GAME GUI --
    local OrionLib = loadstring(game:HttpGet((
        'https://raw.githubusercontent.com/Rumblenex/UI-Lib/main/Source'
        )))()
    local Window = OrionLib:MakeWindow({
        Name = "NexHub | Anime Adventures | v" .. version,
        HidePremium = true,
        SaveConfig = true,
        ConfigFolder = "OrionTest",
        IntroEnabled = false
    })
    getgenv().init = false


    -- SELECT UNITS TAB
    if game.PlaceId == 8304191830 then
        local UnitSelectionTab = Window:MakeTab({
            Name = "Select Units",
            Icon = "rbxassetid://10779528646",
            PremiumOnly = false
        })
        local unitSection = UnitSelectionTab:AddSection({
            Name = "Unit Config"
        })

        --------------------------------------------------
        --------------- Select Units Tab -----------------
        --------------------------------------------------
        local Units = {}

        local function loadUnit()
            repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid")
                :FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
            --task.wait(2)
            table.clear(Units)
            for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.collection.grid.List.Outer
                .UnitFrames:GetChildren()) do
                if v.Name == "CollectionUnitFrame" then
                    repeat task.wait() until v:FindFirstChild("_uuid")
                    table.insert(Units, v.name.Text .. " #" .. v._uuid.Value)
                end
            end
            table.sort(Units)
        end

        loadUnit()

        local function Equip()
            if getgenv().init then
                game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
                for i = 1, 6 do
                    local unitinfo = getgenv().SelectedUnits["U" .. i]
                    warn(unitinfo)
                    if unitinfo ~= nil then
                        local unitinfo_ = unitinfo:split(" #")
                        task.wait(0.5)
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.equip_unit:InvokeServer(unitinfo_
                            [2])
                    end
                end
                updatejson()
            end
        end

        local drop1 = unitSection:AddDropdown({
            Name = "Unit 1",
            Callback = function(Value)
                if getgenv().init then
                    getgenv().SelectedUnits["U1"] = Value
                    Equip()
                end
            end,
            Default = getgenv().SelectedUnits["U1"],
            Options = Units

        })

        local drop2 = unitSection:AddDropdown({
            Name = "Unit 2",
            Default = getgenv().SelectedUnits["U2"],
            Options = Units,
            Callback = function(Value)
                if getgenv().init then
                    getgenv().SelectedUnits["U2"] = Value
                    Equip()
                end
            end
        })

        local drop3 = unitSection:AddDropdown({
            Name = "Unit 3",
            Default = getgenv().SelectedUnits["U3"],
            Options = Units,
            Callback = function(Value)
                if getgenv().init then
                    getgenv().SelectedUnits["U3"] = Value
                    Equip()
                end
            end
        })

        local drop4 = unitSection:AddDropdown({
            Name = "Unit 4",
            Default = getgenv().SelectedUnits["U4"],
            Options = Units,
            Callback = function(Value)
                if getgenv().init then
                    getgenv().SelectedUnits["U4"] = Value
                    Equip()
                end
            end
        })

        local drop5 = unitSection:AddDropdown({
            Name = "Unit 5",
            Default = getgenv().SelectedUnits["U5"],
            Options = Units,
            Callback = function(Value)
                if getgenv().init then
                    getgenv().SelectedUnits["U5"] = Value
                    Equip()
                end
            end
        })

        local drop6 = unitSection:AddDropdown({
            Name = "Unit 6",
            Default = getgenv().SelectedUnits["U6"],
            Options = Units,
            Callback = function(Value)
                if getgenv().init then
                    getgenv().SelectedUnits["U6"] = Value
                    Equip()
                end
            end
        })


        -- REFRESH UNIT LIST--
        local refresh = unitSection:AddButton({
            Name = "Refresh List",
            Callback = function()
                if getgenv().init then
                    -- to set dropdown text
                    drop1:Set("test")
                    drop2:Set("nil")
                    drop3:Set("nil")
                    drop4:Set("nil")
                    drop5:Set("nil")
                    drop6:Set("nil")

                    game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()

                    getgenv().SelectedUnits = {
                        U1 = nil,
                        U2 = nil,
                        U3 = nil,
                        U4 = nil,
                        U5 = nil,
                        U6 = nil
                    }

                    updatejson()
                end

            end
        })
    end

    -- AUTO FARM AND SELECT WORLD TABS
    local autofarmtab = Window:MakeTab({
        Name = "Auto Farm",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local selectWorld = Window:MakeTab({
        Name = "Select World",
        Icon = "rbxassetid://10779856311",
        PremiumOnly = false
    })

    --------------------------------------------------
    --------------- AutoFarm Tab ---------------------
    --------------------------------------------------
    -- auto farm toggle
    autofarmtab:AddToggle {
        Name = "Auto Farm",
        Default = getgenv().AutoFarm,
        Callback = function(state)
            if getgenv().init then
                getgenv().AutoFarm = state
                updatejson()
            end
        end
    }

    -- auto start toggle
    autofarmtab:AddToggle {
        Name = "Auto Start",
        Default = getgenv().autostart,
        Callback = function(state)
            if getgenv().init then
                getgenv().autostart = state
                updatejson()
            end
        end
    }


    -- auto abilities toggle
    autofarmtab:AddToggle {
        Name = "Auto Abilities",
        Default = getgenv().autoabilities,
        Callback = function(state)
            if getgenv().init then
                getgenv().autoabilities = state
                updatejson()
            end
        end
    }

    --auto upgrade units toggle
    autofarmtab:AddToggle {
        Name = "Auto Upgrade Units",
        Default = getgenv().autoupgrade,
        Callback = function(state)
            if getgenv().init then
                getgenv().autoupgrade = state
                updatejson()
            end
        end
    }

    -- auto sell toggle
    autofarmtab:AddToggle {
        Name = "Auto Sell Wave",
        Default = getgenv().autosell,
        Callback = function(state)
            if getgenv().init then
                getgenv().autosell = state
                updatejson()

                if getgenv().autosell == false then
                    getgenv().disableautofarm = false
                end
            end
        end
    }

    -- auto sell at x wave
    autofarmtab:AddTextbox {
        Name = "Enter wave number",
        Default = getgenv().sellatwave,
        TextDisappear = false,
        Callback = function(Value)
            if getgenv().init then
                getgenv().sellatwave = tonumber(Value)
                updatejson()
            end
        end
    }

    --------------------------------------------------
    --------------- Select World Tab ---------------------
    --------------------------------------------------
    local Worlds = { "Planet Namak", "Shiganshinu District", "Snowy Town", "Hidden Sand Village", "Marine's Ford",
        "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy", "Clover Kingdom", "Karakura Town",
        "Cape Canaveral" }
    getgenv().levels = { "nill" }
    --select world
    selectWorld:AddDropdown {
        Name = "Select World",
        Default = getgenv().world,
        Options = Worlds,
        Callback = function(world)
            if getgenv().init then
                getgenv().world = world
                updatejson()

                if world == "Planet Namak" then
                    table.clear(levels)
                    getgenv().levels = { "namek_infinite", "namek_level_1", "namek_level_2", "namek_level_3",
                        "namek_level_4", "namek_level_5", "namek_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Shiganshinu District" then
                    table.clear(levels)
                    getgenv().levels = { "aot_infinite", "aot_level_1", "aot_level_2", "aot_level_3", "aot_level_4",
                        "aot_level_5", "aot_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Snowy Town" then
                    table.clear(levels)
                    getgenv().levels = { "demonslayer_infinite", "demonslayer_level_1", "demonslayer_level_2",
                        "demonslayer_level_3", "demonslayer_level_4", "demonslayer_level_5",
                        "demonslayer_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Hidden Sand Village" then
                    table.clear(levels)
                    getgenv().levels = { "naruto_infinite", "naruto_level_1", "naruto_level_2", "naruto_level_3",
                        "naruto_level_4", "naruto_level_5", "naruto_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Marine's Ford" then
                    table.clear(levels)
                    getgenv().levels = { "marineford_infinite", "marineford_level_1", "marineford_level_2",
                        "marineford_level_3",
                        "marineford_level_4", "marineford_level_5", "marineford_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Ghoul City" then
                    table.clear(levels)
                    getgenv().levels = { "tokyoghoul_infinite", "tokyoghoul_level_1", "tokyoghoul_level_2",
                        "tokyoghoul_level_3",
                        "tokyoghoul_level_4", "tokyoghoul_level_5", "tokyoghoul_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Hollow World" then
                    table.clear(levels)
                    getgenv().levels = { "hueco_infinite", "hueco_level_1", "hueco_level_2", "hueco_level_3",
                        "hueco_level_4", "hueco_level_5", "hueco_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Ant Kingdom" then
                    table.clear(levels)
                    getgenv().levels = { "hxhant_infinite", "hxhant_level_1", "hxhant_level_2", "hxhant_level_3",
                        "hxhant_level_4", "hxhant_level_5", "hxhant_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Magic Town" then
                    table.clear(levels)
                    getgenv().levels = { "magnolia_infinite", "magnolia_level_1", "magnolia_level_2", "magnolia_level_3",
                        "magnolia_level_4", "magnolia_level_5", "magnolia_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Cursed Academy" then
                    table.clear(levels)
                    getgenv().levels = { "jjk_infinite", "jjk_level_1", "jjk_level_2", "jjk_level_3",
                        "jjk_level_4", "jjk_level_5", "jjk_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Clover Kingdom" then
                    table.clear(levels)
                    getgenv().levels = { "clover_infinite", "clover_legend_1", "clover_legend_2", "clover_level_1",
                        "clover_level_2",
                        "clover_level_3",
                        "clover_level_4", "clover_level_5", "clover_level_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Karakura Town" then
                    table.clear(levels)
                    getgenv().levels = { "bleach_legend_1", "bleach_legend_2", "bleach_legend_3", "bleach_legend_4",
                        "bleach_legend_5", "bleach_legend_6" }
                    leveldrop:Refresh(levels, true)

                elseif world == "Cape Canaveral" then
                    table.clear(levels)
                    getgenv().levels = { "jojo_infinite", "jojo_level_1", "jojo_level_2", "jojo_level_3", "jojo_level_4",
                        "jojo_level_5", "jojo_level_6" }
                    leveldrop:Refresh(levels, true)

                end
            end
        end
    }


    --select level
    getgenv().leveldrop = selectWorld:AddDropdown {
        Name = "Select Level",
        Default = getgenv().level,
        Options = getgenv().levels,
        Callback = function(level)
            if getgenv().init then
                getgenv().level = level
                updatejson()
            end

        end
    }



    -- select difficulty
    selectWorld:AddDropdown {
        Name = "Select Difficulty",
        Default = getgenv().difficulty,
        Options = { "Normal", "Hard" },
        Callback = function(difficulty)
            if getgenv().init then
                getgenv().difficulty = difficulty
                updatejson()
            end
        end
    }

    selectWorld:AddParagraph("Selected World Options",
        " World: " .. getgenv().world .. "\n Level: " .. getgenv().level .. "\n Difficulty: " .. getgenv().difficulty)



    --------------------------------------------------
    --------------- Webhook Tab ---------------------
    --------------------------------------------------
    local webhookTab = Window:MakeTab({
        Name = "Webhook",
        Icon = "rbxassetid://10780273788",
        PremiumOnly = false
    })

    local webhookLink
    if getgenv().weburl == "" then
        webhookLink = "Insert webhook link here!"
    else
        webhookLink = "Webhook is set"
    end

    -- get webhook url
    webhookTab:AddTextbox({
        Name = "Webhook Url",
        Default = webhookLink,
        TextDisappear = true,
        Callback = function(web_url)
            if getgenv().init then
                getgenv().weburl = web_url
                updatejson()
            end
        end
    })

    -- show current webhook link
    webhookTab:AddLabel(getgenv().weburl)

    -- test webhook button
    webhookTab:AddButton({
        Name = "Test Webhook!",
        Callback = function()
            if getgenv().init then
                webhook()
                buyItemWebhook("test", 0)
            end
        end
    })


    --end
    --------------------------------------------------
    --------------- Misc Tab ---------------------
    --------------------------------------------------
    local miscTab = Window:MakeTab({
        Name = "Misc",
        Icon = "rbxassetid://10780700286",
        PremiumOnly = false
    })

    getgenv().autoopenocean = false
    -- auto open orbs toggle
    miscTab:AddToggle({
        Name = "Auto Open Orbs",
        Default = getgenv().autoopenocean,
        Callback = function(bool)
            if getgenv().init then
                getgenv().autoopenocean = bool
                while getgenv().autoopenocean do
                    task.wait()
                    local args = { [1] = "capsule_jjk" }

                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_item:InvokeServer(unpack(args))
                end
            end
        end
    })


    -- auto farm castle toggle
    miscTab:AddToggle({
        Name = "Auto Farm Infinite Castle",
        Default = getgenv().farmCastle,
        Callback = function(bool)
            if getgenv().init then
                getgenv().farmCastle = bool
                updatejson()
            end
        end
    })

    -- auto farm daily infinite toggle
    miscTab:AddToggle({
        Name = "Auto Farm Daily Infinite",
        Default = getgenv().farmDailies,
        Callback = function(bool)
            if getgenv().init then
                getgenv().farmDailies = bool
                updatejson()
            end
        end
    })

    -- reset dailies toggle
    miscTab:AddButton({
        Name = "Reset Dailies",
        Callback = function()
            if getgenv().init then
                getgenv().namekDailyInfinite = false
                getgenv().aotDailyInfinite = false
                getgenv().demonslayerDailyInfinite = false
                getgenv().narutoDailyInfinite = false
                getgenv().marinefordDailyInfinite = false
                getgenv().tokyoGhoulDailyInfinite = false
                getgenv().bleachDailyInfinite = false
                getgenv().hxhDailyInfinite = false
                getgenv().fairytailDailyInfinite = false
                getgenv().jjkDailyInfinite = false
                getgenv().blackCloverInfinite = false
                getgenv().jojoDailyInfinite = false

                updatejson()
            end
        end
    })

    -- auto buy star remnant
    local traveling_merchant = game.workspace:FindFirstChild("travelling_merchant")
    miscTab:AddToggle({
        Name = "Buy Star Remnant",
        Default = getgenv().buyStarRemnant,
        Callback = function(bool)
            if getgenv().init then
                getgenv().buyStarRemnant = bool
                updatejson()

                if (traveling_merchant.is_open.value and getgenv().buyStarRemnant) then
                    local items = traveling_merchant.stand.items:GetChildren()
                    for i, v in pairs(items) do
                        local currItem = items[i]

                        if (currItem:FindFirstChild("star_remnant")) then
                            local starRemnant = currItem
                            local args = {
                                [1] = tostring(starRemnant)
                            }

                            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item
                                :InvokeServer(unpack(args))

                            local amount = game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames
                                ["star_remnant"].OwnedAmount.Text:split("x")[2]
                            buyItemWebhook("Star Remnant", amount)
                        end
                    end
                end
            end
        end
    })

    -- auto buy summon ticket
    miscTab:AddToggle({
        Name = "Buy Summon Ticket",
        Default = getgenv().buySummonTicket,
        Callback = function(bool)
            if getgenv().init then
                getgenv().buySummonTicket = bool
                updatejson()

                if (traveling_merchant.is_open.value and getgenv().buySummonTicket) then
                    local items = traveling_merchant.stand.items:GetChildren()

                    for i, v in pairs(items) do
                        local currItem = items[i]

                        if (currItem:FindFirstChild("star_neon")) then
                            local summonTicket = currItem
                            local args = {
                                [1] = tostring(summonTicket)
                            }

                            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item
                                :InvokeServer(unpack(args))

                            local amount = game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames
                                ["summon_ticket"].OwnedAmount.Text:split("x")[2]
                            buyItemWebhook("Summon Ticket", amount)
                        end
                    end
                end
            end
        end
    })


    -- auto accept event mission
    function eventMission()
        if getgenv().eventmission then

            local args = {
                [1] = "jojo_daily"
            }

            game:GetService("ReplicatedStorage").endpoints.client_to_server.accept_npc_quest:InvokeServer(unpack(args))

        end
    end

    miscTab:AddToggle({
        Name = "Accept Event Mission",
        Default = getgenv().eventmission,
        Callback = function(bool)
            if getgenv().init then
                getgenv().eventmission = bool
                updatejson()
                eventMission()

            end
        end
    })

    -- auto accept mission board missions
    function missionboard()
        if getgenv().missionboard then
            -- local missions = game:GetService("Players").LocalPlayer.PlayerGui.MissionUI.Main.Main.Main.Content.main.Scroll
            --     :GetDescendants()
            -- for i, v in pairs(missions) do
            --     if v.Name == "AcceptMission" then
            --         firesignal(v.Activated)
            --     end
            -- end
            local missions = game:GetService("Players").LocalPlayer.PlayerGui.MissionUI.Main.Main.Main.Content.main.Scroll
                :GetDescendants()
            local events = { "MouseButton1Click", "MouseButton1Down", "Activated" }
            for i, j in pairs(events) do
                for i, v in pairs(missions) do
                    if v.Name == "AcceptMission" then
                        for i, v in pairs(getconnections(v[j])) do
                            v:Fire()
                        end
                    end
                end
            end
        end
    end

    miscTab:AddToggle({
        Name = "Accept Mission Board Missions",
        Default = getgenv().missionboard,
        Callback = function(bool)
            if getgenv().init then
                getgenv().missionboard = bool
                updatejson()
                missionboard()
            end
        end
    })

    -- cursed womb
    miscTab:AddToggle({
        Name = "Cursed Womb",
        Default = getgenv().cursedWomb,
        Callback = function(bool)
            if getgenv().init then
                getgenv().cursedWomb = bool
                updatejson()
            end
        end
    })

    --------------------------------------------------
    --------------- Event Tab ---------------------
    --------------------------------------------------
    local eventTab = Window:MakeTab({
        Name = "Event",
        Icon = "rbxassetid://11410395919",
        PremiumOnly = false
    })

    eventTab:AddToggle({
        Name = "Auto Farm Event",
        Default = getgenv().farmEvent,
        Callback = function(bool)
            if getgenv().init then
                getgenv().farmEvent = bool
                updatejson()
            end
        end
    })

    -- auto portal
    eventTab:AddToggle({
        Name = "Auto Buy Contracts",
        Default = getgenv().autoPortal,
        Callback = function(bool)
            if getgenv().init then
                getgenv().autoPortal = bool
                updatejson()
            end
        end
    })

    -- contracts to buy
    eventTab:AddDropdown {
        Name = "Select Contracts To buy",
        Default = getgenv().contractToBuy or "",
        Options = { "Rank 0", "Rank 1", "Rank 2", "Rank 3", "Rank 4", "Rank 5" },
        Callback = function(value)
            if getgenv().init then
                getgenv().contractToBuy = value
                updatejson()
            end
        end
    }

    -- amount of max contract in inventory
    eventTab:AddSlider {
        Name = "Buy contracts if less than this amount",
        Min = 1,
        Max = 100,
        Default = getgenv().limitContracts or 1,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(Value)
            if getgenv().init then
                getgenv().limitContracts = Value
                updatejson()
            end
        end
    }

    eventTab:AddButton {
        Name = "Set Physical Team",
        Callback = function()
            if getgenv().init then
                getgenv().physicalTeam = getgenv().SelectedUnits
                updatejson()
            end
        end
    }

    eventTab:AddButton {
        Name = "Set Magic Team",
        Callback = function()
            if getgenv().init then
                getgenv().magicTeam = getgenv().SelectedUnits
                updatejson()
            end
        end
    }


    --------------------------------------------------
    --------------- Challenge Tab ---------------------
    --------------------------------------------------
    local chalTab = Window:MakeTab({
        Name = "Challenges",
        Icon = "rbxassetid://10878440329",
        PremiumOnly = false
    })


    -- auto challenge
    chalTab:AddToggle({
        Name = "Auto Farm Challenge",
        Default = getgenv().autochallenge,
        Callback = function(bool)
            if getgenv().init then
                getgenv().autochallenge = bool
                updatejson()
            end
        end
    })

    -- challenge rewards
    chalTab:AddDropdown {
        Name = "Select Challenge Rewards",
        Default = getgenv().challengerewards,
        Options = { "star_fruit_random", "star_fruit_epic", "star_remnant", "gems", "gold" },
        Callback = function(value)
            if getgenv().init then
                if not table.find(getgenv().challengerewards, value) then
                    table.insert(getgenv().challengerewards, value)
                end

                updatejson()
            end
        end
    }

    chalTab:AddButton {
        Name = "Reset Challenge Rewards",
        Callback = function()
            getgenv().challengerewards = {}
            updatejson()
        end
    }

    -- select worlds
    chalTab:AddDropdown {
        Name = "Select Challenge Worlds",
        Default = "",
        Options = { "Planet Namak", "Shiganshinu District", "Snowy Town", "Hidden Sand Village", "Marine's Ford",
            "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy", "Clover Kingdom" },
        Callback = function(value)
            if getgenv().init then
                if not table.find(getgenv().challengeWorlds, value) then
                    table.insert(getgenv().challengeWorlds, value)
                end

                updatejson()
            end
        end
    }

    chalTab:AddButton {
        Name = "Reset Challenge Worlds",
        Callback = function()
            getgenv().challengeWorlds = {}
            updatejson()
        end
    }

    -- select difficulty
    chalTab:AddDropdown {
        Name = "Select Challenge Difficulties",
        Default = "",
        Options = { "fast_enemies", "tank_enemies", "short_range", "double_cost", "regen_enemies", "shield_enemies" },
        Callback = function(value)
            if getgenv().init then
                if not table.find(getgenv().challengeDifficulty, value) then
                    table.insert(getgenv().challengeDifficulty, value)
                end

                updatejson()
            end
        end
    }

    chalTab:AddButton {
        Name = "Reset Challenge Difficulties",
        Callback = function()
            getgenv().challengeDifficulty = {}
            updatejson()
        end
    }

    local selectedRewards = ""
    local selectedWorlds = ""
    local selectedDifficulties = ""
    local function updatedChallengeSettings()
        selectedRewards = ""
        selectedWorlds = ""
        selectedDifficulties = ""
        for i, v in pairs(getgenv().challengerewards) do
            selectedRewards = selectedRewards .. v .. "\n"
        end

        for i, v in pairs(getgenv().challengeWorlds) do
            selectedWorlds = selectedWorlds .. v .. "\n"
        end

        for i, v in pairs(getgenv().challengeDifficulty) do
            selectedDifficulties = selectedDifficulties .. v .. "\n"
        end
    end

    updatedChallengeSettings()
    local rewardParagraph = chalTab:AddParagraph("Challenge Settings",
        "\nSelected Rewards\n" ..
        selectedRewards .. "\nSelected Worlds\n" .. selectedWorlds .. "\nSelected Difficulties\n" .. selectedDifficulties)

    chalTab:AddButton {
        Name = "Refresh display",
        Callback = function()
            updatedChallengeSettings()
            rewardParagraph:Set("\nSelected Rewards\n" ..
                selectedRewards ..
                "\nSelected Worlds\n" .. selectedWorlds .. "\nSelected Difficulties\n" .. selectedDifficulties)
        end
    }


    --------------------------------------------------
    --------------- Max Unit Upgrade Tab ---------------------
    --------------------------------------------------
    local unitUpgradeTab = Window:MakeTab({
        Name = "Unit Upgrades",
        Icon = "rbxassetid://10779528646",
        PremiumOnly = false
    })

    unitUpgradeTab:AddTextbox({
        Name = "Max Upgrade Unit 1",
        Default = getgenv().maxUpgrades.U1,
        TextDisappear = false,
        Callback = function(Value)
            if getgenv().init then
                getgenv().maxUpgrades.U1 = tonumber(Value)
                updatejson()
            end
        end
    })

    unitUpgradeTab:AddTextbox({
        Name = "Max Upgrade Unit 2",
        Default = getgenv().maxUpgrades.U2,
        TextDisappear = false,
        Callback = function(Value)
            if getgenv().init then
                getgenv().maxUpgrades.U2 = tonumber(Value)
                updatejson()
            end
        end
    })

    unitUpgradeTab:AddTextbox({
        Name = "Max Upgrade Unit 3",
        Default = getgenv().maxUpgrades.U3,
        TextDisappear = false,
        Callback = function(Value)
            if getgenv().init then
                getgenv().maxUpgrades.U3 = tonumber(Value)
                updatejson()
            end
        end
    })

    unitUpgradeTab:AddTextbox({
        Name = "Max Upgrade Unit 4",
        Default = getgenv().maxUpgrades.U4,
        TextDisappear = false,
        Callback = function(Value)
            if getgenv().init then
                getgenv().maxUpgrades.U4 = tonumber(Value)
                updatejson()
            end
        end
    })

    unitUpgradeTab:AddTextbox({
        Name = "Max Upgrade Unit 5",
        Default = getgenv().maxUpgrades.U5,
        TextDisappear = false,
        Callback = function(Value)
            if getgenv().init then
                getgenv().maxUpgrades.U5 = tonumber(Value)
                updatejson()
            end
        end
    })

    unitUpgradeTab:AddTextbox({
        Name = "Max Upgrade Unit 6",
        Default = getgenv().maxUpgrades.U6,
        TextDisappear = false,
        Callback = function(Value)
            if getgenv().init then
                getgenv().maxUpgrades.U6 = tonumber(Value)
                updatejson()
            end
        end
    })

    -- if in a match, show unit position tab
    if game.PlaceId ~= 8304191830 then
        game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false


        UnitSelectionTab = Window:MakeTab({
            Name = "Select Unit Position",
            Icon = "rbxassetid://10779528646",
            PremiumOnly = false
        })



        -- mouse click get position
        function MouseClick(UnitPos)
            local connection
            connection = UserInputService.InputBegan:Connect(
                function(input, gameProcessed)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        connection:Disconnect()
                        local a = Instance.new("Part", game.Workspace)
                        a.Size = Vector3.new(1, 1, 1)
                        a.Material = Enum.Material.Neon
                        a.Position = mouse.hit.p
                        task.wait()
                        a.Anchored = true
                        OrionLib:MakeNotification({
                            Name = "Spawn Unit Position:",
                            Content = tostring(a.Position),
                            Time = 5
                        })
                        a.CanCollide = false
                        for i = 0, 1, 0.1 do
                            a.Transparency = i
                            task.wait()
                        end
                        a:Destroy()

                        if (getgenv().world == "Planet Namak") then
                            namekSpawnPos[UnitPos]["x"] = a.Position.X
                            namekSpawnPos[UnitPos]["y"] = a.Position.Y
                            namekSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().namekSpawnPos

                        elseif (getgenv().world == "Shiganshinu District") then
                            aotSpawnPos[UnitPos]["x"] = a.Position.X
                            aotSpawnPos[UnitPos]["y"] = a.Position.Y
                            aotSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().aotSpawnPos

                        elseif (getgenv().world == "Snowy Town") then
                            demonslayerSpawnPos[UnitPos]["x"] = a.Position.X
                            demonslayerSpawnPos[UnitPos]["y"] = a.Position.Y
                            demonslayerSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().demonslayerSpawnPos

                        elseif (getgenv().world == "Hidden Sand Village") then
                            narutoSpawnPos[UnitPos]["x"] = a.Position.X
                            narutoSpawnPos[UnitPos]["y"] = a.Position.Y
                            narutoSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().narutoSpawnPos

                        elseif (getgenv().world == "Marine's Ford") then
                            marinefordSpawnPos[UnitPos]["x"] = a.Position.X
                            marinefordSpawnPos[UnitPos]["y"] = a.Position.Y
                            marinefordSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().marinefordSpawnPos

                        elseif (getgenv().world == "Ghoul City") then
                            tokyoGhoulSpawnPos[UnitPos]["x"] = a.Position.X
                            tokyoGhoulSpawnPos[UnitPos]["y"] = a.Position.Y
                            tokyoGhoulSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().tokyoGhoulSpawnPos

                        elseif (getgenv().world == "Hollow World") then
                            bleachSpawnPos[UnitPos]["x"] = a.Position.X
                            bleachSpawnPos[UnitPos]["y"] = a.Position.Y
                            bleachSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().bleachSpawnPos

                        elseif (getgenv().world == "Ant Kingdom") then
                            hxhSpawnPos[UnitPos]["x"] = a.Position.X
                            hxhSpawnPos[UnitPos]["y"] = a.Position.Y
                            hxhSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().hxhSpawnPos

                        elseif (getgenv().world == "Magic Town") then
                            fairytailSpawnPos[UnitPos]["x"] = a.Position.X
                            fairytailSpawnPos[UnitPos]["y"] = a.Position.Y
                            fairytailSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().fairytailSpawnPos

                        elseif (getgenv().world == "Cursed Academy") then
                            jjkSpawnPos[UnitPos]["x"] = a.Position.X
                            jjkSpawnPos[UnitPos]["y"] = a.Position.Y
                            jjkSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().jjkSpawnPos

                        elseif (getgenv().world == "Devil City") then
                            eventSpawnPos[UnitPos]["x"] = a.Position.X
                            eventSpawnPos[UnitPos]["y"] = a.Position.Y
                            eventSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().eventSpawnPos

                        elseif (getgenv().world == "Clover Kingdom") then
                            blackCloverSpawnPos[UnitPos]["x"] = a.Position.X
                            blackCloverSpawnPos[UnitPos]["y"] = a.Position.Y
                            blackCloverSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().blackCloverSpawnPos

                        elseif (getgenv().world == "Karakura Town") then
                            karakuraTownSpawnPos[UnitPos]["x"] = a.Position.X
                            karakuraTownSpawnPos[UnitPos]["y"] = a.Position.Y
                            karakuraTownSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().karakuraTownSpawnPos

                        elseif (getgenv().world == "Cape Canaveral") then
                            jojoSpawnPos[UnitPos]["x"] = a.Position.X
                            jojoSpawnPos[UnitPos]["y"] = a.Position.Y
                            jojoSpawnPos[UnitPos]["z"] = a.Position.Z
                            getgenv().SpawnUnitPos = getgenv().jojoSpawnPos
                        end

                        updatejson()
                    end
                end
            )
        end

        -- SET POSITION BUTTONS--
        UnitSelectionTab:AddButton({
            Name = "Set Unit 1 Position",
            Callback = function()
                if getgenv().init then
                    OrionLib:MakeNotification({
                        Name = "Set Unit 1 Position",
                        Content = "Click on the floor to set unit position",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                    MouseClick("UP1")
                end
            end
        })

        UnitSelectionTab:AddButton({
            Name = "Set Unit 2 Position",
            Callback = function()
                if getgenv().init then
                    OrionLib:MakeNotification({
                        Name = "Set Unit 2 Position",
                        Content = "Click on the floor to set unit position",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                    MouseClick("UP2")
                end
            end
        })

        UnitSelectionTab:AddButton({
            Name = "Set Unit 3 Position",
            Callback = function()
                if getgenv().init then
                    OrionLib:MakeNotification({
                        Name = "Set Unit 3 Position",
                        Content = "Click on the floor to set unit position",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                    MouseClick("UP3")
                end
            end
        })

        UnitSelectionTab:AddButton({
            Name = "Set Unit 4 Position",
            Callback = function()
                if getgenv().init then
                    OrionLib:MakeNotification({
                        Name = "Set Unit 4 Position",
                        Content = "Click on the floor to set unit position",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                    MouseClick("UP4")
                end
            end
        })

        UnitSelectionTab:AddButton({
            Name = "Set Unit 5 Position",
            Callback = function()
                if getgenv().init then
                    OrionLib:MakeNotification({
                        Name = "Set Unit 5 Position",
                        Content = "Click on the floor to set unit position",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                    MouseClick("UP5")
                end
            end
        })

        UnitSelectionTab:AddButton({
            Name = "Set Unit 6 Position",
            Callback = function()
                if getgenv().init then
                    OrionLib:MakeNotification({
                        Name = "Set Unit 6 Position",
                        Content = "Click on the floor to set unit position",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                    MouseClick("UP6")
                end
            end
        })


    end

    --------------------------------------------------
    --------------- Update Tab ---------------------
    --------------------------------------------------
    local updateTab = Window:MakeTab({
        Name = "Update Log",
        Icon = "rbxassetid://10878446451",
        PremiumOnly = false
    })

    -- update log
    updateTab:AddParagraph(
        "Update Log",
        updateNotes
    )

    updateTab:AddButton({
        Name = "Rejoin",
        Callback = function()
            if getgenv().init then
                game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
            end
        end
    })

    OrionLib:Init()
    getgenv().init = true
    OrionLib:MakeNotification({
        Name = "Enjoy the script!",
        Content = "Check the Update Log for recent updates.",
        Time = 5
    })
end

if isfile(savefilename) then
    jsonFile()
else
    local xdata = {
        -- unitname = "name",
        -- unitid = "id",
        autoabilities = false,
        buyStarRemnant = false,
        buySummonTicket = false,
        namekDailyInfinite = false,
        aotDailyInfinite = false,
        narutoDailyInfinite = false,
        demonslayerDailyInfinite = false,
        marinefordDailyInfinite = false,
        tokyoGhoulDailyInfinite = false,
        bleachDailyInfinite = false,
        hxhDailyInfinite = false,
        fairytailDailyInfinite = false,
        jjkDailyInfinite = false,
        blackCloverInfinite = false,
        jojoDailyInfinite = false,
        autochallenge = false,
        missionboard = false,
        eventmission = false,
        farmEvent = false,
        autoPortal = false,
        ignoreTiers = {},
        maxUpgrades = {},
        challengerewards = {},
        challengeDifficulty = {},
        challengeWorlds = {},
        eventWorlds = {},
        cursedWomb = false,
        webhook = "",
        sellatwave = 0,
        autosell = false,
        autofarm = false,
        autostart = false,
        autoupgrade = false,
        tier = " ",
        difficulty = "Normal",
        world = "nil",
        level = "nil",
        door = "nil",
        xspawnUnitPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },
        xjojoSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },
        xEventSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },


        xjjkSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xfairytailSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xblackCloverSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xtokyoGhoulSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xkarakuraTownSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xnamekSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xaotSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xdemonslayerSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xnarutoSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xmarinefordSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xbleachSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xhxhSpawnPos = {
            UP1 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP2 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP3 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP4 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP5 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            },

            UP6 = {
                x = -2952.81689453125,
                y = 91.80620574951172,
                z = -707.9673461914062
            }
        },

        xselectedUnits = {
            U1 = nil,
            U2 = nil,
            U3 = nil,
            U4 = nil,
            U5 = nil,
            U6 = nil
        }

    }
    local json = HttpService:JSONEncode(xdata)
    writefile(savefilename, json)

    jsonFile()
end

getgenv().enableupgrading = false
local exclude = { "Auranex", "Pikopher", "Vuixt" }
-- AUTO FARM --
coroutine.resume(coroutine.create(function()
    while task.wait() do

        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        if getgenv().AutoFarm and not getgenv().disableautofarm then
            if game.PlaceId ~= 8304191830 then
                -- leave if more than yourself and friends in the lobby
                table.remove(exclude, table.find(exclude, game:GetService("Players").LocalPlayer.Name))
                local count = 1
                for i, v in pairs(game:GetService("Players"):GetChildren()) do
                    if table.find(exclude, tostring(v)) then
                        count = count + 1
                    end
                end
                if #game:GetService("Players"):GetChildren() > count then
                    repeat task.wait() until game:GetService("TeleportService"):Teleport(8304191830,
                        game.Players.LocalPlayer)
                else
                    --getgenv().placementCount = { 0, 0, 0, 0, 0, 0 }
                    x = 4
                    y = 3
                    z = 4

                    for i = _wave.Value, getgenv().sellatwave do
                        local currentWave = _wave.Value
                        for i = 1, 6 do
                            local unitinfo = getgenv().SelectedUnits["U" .. i]
                            if unitinfo ~= nil then
                                local unitinfo_ = unitinfo:split(" #")
                                local pos = getgenv().SpawnUnitPos["UP" .. i]

                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:
                                    InvokeServer(unpack(args))

                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"], pos["z"]),
                                        Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:
                                    InvokeServer(unpack(args))

                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"] + z),
                                        Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:
                                    InvokeServer(unpack(args))

                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"], pos["z"] + z),
                                        Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:
                                    InvokeServer(unpack(args))

                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"], pos["z"] + z),
                                        Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:
                                    InvokeServer(unpack(args))

                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"], pos["z"]),
                                        Vector3.new(0, 0, -1))
                                }
                            end
                            task.wait(0.3)

                        end
                        getgenv().enableupgrading = true
                        repeat task.wait() until _wave.Value ~= currentWave

                    end
                end
            end
        end

    end
end))

local function setSpawnPos()
    if (getgenv().world == "Planet Namak") then
        getgenv().SpawnUnitPos = getgenv().namekSpawnPos

    elseif (getgenv().world == "Shiganshinu District") then
        getgenv().SpawnUnitPos = getgenv().aotSpawnPos

    elseif (getgenv().world == "Snowy Town") then
        getgenv().SpawnUnitPos = getgenv().demonslayerSpawnPos

    elseif (getgenv().world == "Hidden Sand Village") then
        getgenv().SpawnUnitPos = getgenv().narutoSpawnPos

    elseif (getgenv().world == "Marine's Ford") then
        getgenv().SpawnUnitPos = getgenv().marinefordSpawnPos

    elseif (getgenv().world == "Ghoul City") then
        getgenv().SpawnUnitPos = getgenv().tokyoGhoulSpawnPos

    elseif (getgenv().world == "Hollow World") then
        getgenv().SpawnUnitPos = getgenv().bleachSpawnPos

    elseif (getgenv().world == "Ant Kingdom") then
        getgenv().SpawnUnitPos = getgenv().hxhSpawnPos

    elseif (getgenv().world == "Magic Town") then
        getgenv().SpawnUnitPos = getgenv().fairytailSpawnPos

    elseif (getgenv().world == "Cursed Academy") then
        getgenv().SpawnUnitPos = getgenv().jjkSpawnPos

    elseif (getgenv().world == "Devil City") then
        getgenv().SpawnUnitPos = getgenv().eventSpawnPos

    elseif (getgenv().world == "Clover Kingdom") then
        getgenv().SpawnUnitPos = getgenv().blackCloverSpawnPos

    elseif (getgenv().world == "Karakura Town") then
        getgenv().SpawnUnitPos = getgenv().karakuraTownSpawnPos

    elseif (getgenv().world == "Cape Canaveral") then
        getgenv().SpawnUnitPos = getgenv().jojoSpawnPos

    end


    updatejson()
end

local function setCastleWorldSpawnPos()
    local castleWorld = game:GetService("Players").LocalPlayer.PlayerGui.InfiniteTowerUI.LevelSelect.InfoFrame
        .Stats.World.Text
    getgenv().world = castleWorld
    if (castleWorld == "Planet Namak") then
        getgenv().SpawnUnitPos = getgenv().namekSpawnPos

    elseif (castleWorld == "Shiganshinu District") then
        getgenv().SpawnUnitPos = getgenv().aotSpawnPos

    elseif (castleWorld == "Snowy Town") then
        getgenv().SpawnUnitPos = getgenv().demonslayerSpawnPos

    elseif (castleWorld == "Hidden Sand Village") then
        getgenv().SpawnUnitPos = getgenv().narutoSpawnPos

    elseif (castleWorld == "Marine's Ford") then
        getgenv().SpawnUnitPos = getgenv().marinefordSpawnPos

    elseif (castleWorld == "Ghoul City") then
        getgenv().SpawnUnitPos = getgenv().tokyoGhoulSpawnPos

    elseif (castleWorld == "Hollow World") then
        getgenv().SpawnUnitPos = getgenv().bleachSpawnPos

    elseif (castleWorld == "Ant Kingdom") then
        getgenv().SpawnUnitPos = getgenv().hxhSpawnPos

    elseif (castleWorld == "Magic Town") then
        getgenv().SpawnUnitPos = getgenv().fairytailSpawnPos

    elseif (castleWorld == "Cursed Academy") then
        getgenv().SpawnUnitPos = getgenv().jjkSpawnPos

    elseif (castleWorld == "Clover Kingdom") then
        getgenv().SpawnUnitPos = getgenv().blackCloverSpawnPos

    elseif (castleWorld == "Cape Canaveral") then
        getgenv().SpawnUnitPos = getgenv().jojoSpawnPos


    end

    updatejson()
end

local function getWorld(level)
    local namekLevels = { "namek_level_1", "namek_level_2", "namek_level_3", "namek_level_4", "namek_level_5",
        "namek_level_6" }
    local aotLevels = { "aot_level_1", "aot_level_2", "aot_level_3", "aot_level_4", "aot_level_5", "aot_level_6" }
    local demonslayerLevels = { "demonslayer_level_1", "demonslayer_level_2", "demonslayer_level_3",
        "demonslayer_level_4", "demonslayer_level_5", "demonslayer_level_6" }
    local narutoLevels = { "naruto_level_1", "naruto_level_2", "naruto_level_3", "naruto_level_4", "naruto_level_5",
        "naruto_level_6" }
    local marinefordLevels = { "marineford_level_1", "marineford_level_2", "marineford_level_3", "marineford_level_4",
        "marineford_level_5", "marineford_level_6" }
    local tokyoGhoulLevels = { "tokyoghoul_level_1", "tokyoghoul_level_2", "tokyoghoul_level_3", "tokyoghoul_level_4",
        "tokyoghoul_level_5", "tokyoghoul_level_6" }
    local bleachLevels = { "hueco_level_1", "hueco_level_2", "hueco_level_3", "hueco_level_4", "hueco_level_5",
        "hueco_level_6" }
    local hxhLevels = { "hxhant_level_1", "hxhant_level_2", "hxhant_level_3", "hxhant_level_4", "hxhant_level_5",
        "hxhant_level_6" }
    local fairytailLevels = { "magnolia_level_1", "magnolia_level_2", "magnolia_level_3", "magnolia_level_4",
        "magnolia_level_5", "magnolia_level_6" }
    local jjkLevels = { "jjk_level_1", "jjk_level_2", "jjk_level_3", "jjk_level_4", "jjk_level_5", "jjk_level_6" }
    local blackCloverLevels = { "clover_level_1", "clover_level_2", "clover_level_3",
        "clover_level_4", "clover_level_5", "clover_level_6" }
    local jojoLevels = { "jojo_level_1", "jojo_level_2", "jojo_level_3", "jojo_level_4",
        "jojo_level_5", "jojo_level_6" }

    if table.find(namekLevels, level) then
        getgenv().world = "Planet Namak"
    end

    if table.find(aotLevels, level) then
        getgenv().world = "Shiganshinu District"
    end

    if table.find(demonslayerLevels, level) then
        getgenv().world = "Snowy Town"
    end

    if table.find(narutoLevels, level) then
        getgenv().world = "Hidden Sand Village"
    end

    if table.find(marinefordLevels, level) then
        getgenv().world = "Marine's Ford"
    end

    if table.find(tokyoGhoulLevels, level) then
        getgenv().world = "Ghoul City"
    end

    if table.find(bleachLevels, level) then
        getgenv().world = "Hollow World"
    end

    if table.find(hxhLevels, level) then
        getgenv().world = "Ant Kingdom"
    end

    if table.find(fairytailLevels, level) then
        getgenv().world = "Magic Town"
    end

    if table.find(jjkLevels, level) then
        getgenv().world = "Cursed Academy"
    end

    if table.find(blackCloverLevels, level) then
        getgenv().world = "Clover Kingdom"
    end

    if table.find(jojoLevels, level) then
        getgenv().world = "Cape Canaveral"
    end
end

local function getWorldwithInfinite(level)
    local namekLevels = { "namek_infinite", "namek_level_1", "namek_level_2", "namek_level_3", "namek_level_4",
        "namek_level_5", "namek_level_6" }
    local aotLevels = { "aot_infinite", "aot_level_1", "aot_level_2", "aot_level_3", "aot_level_4", "aot_level_5",
        "aot_level_6" }
    local demonslayerLevels = { "demonslayer_infinite", "demonslayer_level_1", "demonslayer_level_2",
        "demonslayer_level_3", "demonslayer_level_4", "demonslayer_level_5", "demonslayer_level_6" }
    local narutoLevels = { "naruto_infinite", "naruto_level_1", "naruto_level_2", "naruto_level_3", "naruto_level_4",
        "naruto_level_5", "naruto_level_6" }
    local marinefordLevels = { "marineford_infinite", "marineford_level_1", "marineford_level_2", "marineford_level_3",
        "marineford_level_4", "marineford_level_5", "marineford_level_6" }
    local tokyoGhoulLevels = { "tokyoghoul_infinite", "tokyoghoul_level_1", "tokyoghoul_level_2", "tokyoghoul_level_3",
        "tokyoghoul_level_4", "tokyoghoul_level_5", "tokyoghoul_level_6" }
    local bleachLevels = { "hueco_infinite", "hueco_level_1", "hueco_level_2", "hueco_level_3", "hueco_level_4",
        "hueco_level_5", "hueco_level_6" }
    local hxhLevels = { "hxhant_infinite", "hxhant_level_1", "hxhant_level_2", "hxhant_level_3", "hxhant_level_4",
        "hxhant_level_5", "hxhant_level_6" }
    local fairytailLevels = { "magnolia_infinite", "magnolia_level_1", "magnolia_level_2", "magnolia_level_3",
        "magnolia_level_4", "magnolia_level_5", "magnolia_level_6" }
    local jjkLevels = { "jjk_infinite", "jjk_level_1", "jjk_level_2", "jjk_level_3",
        "jjk_level_4", "jjk_level_5", "jjk_level_6" }
    local blackCloverLevels = { "clover_infinite", "clover_level_1", "clover_level_2", "clover_level_3",
        "clover_level_4", "clover_level_5", "clover_level_6" }
    local karakuraTownLevels = { "bleach_legend_1", "bleach_legend_2", "bleach_legend_3", "bleach_legend_4",
        "bleach_legend_5", "bleach_legend_6" }
    local jojoLevels = { "jojo_infinite", "jojo_level_1", "jojo_level_2", "jojo_level_3", "jojo_level_4",
        "jojo_level_5", "jojo_level_6" }

    if table.find(namekLevels, level) then
        getgenv().world = "Planet Namak"
    end

    if table.find(aotLevels, level) then
        getgenv().world = "Shiganshinu District"
    end

    if table.find(demonslayerLevels, level) then
        getgenv().world = "Snowy Town"
    end

    if table.find(narutoLevels, level) then
        getgenv().world = "Hidden Sand Village"
    end

    if table.find(marinefordLevels, level) then
        getgenv().world = "Marine's Ford"
    end

    if table.find(tokyoGhoulLevels, level) then
        getgenv().world = "Ghoul City"
    end

    if table.find(bleachLevels, level) then
        getgenv().world = "Hollow World"
    end

    if table.find(hxhLevels, level) then
        getgenv().world = "Ant Kingdom"
    end

    if table.find(fairytailLevels, level) then
        getgenv().world = "Magic Town"
    end

    if table.find(jjkLevels, level) then
        getgenv().world = "Cursed Academy"
    end

    if table.find(blackCloverLevels, level) then
        getgenv().world = "Clover Kingdom"
    end

    if table.find(karakuraTownLevels, level) then
        getgenv().world = "Karakura Town"
    end

    if table.find(jojoLevels, level) then
        getgenv().world = "Cape Canaveral"
    end
end

function questClaim()
    local quests = game:GetService("Players").LocalPlayer.PlayerGui.QuestsUI.Main.Main.Main.Content:GetDescendants()
    -- for i, v in pairs(quests) do
    --     if v.Name == "ClaimQuest" then
    --         firesignal(v.Activated)
    --     end
    -- end
    local events = { "MouseButton1Click", "MouseButton1Down", "Activated" }
    for i, j in pairs(events) do
        for i, v in pairs(quests) do
            if v.Name == "ClaimQuest" then
                for i, v in pairs(getconnections(v[j])) do
                    v:Fire()
                end
            end
        end
    end
end

-- getgenv().foundPortal = false
-- getgenv().uuid = nil
-- local looped = false

local function buyContract()
    local contract = ""
    if getgenv().contractToBuy == "Rank 0" then
        contract = "csm_contract_0"
    elseif getgenv().contractToBuy == "Rank 1" then
        contract = "csm_contract_1"
    elseif getgenv().contractToBuy == "Rank 2" then
        contract = "csm_contract_2"
    elseif getgenv().contractToBuy == "Rank 3" then
        contract = "csm_contract_3"
    elseif getgenv().contractToBuy == "Rank 4" then
        contract = "csm_contract_4"
    elseif getgenv().contractToBuy == "Rank 5" then
        contract = "csm_contract_5"
    end

    -- check the amount of contracts player owns is less than the limit they set
    local items = game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames:GetChildren()
    local total = 0
    for i, v in pairs(items) do
        if v.Name == "portal_csm" or v.Name == "portal_csm2" or v.Name == "portal_csm3" then
            total = total + 1
        end
    end

    local args = {
        [1] = contract
    }

    print(total .. " " .. contract)
    print(getgenv().limitContracts)
    if total < getgenv().limitContracts then
        game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_csmportal_shop_item:InvokeServer(unpack(args))
    end

end

local function Equip()
    if getgenv().init then
        game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
        for i = 1, 6 do
            local unitinfo = getgenv().SelectedUnits["U" .. i]
            warn(unitinfo)
            if unitinfo ~= nil then
                local unitinfo_ = unitinfo:split(" #")
                task.wait(0.5)
                game:GetService("ReplicatedStorage").endpoints.client_to_server.equip_unit:InvokeServer(unitinfo_
                    [2])
            end
        end
        updatejson()
    end
end

local equipped = false
-- AUTO START --
coroutine.resume(coroutine.create(function()
    while task.wait() do
        if getgenv().autostart and getgenv().AutoFarm then
            if game.PlaceId == 8304191830 then

                -- if auto challenge is on then find the world to set the positions,

                getgenv().isChallengeCleared = false
                getgenv().canDoChallenge = false
                for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
                    if v.Name == "ChallengeCleared" and v.Visible then
                        getgenv().isChallengeCleared = true
                        break
                    end
                end

                if getgenv().autochallenge and not getgenv().isChallengeCleared then
                    for i, v in pairs(game:GetService("Workspace")["_CHALLENGES"].Challenges:GetDescendants()) do
                        if v.Name == "Players" and #v:GetChildren() == 0 then
                            if table.find(getgenv().challengerewards, v.Parent.Reward.Value) and
                                not table.find(getgenv().challengeDifficulty, v.Parent.Challenge.Value) then
                                getgenv().door = v.Parent.Name
                                local currentLevel = v.Parent.Level.Value
                                getWorld(currentLevel)

                                if table.find(getgenv().challengeWorlds, tostring(getgenv().world)) then
                                    getgenv().canDoChallenge = true
                                end
                                break
                            end
                        end
                    end
                end

                setSpawnPos()


                local traveling_merchant = game.workspace:FindFirstChild("travelling_merchant")
                if (traveling_merchant.is_open.value and getgenv().buyStarRemnant) then
                    local items = traveling_merchant.stand.items:GetChildren()
                    for i, v in pairs(items) do
                        local currItem = items[i]

                        if (currItem:FindFirstChild("star_remnant")) then
                            local starRemnant = currItem
                            local args = {
                                [1] = tostring(starRemnant)
                            }

                            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item
                                :InvokeServer(unpack(args))

                            local amount = game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames
                                ["star_remnant"].OwnedAmount.Text:split("x")[2]
                            buyItemWebhook("Star Remnant", amount)
                        end
                    end
                end

                if (traveling_merchant.is_open.value and getgenv().buySummonTicket) then
                    local items = traveling_merchant.stand.items:GetChildren()

                    for i, v in pairs(items) do
                        local currItem = items[i]

                        if (currItem:FindFirstChild("star_neon")) then
                            local summonTicket = currItem
                            local args = {
                                [1] = tostring(summonTicket)
                            }

                            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item
                                :InvokeServer(unpack(args))

                            local amount = game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames
                                ["summon_ticket"].OwnedAmount.Text:split("x")[2]
                            buyItemWebhook("Summon Ticket", amount)
                        end
                    end
                end

                -- take event misison
                eventMission()

                --take mission board mission
                missionboard()

                questClaim()

                if getgenv().farmEvent then
                    if getgenv().autoPortal then
                        -- buy contract
                        buyContract()

                        -- complete contract
                        getgenv().world = "Devil City"
                        setSpawnPos()
                        -- find contract id
                        local contract = ""
                        if getgenv().contractToBuy == "Rank 0" or getgenv().contractToBuy == "Rank 1" then
                            contract = "portal_csm"
                        elseif getgenv().contractToBuy == "Rank 2" or getgenv().contractToBuy == "Rank 3" then
                            contract = "portal_csm2"
                        elseif getgenv().contractToBuy == "Rank 4" or getgenv().contractToBuy == "Rank 5" then
                            contract = "portal_csm3"
                        end
                        print(contract, " ", typeof(contract))
                        local id = game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames:
                            FindFirstChild(contract)._uuid_or_id.Value
                        print(id)
                        local args = {
                            [1] = id,
                            [2] = {
                                ["friends_only"] = true
                            }
                        }

                        repeat
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))
                        until game:GetService("Players").LocalPlayer.AlreadyInLobby.Value

                        -- start contract
                        local lobby = ""

                        -- find lobby
                        for i, v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetChildren()) do
                            if v.Owner.Value == game.Players.LocalPlayer then
                                lobby = v.Name
                            end
                        end
                        local args = {
                            [1] = lobby
                        }

                        print(contract, " ", id, " ", lobby)

                        -- change team based on resistance
                        if equipped == false then
                            repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.LevelSelectGui.Starting
                                .Visible
                            local shield = game:GetService("Players").LocalPlayer.PlayerGui.LevelSelectGui:WaitForChild("Starting")
                                .Main.Wrapper
                                .Container.InfoFrame["_StrongWeakAgainst"].PrimaryFrame.ResistanceFrame.shield

                            if shield.ImageColor3 == Color3.fromRGB(255, 0, 0) then
                                getgenv().SelectedUnits = getgenv().magicTeam
                            else
                                getgenv().SelectedUnits = getgenv().physicalTeam
                            end

                            updatejson()
                            Equip()
                            print("equipped")
                            equipped = true
                        end



                        repeat
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:
                                InvokeServer(unpack(args))
                        until game:GetService("Players").LocalPlayer.TeleportingLock.Value


                    end
                else
                    if getgenv().cursedWomb then
                        -- check if less than 20 fingers
                        if game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames:
                            FindFirstChild("sukuna_finger"):FindFirstChild("OwnedAmount").Text ~= "x20" then
                            -- check if no one else is in the lobby, if so then leave
                            if #game:GetService("Workspace")["_DUNGEONS"].Lobbies["_lobbytemplate_event229"].Players:
                                GetChildren() > 1 then
                                repeat task.wait() until game:GetService("TeleportService"):Teleport(8304191830,
                                    game.Players.LocalPlayer)
                            end

                            getgenv().SpawnUnitPos = getgenv().jjkSpawnPos


                            local args = {
                                [1] = "_lobbytemplate_event229",
                                [2] = {
                                    ["selected_key"] = "key_jjk_finger"
                                }
                            }

                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:
                                InvokeServer(unpack(args))
                            break
                        else
                            getgenv().cursedWomb = false
                            getgenv().level = "clover_infinite"
                        end


                    end

                    if getgenv().autochallenge and getgenv().canDoChallenge and not getgenv().isChallengeCleared then
                        local args = {
                            [1] = getgenv().door
                        }

                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
                        break

                    elseif getgenv().farmCastle then
                        setCastleWorldSpawnPos()
                        -- tp
                        local startButton = game:GetService("Players").LocalPlayer.PlayerGui.InfiniteTowerUI.LevelSelect
                            .Buttons
                            .Start
                        print(startButton)

                        local events = { "MouseButton1Click", "MouseButton1Down", "Activated" }
                        for i, v in pairs(events) do
                            for i, v in pairs(getconnections(startButton[v])) do
                                v:Fire()
                            end

                        end
                        break
                    else
                        if getgenv().farmDailies then
                            task.wait()
                            if (getgenv().namekDailyInfinite == false) then
                                getgenv().world = "Planet Namak"
                                getgenv().level = "namek_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().namekSpawnPos

                            elseif (getgenv().aotDailyInfinite == false) then
                                getgenv().world = "Shiganshinu District"
                                getgenv().level = "aot_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().aotSpawnPos

                            elseif (getgenv().demonslayerDailyInfinite == false) then
                                getgenv().world = "Snowy Town"
                                getgenv().level = "demonslayer_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().demonslayerSpawnPos

                            elseif (getgenv().narutoDailyInfinite == false) then
                                getgenv().world = "Hidden Sand Village"
                                getgenv().level = "naruto_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().narutoSpawnPos


                            elseif (getgenv().marinefordDailyInfinite == false) then
                                getgenv().world = "Marine's Ford"
                                getgenv().level = "marineford_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().marinefordSpawnPos

                            elseif (getgenv().tokyoGhoulDailyInfinite == false) then
                                getgenv().world = "Ghoul City"
                                getgenv().level = "tokyoghoul_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().tokyoGhoulSpawnPos

                            elseif (getgenv().bleachDailyInfinite == false) then
                                getgenv().world = "Hollow World"
                                getgenv().level = "hueco_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().bleachSpawnPos

                            elseif (getgenv().hxhDailyInfinite == false) then
                                getgenv().world = "Ant Kingdom"
                                getgenv().level = "hxhant_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().hxhSpawnPos

                            elseif (getgenv().fairytailDailyInfinite == false) then
                                getgenv().world = "Magic Town"
                                getgenv().level = "magnolia_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().fairytailSpawnPos

                            elseif (getgenv().jjkDailyInfinite == false) then
                                getgenv().world = "Cursed Academy"
                                getgenv().level = "jjk_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().jjkSpawnPos

                            elseif (getgenv().blackCloverInfinite == false) then
                                getgenv().world = "Clover Kingdom"
                                getgenv().level = "clover_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().blackCloverSpawnPos

                            else
                                getgenv().world = "Cape Canaveral"
                                getgenv().level = "jojo_infinite"
                                getgenv().difficulty = "Hard"
                                getgenv().SpawnUnitPos = getgenv().jojoSpawnPos
                            end
                            updatejson()
                        end

                        getWorldwithInfinite(getgenv().level)
                        setSpawnPos()
                        for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                            if v.Name == "Owner" and v.Value == nil then
                                getgenv().door = v.Parent.Name
                                break
                            end
                        end

                        task.wait(0.1)

                        local args = {
                            [1] = getgenv().door
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(
                            args))

                        task.wait(0.1)

                        local args = {
                            [1] = getgenv().door, -- Lobby
                            [2] = getgenv().level, -- World
                            [3] = true, -- Friends Only or not
                            [4] = getgenv().difficulty
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(
                            args))

                        task.wait(0.1)

                        local args = {
                            [1] = getgenv().door
                        }

                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                        task.wait(0.1)
                    end
                end



            end

        end

    end
end))



-- AUTO LEAVE --
coroutine.resume(coroutine.create(function()
    local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
    GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
        print("Changed", GameFinished.Value == true)
        while GameFinished.Value == true do
            task.wait()
            repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
            task.wait()

            pcall(function() webhook() end)
            print("next")

            repeat task.wait() until game:GetService("ReplicatedStorage").endpoints.client_to_server.teleport_back_to_lobby
                :InvokeServer()

            -- repeat task.wait() until game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)

        end
    end)
end))

-- AUTO SELL --
coroutine.resume(coroutine.create(function()
    while task.wait() do
        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        if getgenv().autosell and tonumber(getgenv().sellatwave) <= _wave.Value then
            getgenv().disableatuofarm = true
            if game.PlaceId ~= 8304191830 then
                repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                    repeat
                        task.wait()
                    until v:WaitForChild("_stats")
                    if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                        repeat
                            task.wait()
                        until v:WaitForChild("_stats"):WaitForChild("upgrade")

                        game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
                    end
                end
            end
        end
    end
end))

local EquippedUnits = nil
-- AUTO UPGRADE
coroutine.resume(coroutine.create(function()
    while task.wait() do
        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        if EquippedUnits == nil then
            EquippedUnits = {}
            for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.spawn_units.Lives.Frame.Units:
                GetChildren()) do
                if v.Name ~= "UIListLayout" then
                    for i, v in ipairs(v.Main.petimage.WorldModel:GetChildren()) do
                        if v.Name == "denji" then
                            table.insert(EquippedUnits, "denji_chainsaw")
                        else
                            table.insert(EquippedUnits, v.Name)
                        end
                    end
                end
            end
        end
        if getgenv().autoupgrade then
            if game.PlaceId ~= 8304191830 then
                local max = 8
                repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                for i = _wave.Value, getgenv().sellatwave do
                    local upgradeCap = { getgenv().maxUpgrades.U1, getgenv().maxUpgrades.U2, getgenv().maxUpgrades.U3,
                        getgenv().maxUpgrades.U4, getgenv().maxUpgrades.U5, getgenv().maxUpgrades.U6 }
                    repeat task.wait() until getgenv().enableupgrading == true
                    --task.wait(5)
                    local currentWave = _wave.Value
                    --while (tonumber(game:GetService("Players").LocalPlayer.PlayerGui.spawn_units.Lives.Frame.Money.text.Text) > 5000) do
                    for i = 1, 6 do
                        for j, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                            repeat task.wait() until v:WaitForChild("_stats")
                            if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                                if EquippedUnits[i] == v.Name and v["_stats"].upgrade.Value < upgradeCap[i] then
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:
                                        InvokeServer(v)
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:
                                        InvokeServer(v)
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:
                                        InvokeServer(v)
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:
                                        InvokeServer(v)
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:
                                        InvokeServer(v)
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:
                                        InvokeServer(v)
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:
                                        InvokeServer(v)
                                end
                            end
                        end

                        task.wait(0.3)
                    end
                    --end
                    getgenv().enableupgrading = false
                    repeat task.wait() until _wave.Value ~= currentWave

                end
            end
        end
    end
end))

-- AUTO ABILITIES --
local erwins = {}
local kisuke = {}

-- erwin auto ability
coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait() do
            if getgenv().autoabilities and game.PlaceId ~= 8304191830 then
                repeat
                    task.wait()
                    --repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                    for i, v in next, (game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                        --repeat task.wait() until v:WaitForChild("_stats")
                        if (
                            v.Name == "erwin" or v.Name == "erwin:shiny" or v.Name == "erwin_school" or
                                v.Name == "erwin_halloween") and
                            tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and
                            v["_stats"].upgrade.Value >= 3 then
                            if not table.find(erwins, v) then
                                table.insert(erwins, v)
                            end

                        end
                        -- if v.Name == "kisuke_evolved" and
                        --     tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                        --     if not table.find(kisuke, v) then
                        --         table.insert(kisuke, v)
                        --     end
                        -- end
                    end
                until #erwins >= 2

                if #erwins >= 2 then
                    while task.wait() do
                        repeat task.wait() until erwins[1]._stats.unit_stunned.Value == 0
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack
                            :InvokeServer(erwins[1])
                        task.wait(22)

                        repeat task.wait() until erwins[2]._stats.unit_stunned.Value == 0
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack
                            :InvokeServer(erwins[2])
                        task.wait(22)
                    end
                end
            end
        end
    end)
end))

-- gojo abilities
coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait() do
            if getgenv().autoabilities then
                if game.PlaceId ~= 8304191830 then
                    repeat task.wait() until game.workspace._UNITS:WaitForChild("gojo_halloween")
                    --game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(game.workspace
                    --._UNITS.gojo_evolved)
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(game.workspace
                        ._UNITS.gojo_halloween)
                    task.wait(62)

                end
            end
        end
    end)
end))

-- kisoko auto ability
coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait() do
            if getgenv().autoabilities and game.PlaceId ~= 8304191830 then
                repeat
                    task.wait()
                    --repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                    for i, v in next, (game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                        --repeat task.wait() until v:WaitForChild("_stats")
                        if v.Name == "kisuke_evolved" and
                            tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                            if not table.find(kisuke, v) then
                                table.insert(kisuke, v)
                            end
                        end
                    end
                until #kisuke > 2

                if #kisuke >= 2 then
                    while task.wait() do
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack
                            :InvokeServer(kisuke[1])
                        task.wait(32)

                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack
                            :InvokeServer(kisuke[2])
                        task.wait(32)

                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack
                            :InvokeServer(kisuke[3])
                        task.wait(32)
                    end
                end
            end
        end
    end)
end))



-- HIDE NAME --
task.spawn(function() -- Hides name for yters (not sure if its Fe)
    while task.wait() do
        pcall(function()
            if game.Players.LocalPlayer.Character.Head:FindFirstChild("_overhead") then
                workspace[game.Players.LocalPlayer.Name].Head["_overhead"]:Destroy()
            end
        end)
    end
end)

--anti afk
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end)
