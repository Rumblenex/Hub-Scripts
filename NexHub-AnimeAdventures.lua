--v1.0 Nex Hub
--Wait for game to load
task.wait(2)
repeat  task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
    
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
            
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

getgenv().savefilename = "Anime-Adventures_"..game.Players.LocalPlayer.Name.."_Custom.json"

-- get daily infinite
local function dailyInfinite()
    if(getgenv().world == "Planet Namak") then
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

    end
end


-- webhook
local function webhook()
    pcall(function()
        local url = tostring(getgenv().weburl) -- webhook url
        if url == "" then
           return
        end

        XP = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.GoldGemXP.XPReward.Main.Amount.Text)
		gems = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.GoldGemXP.GemReward.Main.Amount.Text)
        cwaves = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text

		ctime = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text
		waves = cwaves:split(": ")
        ttime = ctime:split(": ")

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
					["description"] = "🎮 **"..game:GetService("Players").LocalPlayer.Name.."** 🎮",
					["color"] = 110335,

					["thumbnail"] = {
						['url'] = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.userId .. "&width=420&height=420&format=png"
					},

					["fields"] = {
						{
							["name"] = "Total Waves:",
							["value"] = tostring(waves[2]) ..
								" <:wave:997136622363627530>",
							["inline"] = true
						}, {
							["name"] = "Recieved Gems:",
							["value"] = gems .. " <:gem:997123585476927558>",
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
                            ["value"] = tostring(game.Players.LocalPlayer._stats.gem_amount.Value).." <:gem:997123585476927558>",
                            ["inline"] = true
                        }, {
                            ["name"] = "Current Level:",
                            ["value"] = tostring(game.Players.LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text).. " ✨",
                            ["inline"] = true
                        }
					}
				}
			}
		}

        local getData = game:GetService("HttpService"):JSONEncode(data)

		local headers = {["content-type"] = "application/json"}
		request = http_request or request or HttpPost or syn.request or http.request
		local sendData = {Url = url, Body = getData, Method = "POST", Headers = headers}
		warn("Sending webhook notification...")
        request(sendData)

        -- check if the game reached to set wave and set infinite for that map to true
        if ((tonumber(waves[2])) >= tonumber(getgenv().sellatwave) and tonumber(waves[2]) ~= 999) then
            dailyInfinite()
        end
        updatejson()

    end)
end

