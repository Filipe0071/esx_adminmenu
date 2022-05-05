local fakeNotif = {
    {
        name = "Discord Call",
        youtube_id = "n_WorPInSPQ",
        volume = 25 -- 75% is the maximum.
    }, {
        name = "Discord Message",
        youtube_id = "rIPq9Fl5r44",
        volume = 20
    }, {
        name = "Skype Call",
        youtube_id = "lVQI7CLus04",
        volume = 25
    }, {
        name = "TS3 Hey Wake Up",
        youtube_id = "s-KcXdYysTQ",
        volume = 15
    }, {
        name = "Win10 Error",
        youtube_id = "QkcEqzO_pus",
        volume = 25
    }, {
        name = "Win10 USB",
        youtube_id = "OOJi5zm9GYQ",
        volume = 60
    }, {
        name = "Door Knocking",
        youtube_id = "4Potjy81R3c",
        volume = 60
    }
}

RegisterCommand("testcontext", function()
    lib.registerContext({
        id = "admin_menu",
        title = "Admin Menu",
        options = {
            ["🧍‍♂️ Online Players"] = {
                event = "open_online_players",
                description = "Show Online Players"
            },
            ["🧍‍♂️ Player Related Options"] = {
                menu = "player_related_options",
                description = "Show Player Related Options"
            },
            ["🚙 Vehicle Related Options"] = {
                menu = "vehicle_related_options",
                description = "Show Vehicle Related Options"
            },
            ["🚧 Misc Settings"] = {
                menu = "misc_settings",
                description = "Show Misc Settings"
            },
            ["🚧 Troll Menu"] = {
                menu = "troll_menu",
                description = "Open Troll Menu"
            },
            ["📸 Rockstar Editor"] = {
                menu = "rockstar_editor",
                description = "Rockstar Settings"
            },
            ["🔬 Spectate Player"] = {
                event = "openSpectateMenu",
                description = "Spectate Player"
            }
        },
        {
            id = "player_related_options",
            title = "🧍‍♂️ Player Related Options",
            menu = "admin_menu",
            options = {
                ["🧍‍♂️ Player Options"] = {
                    menu = "player_options",
                },
                ["🧍‍♂️ Ped Options"] = {
                    menu = "ped_options",
                }
            }
        },
        {
            id = "player_options",
            title = "🧍‍♂️ Player Options",
            menu = "player_related_options",
            options = {
                ["🪂 Toggle Noclip"] = {event = "esx_adminmenu:toggle_noclip"},
                ["✨ Heal Player"] = {event = "esx_adminmenu:HealPlayer"},
                ["❤️ Revive Player"] = {event = "esx_adminmenu:RevivePlayer"},
            }
        },
        {
            id = "ped_options",
            title = "🧍‍♂️ Ped Options",
            menu = "player_related_options",
            options = {
                ["👕 Change Appearance"] = {event = "esx_mroupa:openSaveableMenu"},
                ["👦🏻 Change To Addon Ped"] = {event = "esx_adminmenu:client:ChangePed"}
            }
        },
        {
            id = "vehicle_related_options",
            title = "🚙 Vehicle Related Options",
            menu = "admin_menu",
            options = {
                ["Nothing here"] = {}
            }
        },
        {
            id = "misc_settings",
            title = "🚧 Misc Settings",
            menu = "admin_menu",
            options = {
                ["🕹 Teleport To Marker"] = {event = "esx_adminmenu:ttm"},
                ["🕹 Teleport To Coords"] = {event = "esx_adminmenu:ttc"},
                ["🕹 Clear Area"] = {event = "esx_adminmenu:ca"},
                ["🕹 Relog"] = {serverEvent = "esx_multicharacter:relog"}
            }
        },
        {
            id = "troll_menu",
            title = "🚧 Troll Menu",
            menu = "admin_menu",
            options = {
                ["🚚 Truck Punchline"] = {event = "esx_adminmenu:client:TruckPunchlinePly"},
                ["🎙 Fake Sound"] = {event = "esx_adminmenu:client:FakeSounds"}
            }
        },
        {
            id = "rockstar_editor",
            title = "📸 Rockstar Editor",
            menu = "admin_menu",
            options = {
                ["🎥 Start Recording"] = {event = "esx_adminmenu:record"},
                ["🎥 Save Recording"] = {event = "esx_adminmenu:saveclip"},
                ["🎥 Discard Recording"] = {event = "esx_adminmenu:delclip"},
                ["🎥 Open Editor"] = {event = "esx_adminmenu:editor"},
            }
        },
    })
    lib.showContext("admin_menu")
end)

