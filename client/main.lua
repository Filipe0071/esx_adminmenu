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
            ["📗 Set Job"] = {event = "esx_adminmenu:client:GetJobs", description = "Change Player Job"},
            ["🎁 Give Player Item"] = {event = "esx_adminmenu:client:GiveItem", description = "Give Item"},
            ["🗑 Remove Inventory Item"] = {event = "esx_adminmenu:client:GetItems", description = "Remove Item"},
            ["💵 Give Account Money"] = {event = "esx_adminmenu:client:GiveAccountMoney", description = "Give Money"},
            ["💵 Remove Account Money"] = {event = "esx_adminmenu:client:RemoveAccountMoney", description = "Remove Money"},
            ["✨ Add / Remove License"] = {event = "esx_adminmenu:client:ToggleLicense", description = "Add / Remove License"},
            ["✨ Heal Player"] = {event = "esx_adminmenu:client:HealPlayer", description = "Heal Player"},
            ["❤️ Revive Player"] = {event = "esx_adminmenu:client:RevivePlayer", description = "Revive Player"},
            ["🛸 Teleport To Player"] = {event = "esx_adminmenu:client:Goto", description = "Teleport To Player"},
            ["🚀 Bring Player"] = {event = "esx_adminmenu:client:Bring", description = "Bring Player"},
            ["💾 Print Identifiers"] = {event = "esx_adminmenu:client:PrintID", description = "Print player identifiers"},
            ["🔪 Kill Player"] = {event = "esx_adminmenu:client:KillPlayer", description = "Kill Player"},
            ["🦶🏽 Kick Player"] = {event = "esx_adminmenu:client:KickPlayer", description = "Kick Player"}
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
                if grade == nil then
                    return
                end
                TriggerServerEvent("esx_adminmenu:server:SetJob", selectedPlayer, job, grade)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_SetJob", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:GiveItem", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local player = data.plyid
            local item = data.item
            local input = lib.inputDialog("TS Admin Menu Give Item", {"Count:"})
            if input then
                local count = tonumber(input[1])
                if count == nil then
                    return
                end
                TriggerServerEvent("esx_adminmenu:server:GiveItem", player, item, count)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_GiveItem", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:GiveItem", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local Items = exports.ox_inventory:Items()
            local myMenu = {}
            for k, v in pairs(Items) do
                myMenu[v.label] = {
                    description = "Give " .. v.name,
                    arrow = true,
                    event = "esx_adminmenu:GiveItem",
                    args = {item = v.name, plyid = selectedPlayer}
                }
            end
            lib.registerContext({id = "GetItems", title = "🎁 All Items", menu = "admin_menu", options = myMenu})
            lib.showContext("GetItems")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_GiveItem", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:GetItems", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:GetItems", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_RemoveInventoryItem", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:RemoveItemCount", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local pid = data.plyid
            local item = data.item
            local input = lib.inputDialog("TS Admin Menu Remove Item: " .. item, {"Count:"})
            if input then
                local count = tonumber(input[1])
                if count == nil then
                    return
                end
                TriggerServerEvent("esx_adminmenu:server:RemoveItem", pid, item, count)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_RemoveInventoryItem", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:RemoveItem", function(ply, list)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local pid = ply
            local items = list
            local myMenu = {}
            for k, v in pairs(items) do
                myMenu[v.label] = {
                    description = "Remove " .. v.name,
                    arrow = true,
                    event = "esx_adminmenu:client:RemoveItemCount",
                    args = {item = v.name, plyid = pid}
                }
            end
            lib.registerContext({id = "RemoveItems", title = "🎁 Remove Inventory Items", menu = "admin_menu", options = myMenu})
            lib.showContext("RemoveItems")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_RemoveInventoryItem", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:GiveAccountMoney", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local input = lib.inputDialog("Give Account Money - TSADMIN", {"Account Name (money, bank, black_money)", "Amount"})
            if input then
                local account = input[1]
                local money = tonumber(input[2])
                if account == nil or money == nil then
                    return
                end
                TriggerServerEvent("esx_adminmenu:server:GiveAccMoney", selectedPlayer, account, money)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_GiveMoney", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:RemoveAccountMoney", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local input = lib.inputDialog("Remove Account Money - TSADMIN", {"Account Name (money, bank, black_money)", "Amount"})
            if input then
                local account = input[1]
                local money = tonumber(input[2])
                if account == nil or money == nil then
                    return
                end
                TriggerServerEvent("esx_adminmenu:server:RemoveAccMoney", selectedPlayer, account, money)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_RemoveMoney", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:ToggleLicense", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local input = lib.inputDialog("TS Admin Menu - License Manager", {"License Name"})
            if input then
                local license = input[1]
                if license == nil then
                    return
                end
                TriggerServerEvent("esx_adminmenu:server:ToggleLicense", selectedPlayer, license)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_License", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:HealPlayer", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:HealPlayer", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_Heal", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:RevivePlayer", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:RevivePlayer", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_Revive", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:Goto", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:Goto", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_Goto", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:Bring", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:Bring", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_Bring", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:PrintID", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:PrintID", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_PRINTID", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:PrintID", function(steamid, license, xbl, ip, discord, liveid)
    print(steamid, license, xbl, ip, discord, liveid)
end)

RegisterNetEvent("esx_adminmenu:client:KillPlayer", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:KillPlayer", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_KillPlayer", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:Kill", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            SetEntityHealth(PlayerPedId(), 0)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_KillPlayer", "OnlinePlyOptions")
end)

RegisterNetEvent("esx_adminmenu:client:KickPlayer", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:KickPlayer", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_KickPlayer", "OnlinePlyOptions")
end)