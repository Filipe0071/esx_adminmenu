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
                ["🪂 Toggle Noclip"] = {
                    arrow = true,
                    event = "esx_adminmenu:noclip_menu",
                },
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
                ["Nothing here"] = {}
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

RegisterNetEvent("esx_adminmenu:noclip_menu", function()
    lib.registerContext({
        id = "noclip_options",
        title = "🪂 Noclip Options",
        menu = "player_options",
        options = {
            ["🪂 Activate Noclip"] = {event = "esx_adminmenu:activate_noclip"},
            ["🪂 Desable Noclip"] = {event = "esx_adminmenu:disable_noclip"}
        }
    })
    lib.showContext("noclip_options")
end)

OpenPlayersMenu = function(data)
    selectedPlayer = data.id
    print(selectedPlayer)
    lib.registerContext({
        id = "online_players_each",
        title = "ID: "..selectedPlayer..' Actions',
        menu = "online_players",
        options = {
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

RegisterKeyMapping("testcontext", "Admin Menu", "keyboard", "f10")