--Buy Item Webhook
local function buyItemWebhook(itemBought)
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
					["description"] = "🎮 **"..game:GetService("Players").LocalPlayer.Name.."** 🎮",
					["color"] = 110335,

					["thumbnail"] = {
						['url'] = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.userId .. "&width=420&height=420&format=png"
					},

					["fields"] = {
						{
							["name"] = "Item Bought",
							["value"] = itemBought,
							["inline"] = true
						}
					}
				}
			}
		}

		local getData = game:GetService("HttpService"):JSONEncode(data)

		local headers = {["content-type"] = "application/json"}
		request = http_request or request or HttpPost or syn.request or http.request
		local sendData = {Url = url, Body = getData, Method = "POST", Headers = headers}
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

    getgenv().namekSpawnPos = data.xnamekSpawnPos
    getgenv().aotSpawnPos = data.xaotSpawnPos
    getgenv().demonslayerSpawnPos = data.xdemonslayerSpawnPos
    getgenv().narutoSpawnPos = data.xnarutoSpawnPos
    getgenv().marinefordSpawnPos = data.xmarinefordSpawnPos
    getgenv().tokyoGhoulSpawnPos = data.xtokyoGhoulSpawnPos
    getgenv().bleachSpawnPos = data.xbleachSpawnPos

    getgenv().buyStarRemnant = data.buyStarRemnant
    getgenv().buySummonTicket = data.buySummonTicket


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

            --store whether or not dailies for each map were completed
            farmDailies = getgenv().farmDailies,
            namekDailyInfinite = getgenv().namekDailyInfinite,
            aotDailyInfinite = getgenv().aotDailyInfinite,
            demonslayerDailyInfinite = getgenv().demonslayerDailyInfinite,
            narutoDailyInfinite = getgenv().narutoDailyInfinite,
            marinefordDailyInfinite = getgenv().marinefordDailyInfinite,
            tokyoGhoulDailyInfinite = getgenv().tokyoGhoulDailyInfinite,
            bleachDailyInfinite = getgenv().bleachDailyInfinite,
            
            xnamekSpawnPos = getgenv().namekSpawnPos,
            xaotSpawnPos = getgenv().aotSpawnPos,
            xdemonslayerSpawnPos = getgenv().demonslayerSpawnPos,
            xnarutoSpawnPos =  getgenv().narutoSpawnPos,
            xmarinefordSpawnPos =  getgenv().marinefordSpawnPos,
            xtokyoGhoulSpawnPos = getgenv().tokyoGhoulSpawnPos,
            xbleachSpawnPos = getgenv().bleachSpawnPos,

            buyStarRemnant = getgenv().buyStarRemnant,
            buySummonTicket = getgenv().buySummonTicket
            
        }

        local json = HttpService:JSONEncode(xdata)
        writefile(savefilename, json)

    end

    -- IN GAME GUI --
    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({
        Name = "NexHub | Anime Adventures | v1.0", 
        HidePremium = true, 
        SaveConfig = true, 
        ConfigFolder = "OrionTest"})
    getgenv().init = false


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
            repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
            --task.wait(2)
            table.clear(Units)
            for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
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
                        task.wait(0.3)
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.equip_unit:InvokeServer(unitinfo_[2])
                    end
                end
                updatejson()
            end
        end

        local drop1 = unitSection:AddDropdown({
            Name = "Unit 1",
            Callback = function(Value)
	            getgenv().SelectedUnits["U1"] = Value
                Equip()
	        end,
	        Default = getgenv().SelectedUnits["U1"],
            Options = Units
	        
        })

        local drop2 = unitSection:AddDropdown({
            Name = "Unit 2",
	        Default = getgenv().SelectedUnits["U2"],
            Options = Units,
	        Callback = function(Value)
	            getgenv().SelectedUnits["U2"] = Value
                Equip()
	        end
        })

        local drop3 = unitSection:AddDropdown({
            Name = "Unit 3",
	        Default = getgenv().SelectedUnits["U3"],
            Options = Units,
	        Callback = function(Value)
	            getgenv().SelectedUnits["U3"] = Value
                Equip()
	        end
        })

        local drop4 = unitSection:AddDropdown({
            Name = "Unit 4",
	        Default = getgenv().SelectedUnits["U4"],
            Options = Units,
	        Callback = function(Value)
	            getgenv().SelectedUnits["U4"] = Value
                Equip()
	        end
        })

        local drop5 = unitSection:AddDropdown({
            Name = "Unit 5",
	        Default = getgenv().SelectedUnits["U5"],
            Options = Units,
	        Callback = function(Value)
	            getgenv().SelectedUnits["U5"] = Value
                Equip()
	        end
        })

        local drop6 = unitSection:AddDropdown({
            Name = "Unit 6",
	        Default = getgenv().SelectedUnits["U6"],
            Options = Units,
	        Callback = function(Value)
	            getgenv().SelectedUnits["U6"] = Value
                Equip()
	        end
        })
        
        
        -- REFRESH UNIT LIST--
        local refresh = unitSection:AddButton({
            Name = "Refresh List",
            Callback = function()
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
                
            end})
    end
        
        

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
        autofarmtab:AddToggle{
            Name = "Auto Farm",
            Default = getgenv().AutoFarm,
            Callback = function(state)
                getgenv().AutoFarm = state
                updatejson()
            end
        }

        -- auto start toggle
        autofarmtab:AddToggle{
            Name = "Auto Start",
            Default = getgenv().autostart,
            Callback = function(state)
                getgenv().autostart = state
                updatejson()
                if game.PlaceId == 8304191830 then

                if getgenv().AutoFarm and getgenv().autostart then
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
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(
                        args))
                    
                end
                end
            end
        }

        -- auto abilities toggle
        autofarmtab:AddToggle{
            Name = "Auto Abilities",
            Default = getgenv().autoabilities,
            Callback = function(state)
                getgenv().autoabilities = state
                updatejson()
            end
        }

        --auto upgrade units toggle
        autofarmtab:AddToggle{
            Name = "Auto Upgrade Units",
            Default = getgenv().autoupgrade,
            Callback = function(state)
                getgenv().autoupgrade = state
                updatejson()
            end
        }
        
        -- auto sell toggle
        autofarmtab:AddToggle{
            Name = "Auto Sell Wave",
            Default = getgenv().autosell,
            Callback = function(state)
                getgenv().autosell = state
                updatejson()

                if getgenv().autosell == false then
                    getgenv().disableautofarm = false
                end
            end
        }

        -- auto sell at x wave
        autofarmtab:AddTextbox{
            Name = "Enter wave number",
            Default = getgenv().sellatwave,
            TextDisappear = false,
            Callback = function(Value)
                getgenv().sellatwave = tonumber(Value)
            end
        }

        --------------------------------------------------
        --------------- Select World Tab ---------------------
        --------------------------------------------------
        local Worlds = {"Planet Namak", "Shiganshinu District", "Snowy Town","Hidden Sand Village", "Marine's Ford", "Ghoul City", "Hollow World"}
        getgenv().levels = {"nill"}
        --select world
        selectWorld:AddDropdown{
            Name = "Select World",
            Default = getgenv().world,
            Options = Worlds,
            Callback = function(world)
                if getgenv().init then
                    getgenv().world = world
                    updatejson()

                    if world == "Planet Namak" then
                        table.clear(levels)
                        getgenv().levels = {"namek_infinite", "namek_level_1", "namek_level_2", "namek_level_3",
                                          "namek_level_4", "namek_level_5", "namek_level_6"}
                        leveldrop:Refresh(levels, true)

                    elseif world == "Shiganshinu District" then
                        table.clear(levels)
                        getgenv().levels = {"aot_infinite", "aot_level_1", "aot_level_2", "aot_level_3", "aot_level_4",
                                            "aot_level_5", "aot_level_6"}
                        leveldrop:Refresh(levels, true)
                        
                    elseif world == "Snowy Town" then
                        table.clear(levels)
                        getgenv().levels = {"demonslayer_infinite", "demonslayer_level_1", "demonslayer_level_2",
                                            "demonslayer_level_3", "demonslayer_level_4", "demonslayer_level_5",
                                            "demonslayer_level_6"}
                                            leveldrop:Refresh(levels, true)

                    elseif world == "Hidden Sand Village" then
                        table.clear(levels)
                        getgenv().levels = {"naruto_infinite", "naruto_level_1", "naruto_level_2", "naruto_level_3",
                                            "naruto_level_4", "naruto_level_5", "naruto_level_6"}
                        leveldrop:Refresh(levels, true)

                    elseif world == "Marine's Ford" then
                        table.clear(levels)
                        getgenv().levels = {"marineford_infinite","marineford_level_1","marineford_level_2","marineford_level_3",
                        "marineford_level_4","marineford_level_5","marineford_level_6",}
                        leveldrop:Refresh(levels, true)
    
                    elseif world == "Ghoul City" then
                        table.clear(levels)
                        getgenv().levels = {"tokyoghoul_infinite","tokyoghoul_level_1","tokyoghoul_level_2","tokyoghoul_level_3",
                        "tokyoghoul_level_4","tokyoghoul_level_5","tokyoghoul_level_6",}
                        leveldrop:Refresh(levels, true)
    
                    elseif world == "Hollow World" then
                        table.clear(levels)
                        getgenv().levels = {"hueco_infinite","hueco_level_1","hueco_level_2","hueco_level_3",
                        "hueco_level_4","hueco_level_5","hueco_level_6",}
                        leveldrop:Refresh(levels, true)
                    end
                end
            end
        }
        

        --select level
        getgenv().leveldrop = selectWorld:AddDropdown{
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
        selectWorld:AddDropdown{
            Name = "Select Difficulty",
            Default = getgenv().difficulty,
            Options = {"Normal", "Hard"},
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
                    buyItemWebhook("test")
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
                getgenv().autoopenocean = bool
                while getgenv().autoopenocean do
                    task.wait()
                    local args = {[1] = "capsule_bleach"}

                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_item:InvokeServer(unpack(args))
                end
                updatejson()
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

                while getgenv().farmDailies do
                    task.wait()
                    if(getgenv().namekDailyInfinite == false) then
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
                    
                    else 
                        getgenv().world = "Hollow World"
                        getgenv().level = "hollowWorld_infinite"
                        getgenv().difficulty = "Hard"
                        getgenv().SpawnUnitPos = getgenv().bleachSpawnPos
                    end
                end
                updatejson()
                end
            end    
        })

        -- reset dailies toggle
        miscTab:AddButton({
            Name = "Reset Dailies",
            Callback = function()
                getgenv().namekDailyInfinite = false
                getgenv().aotDailyInfinite = false
                getgenv().demonslayerDailyInfinite = false
                getgenv().narutoDailyInfinite = false
                getgenv().marinefordDailyInfinite = false
                getgenv().tokyoGhoulDailyInfinite = false
                getgenv().bleachDailyInfinite = false

                updatejson()
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
                    print("star remnant statemnt works")
                    local items = traveling_merchant.stand.items:GetChildren()
                    for i,v in pairs(items) do
                        local currItem = items[i]
                    
                        if(currItem:FindFirstChild("star_remnant")) then
                            print("in here")
                            local starRemnant = currItem
                            local args = {
                                [1] = tostring(starRemnant)
                            }
    
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item:InvokeServer(unpack(args))
    
                            local item = tostring(starRemnant)
                            buyItemWebhook(item)
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
                
                    for i,v in pairs(items) do
                        local currItem = items[i]
                    
                        if(currItem:FindFirstChild("star_neon")) then
                            local summonTicket = currItem
                            local args = {
                                [1] = tostring(summonTicket)
                            }
            
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item:InvokeServer(unpack(args))
                            
                            local item = tostring(summonTicket)
                            buyItemWebhook(item)
                        end
                    end
                end
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
                            Time = 5})
                        a.CanCollide = false
                        for i = 0, 1, 0.1 do
                            a.Transparency = i
                            task.wait()
                        end
                        a:Destroy()

                        if(getgenv().world == "Planet Namak") then
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

    OrionLib:Init()
    getgenv().init = true
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
        webhook = "",
        sellatwave = 0,
        autosell = false,
        autofarm = false,
        autostart = false,
        autoupgrade = false,
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

