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
            ["💬 Send Private Message"] = {event = "esx_adminmenu:client:SendMessage", description = "Send private message to player"},
            ["💬 Change Skin"] = {event = "esx_adminmenu:client:ChangeSkin", description = "Change skin option for player"},
            ["📂 Show Inventory"] = {event = "esx_adminmenu:client:ShowInventory", description = "Show Player Inventory"},
            ["📗 Set Job"] = {event = "esx_adminmenu:client:GetJobs", description = "Change Player Job"}
        }
    })
    lib.showContext("online_players_each")
end)

RegisterNetEvent("esx_adminmenu:client:SendMessage", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local input = lib.inputDialog("TS Admin Menu", {"Message"})
            if input then
                local message = input[1]
                if message == nil then
                    return
                end
                TriggerServerEvent("esx_adminmenu:server:SendMessage", selectedPlayer, message)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_SendMessage", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:ChangeSkin", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:ChangeSkin", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_ChangeSkin", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:ShowInventory", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:ShowInventory", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_OpenInventory", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:GetJobs", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            ESX.TriggerServerCallback("esx_adminmenu:server:GetJobs", function(jobs)
                local myMenu = {}
                for k, v in pairs(jobs) do
                    local grade = 0
                    for i, j in pairs(v.grades) do
                        grade = grade + 1
                    end
                    myMenu[v.label .. " - " .. v.name] = {
                        description = "Grades = " .. grade - 1,
                        arrow = true,
                        event = "esx_adminmenu:client:setgrade",
                        args = {job = v.name, max = grade}
                    }
                end
                lib.registerContext({id = "GetJobs", title = "📗 All Jobs", menu = "admin_menu", options = myMenu})
                lib.showContext("GetJobs")
            end)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_SetJob", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:setgrade", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local job = data.job
            local max = tonumber(data.max) - 1
            local input = lib.inputDialog("TS Admin Menu", {"Max Grade: " .. max})
            if input then
                local grade = tonumber(input[1])
                TriggerServerEvent("esx_adminmenu:server:SetJob", selectedPlayer, job, grade)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_SetJob", "OnlinePlyOptions")
end)
