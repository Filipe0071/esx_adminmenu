RegisterNetEvent("esx_adminmenu:OnlinePlayers", function()
    lib.callback("esx_adminmenu:server:GetOnlinePlayers", false, function(plyList)
        local myMenu = {}
        for k, v in pairs(plyList) do
            myMenu[v.name] = {
                description = v.name.." ID: "..v.source,
                arrow = true,
                event = "esx_adminmenu:OpenPlayersMenu",
                args = {id = v.source, name = v.name}
            }
        end
        lib.registerContext({id = "online_players", title = "🧍‍♂️ Online Players", menu = "admin_menu", options = myMenu})
        lib.showContext("online_players")
    end)
end)

RegisterNetEvent("esx_adminmenu:OpenPlayersMenu", function(data)
    selectedPlayer = data.id
    lib.registerContext({
        id = "online_players_each",
        title = "ID: "..selectedPlayer.."",
        menu = "online_players",
        options = {
            [""] = {}
        }
    })
    lib.showContext("online_players_each")
end)

RegisterCommand("tsadmin", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            lib.registerContext({
                id = "admin_menu",
                title = "🧍‍♂️ Admin Menu",
                options = {
                    ["🧍‍♂️ Online Players"] = {event = "esx_adminmenu:OnlinePlayers", description = "Show Online Players"},
                    ["🧍‍♂️ Player Related Options"] = {description = "Show Player Related Options"},
                    ["🚙 Vehicle Related Options"] = {description = "Show Vehicle Related Options"},
                    ["🚧 Misc Settings"] = {description = "Misc Settings"},
                    ["🚧 Troll Menu"] = {description = "Open Troll Menu"},
                    ["📸 Rockstar Editor"] = {description = "Rockstar Settings"}
                }
            })
            lib.showContext("admin_menu")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OpenAdminmenu")
end)

RegisterKeyMapping("tsadmin", "TS Adminmenu", "keyboard", "f11")