-- AUTO FARM --
coroutine.resume(coroutine.create(function()
    while task.wait() do
        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        if getgenv().AutoFarm and not getgenv().disableautofarm then
            if game.PlaceId ~= 8304191830 then
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
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"], pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"], pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"], pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] , pos["z"]), Vector3.new(0, 0, -1))
                            }
                        end
                        task.wait(0.3)
                    end
                    repeat task.wait() until _wave.Value ~= currentWave

                end
            end
        end
    end
end))


-- AUTO START --
coroutine.resume(coroutine.create(function() 
    while task.wait() do
        if getgenv().autostart and getgenv().AutoFarm then

            if game.PlaceId == 8304191830 then
                
                if (getgenv().farmDailies) then
                    task.wait()
                    if(getgenv().namekDailyInfinite == false) then
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
                    
                    elseif (getgenv().bleachDailyInfinite == false) then
                        getgenv().world = "Ghoul City"
                        getgenv().level = "tokyoghoul_infinite"
                        getgenv().difficulty = "Hard"
                        getgenv().SpawnUnitPos = getgenv().tokyoGhoulSpawnPos

                    else 
                        getgenv().world = "Hollow World"
                        getgenv().level = "hollowworld_infinite"
                        getgenv().difficulty = "Hard"
                        getgenv().SpawnUnitPos = getgenv().bleachSpawnPos
                    end
                    updatejson()
                end

                if(getgenv().world == "Planet Namak") then
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
                end
                updatejson()

                local traveling_merchant = game.workspace:FindFirstChild("travelling_merchant")
                if (traveling_merchant.is_open.value and getgenv().buyStarRemnant) then
                    print("star remnant statemnt works")
                    local items = traveling_merchant.stand.items:GetChildren()
                    for i,v in pairs(items) do
                            local currItem = items[i]
                        
                            if(currItem:FindFirstChild("star_remnant")) then
                                print("in here")
                                local starRemnant = currItem
                                local args = {
                                    [1] = tostring(starRemnant)
                                }

                                game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item:InvokeServer(unpack(args))

                                local item = tostring(starRemnant)
                                buyItemWebhook(item)
                            end
                        end
                    end

                    if (traveling_merchant.is_open.value and getgenv().buySummonTicket) then
                        local items = traveling_merchant.stand.items:GetChildren()
                    
                        for i,v in pairs(items) do
                            local currItem = items[i]
                        
                            if(currItem:FindFirstChild("star_neon")) then
                                local summonTicket = currItem
                                local args = {
                                    [1] = tostring(summonTicket)
                                }
                
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item:InvokeServer(unpack(args))
                                
                                local item = tostring(summonTicket)
                                buyItemWebhook(item)
                            end
                        end
                    end


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
                task.wait()

                print("end")

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
        repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
        task.wait()

		pcall(function() webhook() end)
        print("next")


        repeat task.wait() until game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
        
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
            for i,v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.spawn_units.Lives.Frame.Units:GetChildren()) do
                if v.Name ~= "UIListLayout" then
                    for i,v in ipairs(v.Main.petimage.WorldModel:GetChildren()) do
                        table.insert(EquippedUnits, v.Name)
                        print(v.Name)
                    end
                end
            end
        end
        if getgenv().autoupgrade then
            if game.PlaceId ~= 8304191830 then
                local max = 8
                repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                for i = _wave.Value, getgenv().sellatwave do
                    task.wait(5)
                    local currentWave = _wave.Value
                    for i = 1, 6 do
                        for j,v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                            repeat task.wait() until v:WaitForChild("_stats")
                            if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                                if EquippedUnits[i] == v.Name then
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                                end
                            end
                        end
                        
                        task.wait(0.3)
                    end

                    repeat task.wait() until _wave.Value ~= currentWave

                end
            end
        end
    end
end))