RegisterNetEvent("esx_adminmenu:client:TruckPunchlinePly", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:GetOnlinePlayers", function(plyList)
        local optionTruckP = {}
        for k, v in pairs(plyList) do
            optionTruckP[v.name] = {
                description = "Player ID: "..v.source,
                arrow = true,
                serverEvent = "esx_adminmenu:server:TruckPunchlinePly",
                args = {id = v.source}
            }
        end
        lib.registerContext({
            id = "online_players",
            title = "Online Players",
            menu = "admin_menu",
            options = optionTruckP
        })
        lib.showContext("online_players")
    end)
end)

RegisterNetEvent("esx_adminmenu:client:FakeSounds", function()
    local count = 2
    local optionFakeSound = {}
    for k, v in pairs(fakeNotif) do
        local t = count - 1
        optionFakeSound[v.name] = {
            description = "Play: "..v.name,
            arrow = true,
            event = "esx_adminmenu:client:FakeCallply",
            args = {type = t}
        }
    end
    lib.registerContext({
        id = "fake_sounds",
        title = "🎙 Fake Sounds",
        menu = "troll_menu",
        options = optionFakeSound
    })
    lib.showContext("fake_sounds")
end)

RegisterNetEvent("esx_adminmenu:client:FakeCallply", function(data)
    local type = data.type
    ESX.TriggerServerCallback("esx_adminmenu:server:GetOnlinePlayers", function(plyList)
        local optionTruckP = {}
        for k, v in pairs(plyList) do
            optionTruckP[v.name] = {
                description = "Player ID: "..v.source,
                arrow = true,
                serverEvent = "esx_adminmenu:server:FakeCallply",
                args = {id = v.source, type = type}
            }
        end
        lib.registerContext({
            id = "online_players",
            title = "Online Players",
            menu = "admin_menu",
            options = optionTruckP
        })
        lib.showContext("online_players")
    end)
end)

OpenPlayersMenu = function(data)
    selectedPlayer = data.id
    lib.registerContext({
        id = "online_players_each",
        title = "ID: "..selectedPlayer.." Actions",
        menu = "online_players",
        options = {
            ["💬 Change Skin"] = {event = "esx_adminmenu:client:ChangeSkin"},
            ["Nothing here"] = {}
        }
    })
    lib.showContext("online_players_each")
end

OnlinePlayers = function()
    ESX.TriggerServerCallback("esx_adminmenu:server:GetOnlinePlayers", function(plyList)
        local optionTable = {}
        for k, v in pairs(plyList) do
            optionTable[v.name] = {
                description = v.name.." ID: "..v.source,
                arrow = true,
                event = "open_each_player",
                args = {id = v.source, name = v.name}
            }
        end
        lib.registerContext({
            id = "online_players",
            title = "Online Players",
            menu = "admin_menu",
            options = optionTable
        })
        lib.showContext("online_players")
    end)
end

RegisterNetEvent("open_each_player", function(data)
    OpenPlayersMenu(data)
end)

RegisterNetEvent("open_online_players", function()
    OnlinePlayers()
end)

RegisterNetEvent("esx_adminmenu:troll:FakeCall", function(type)
    local notif = fakeNotif[type]
    local url = string.format("https://furfag.de/eggs/youtube_player/index.html?video=%s&volume=%s", notif.youtube_id, math.min(notif.volume or 25, 75))
    local dui = CreateDui(url, 1024, 1024)
    duihandle = GetDuiHandle(dui)
    Wait(10000)
    DestroyDui(dui)
end)

RegisterKeyMapping("testcontext", "Admin Menu", "keyboard", "f10")