-- AUTO ABILITIES -- 
local erwins = {}
local kisuke = {}
-- local erwinCoroutine = coroutine.create(function()
--     for i,v in ipairs(erwins) do
--         print("erwin")
--         game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
--         task.wait(20)
--         coroutine.yield()
--     end
-- end)
-- local kisukeCoroutine = coroutine.create(function()
--     for i,v in ipairs(kisuke) do
--         print("kisuke")
--         game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
--         task.wait(30)
--         coroutine.yield()
--     end
-- end)

-- get placed erwins and kisukes
coroutine.resume(coroutine.create(function()
    pcall(function()
        while task.wait() do 
            if getgenv().autoabilities then
                if game.PlaceId ~= 8304191830 then
                    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                        repeat task.wait() until v:WaitForChild("_stats")
                        if v.Name == "erwin" then
                            table.insert(erwins, v)
                            
                        end
                        if v.Name == "kisuke_evolved" then
                            table.insert(kisuke, v)
                        end
                    end
                end
            end
        end
    end)
end))

-- cycle erwins
coroutine.resume(coroutine.create(function() 
    pcall(function()
       while task.wait() do
           if getgenv().autoabilities then
               if game.PlaceId ~= 8304191830 then
                   for i,v in ipairs(erwins) do
                       game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                       task.wait(20)
                   end
                   
               end
           end
       end
   end)
end))

-- cycle kisukes
coroutine.resume(coroutine.create(function() 
    pcall(function()
       while task.wait() do
           if getgenv().autoabilities then
               if game.PlaceId ~= 8304191830 then
                   for i,v in ipairs(kisuke) do
                       game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                       task.wait(30)
                   end  
               end
           end
       end
   end)
end))

-- HIDE NAME --
task.spawn(function()  -- Hides name for yters (not sure if its Fe)
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
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)
