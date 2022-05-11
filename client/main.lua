RegisterCommand("tsadmin", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            lib.registerContext({
                id = "admin_menu",
                title = "🧍‍♂️ Admin Menu",
                options = {
                    ["🧍‍♂️ Online Players"] = {event = "esx_adminmenu:OnlinePlayers", description = "Show Online Players"},
                    ["🧍‍♂️ Player Related Options"] = {event = "esx_adminmenu:PlayerRelatedOptionsMenu", description = "Show Player Related Options"},
                    ["🚙 Vehicle Related Options"] = {event = "esx_adminmenu:VehiclesRelatedOptionsMenu", description = "Show Vehicle Related Options"},
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
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
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
                    ["🦶🏽 Kick Player"] = {event = "esx_adminmenu:client:KickPlayer", description = "Kick Player"},
                    ["📷 Screenshot"] = {event = "esx_adminmenu:client:ScreenShopPlayer", description = "Take screenshot of player screen"},
                    ["🔬 Spectate Player"] = {event = "esx_adminmenu:client:SpectatePlayer", description = "Spectate Player"}
                }
            })
            lib.showContext("online_players_each")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions")
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
    end, "OnlinePlyOptions_SendMessage")
end)

RegisterNetEvent("esx_adminmenu:client:ChangeSkin", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:ChangeSkin", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_ChangeSkin")
end)

RegisterNetEvent("esx_adminmenu:client:ShowInventory", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:ShowInventory", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_OpenInventory")
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
                lib.registerContext({id = "GetJobs", title = "📗 All Jobs", menu = "online_players_each", options = myMenu})
                lib.showContext("GetJobs")
            end)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_SetJob")
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
    end, "OnlinePlyOptions_SetJob")
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
    end, "OnlinePlyOptions_GiveItem")
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
            lib.registerContext({id = "GetItems", title = "🎁 All Items", menu = "online_players_each", options = myMenu})
            lib.showContext("GetItems")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_GiveItem")
end)

RegisterNetEvent("esx_adminmenu:client:GetItems", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:GetItems", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_RemoveInventoryItem")
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
    end, "OnlinePlyOptions_RemoveInventoryItem")
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
            lib.registerContext({id = "RemoveItems", title = "🎁 Remove Inventory Items", menu = "online_players_each", options = myMenu})
            lib.showContext("RemoveItems")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_RemoveInventoryItem")
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
    end, "OnlinePlyOptions_GiveMoney")
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
    end, "OnlinePlyOptions_RemoveMoney")
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
    end, "OnlinePlyOptions_License")
end)

RegisterNetEvent("esx_adminmenu:client:HealPlayer", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:HealPlayer", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_Heal")
end)

RegisterNetEvent("esx_adminmenu:client:RevivePlayer", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:RevivePlayer", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_Revive")
end)

RegisterNetEvent("esx_adminmenu:client:Goto", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:Goto", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_Goto")
end)

RegisterNetEvent("esx_adminmenu:client:Bring", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:Bring", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_Bring")
end)

RegisterNetEvent("esx_adminmenu:client:PrintID", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:PrintID", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_PRINTID")
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
    end, "OnlinePlyOptions_KillPlayer")
end)

RegisterNetEvent("esx_adminmenu:client:Kill", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            SetEntityHealth(PlayerPedId(), 0)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_KillPlayer")
end)

RegisterNetEvent("esx_adminmenu:client:KickPlayer", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:KickPlayer", selectedPlayer)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_KickPlayer")
end)

RegisterNetEvent("esx_adminmenu:client:ScreenShopPlayer", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            exports["screenshot-basic"]:requestScreenshotUpload("https://discord.com/api/webhooks/974002549835333702/qasfRoc_k4xPXHSJDOPZNl20FKbon_hRayZhyRD-CgGdzOAng-MXx631sKwFkQyiAB-f", "files[]", function(data) end)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_ScreenShopPlayer")
end)

RegisterNetEvent("esx_adminmenu:client:SpectatePlayer", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            lib.callback("esx_adminmenu:server:GetSpectateData", false, function(data)
                local ped = PlayerPedId()
                local specinterval = nil
                local controlInterval = nil
                local targetPly = nil
                local targetPed = nil
                if not spectating then
                    lastPos = GetEntityCoords(ped)
                    spectating = true
                    DoScreenFadeOut(500)
                    Wait(500)
                    RequestCollisionAtCoord(data)
                    SetEntityVisible(ped, false)
                    SetEntityCoords(ped, data + vector3(0, 0, 10))
                    FreezeEntityPosition(ped, true)
                    Wait(1500)
                    SetEntityCoords(ped, data - vector3(0, 0, 10))
                    targetPly = GetPlayerFromServerId(selectedPlayer)
                    targetPed = GetPlayerPed(targetPly)
                    DoScreenFadeIn(500)
                    NetworkSetInSpectatorMode(true, targetPed)
                    specinterval = SetInterval(function()
                        local god = tostring(GetPlayerInvincible(targetPly))
                        local ragdoll = tostring(not CanPedRagdoll(targetPed))
                        local health = tostring(GetEntityHealth(targetPed))
                        local armor = tostring(GetPedArmour(targetPed))
                        if god == "1" then
                            god = "true"
                        end
                        local msg = "Godmode: " .. god .. "  \nAntiRagdoll: " .. ragdoll .. "  \nHealth: " .. health .. "  \nArmor: " .. armor
                        if spectating then
                        showPlyInfo(tostring(msg))
                        end
                    end, 2000)
                    controlInterval = SetInterval(function()
                        DisableControlAction(0, 38, true)
                        if IsDisabledControlJustPressed(0, 38) and spectating then
                            spectating = false
                            ClearInterval(specinterval)
                            ClearInterval(controlInterval)
                            controlInterval = nil
                            specinterval = nil
                            targetPly = nil
                            targetPed = nil
                            RequestCollisionAtCoord(lastPos)
                            NetworkSetInSpectatorMode(false, ped)
                            SetEntityCoords(ped, lastPos)
                            SetEntityVisible(ped, true)
                            FreezeEntityPosition(ped, false)
                            lib.hideTextUI()
                        end
                    end, 0)
                else
                    spectating = false
                    ClearInterval(specinterval)
                    ClearInterval(controlInterval)
                    controlInterval = nil
                    specinterval = nil
                    targetPly = nil
                    targetPed = nil
                    RequestCollisionAtCoord(lastPos)
                    FreezeEntityPosition(ped, false)
                    SetEntityCoords(ped, lastPos)
                    SetEntityVisible(ped, true)
                    FreezeEntityPosition(ped, false)
                    lib.hideTextUI()
                end
            end, selectedPlayer)
            showPlyInfo = function(data)
                lib.showTextUI(data, {position = "top-center"})
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "OnlinePlyOptions_SpectatePlayer")
end)

RegisterNetEvent("esx_adminmenu:VehiclesRelatedOptionsMenu", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            lib.registerContext({
                id = "vehicle_related_options",
                title = "🚙 Vehicle Related Options",
                menu = "admin_menu",
                options = {
                    ["🚙 Delete Vehicle Radius"] = {event = "esx_adminmenu:client:DeleteVehicle", description = "Delete vehicles in radius"},
                    ["🚙 Unlock Vehicle"] = {event = "esx_adminmenu:client:UnlockVehicle", description = "Unlock Closest Vehicle"},
                    ["🚙 Spawn Custom Vehicle"] = {event = "esx_adminmenu:client:SpawnCustomVehicle", description = "Spawn Custom Veh"},
                    ["🚙 Vehicle Options"] = {event = "esx_adminmenu:client:VehicleOptions", description = "Vehicle Options"}
                }
            })
            lib.showContext("vehicle_related_options")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions")
end)

RegisterNetEvent("esx_adminmenu:client:DeleteVehicle", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local input = lib.inputDialog("TS Admin Menu", {"Radius"})
            if input then
                local radius = input[1]
                if radius == nil then
                    return
                end
                TriggerServerEvent("esx_adminmenu:server:DeleteVehicle", radius)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_DeleteVehicle")
end)

RegisterNetEvent("esx_adminmenu:client:UnlockVehicle", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local vehicle = ESX.Game.GetClosestVehicle()
            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_UnlockVehicle")
end)

RegisterNetEvent("esx_adminmenu:client:SpawnCustomVehicle", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local input = lib.inputDialog("TS Admin Menu", {"Vehicle Code"})
            if input then
                local vehiclename = input[1]
                if vehiclename == nil then
                    return TriggerServerEvent("esx_adminmenu:server:SpawnVehicle", "baller2")
                end
                TriggerServerEvent("esx_adminmenu:server:SpawnVehicle", vehiclename)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_SpawnCustomVehicle")
end)

RegisterNetEvent("esx_adminmenu:client:VehicleOptions", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            lib.registerContext({
                id = "vehicle_options",
                title = "🚙 Vehicle Options",
                menu = "vehicle_related_options",
                options = {
                    ["🧊 Freeze Vehicle"] = {event = "esx_adminmenu:toggle_FreezeVehicle", description = "Freeze Vehicle"},
                    ["🚧 Toggle Engine"] = {event = "esx_adminmenu:toggle_Engine", description = "Toggle Engine"},
                    ["⌨️ Change Numberplate"] = {event = "esx_adminmenu:ChangeNumberPlate", description = "Change Number Plate Text"},
                    ["🚗 Flip Vehicle"] = {event = "esx_adminmenu:FlipVehicle", description = "Set Vehicle Properly"},
                    ["🚗 Delete Vehicle"] = {event = "esx_adminmenu:DeleteVehiclePlayer", description = "Delete Vehicle you are in"},
                    ["💪 Vehicle Godmode"] = {event = "esx_adminmenu:VehicleGodMode", description = "Vehicle Godmode"},
                    ["🛠 Repair Vehicle"] = {event = "esx_adminmenu:RepairVehicle", description = "Repair Vehicle"},
                    ["🚿 Wash Vehicle"] = {event = "esx_adminmenu:WashVehicle", description = "Wash Vehicle"},
                    ["🚿 Keep Vehicle Clean"] = {event = "esx_adminmenu:KeepVehicleClean", description = "Keep Vehicle Clean"}
                }
            })
            lib.showContext("vehicle_options")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_VehicleOptions")
end)

local FreezeVehicle = false

RegisterNetEvent("esx_adminmenu:toggle_FreezeVehicle", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if FreezeVehicle then
                FreezeVehicle = false
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                FreezeEntityPosition(veh, false)
            else
                FreezeVehicle = true
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                FreezeEntityPosition(veh, true)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_FreezeVehicle")
end)

local Engine = false

RegisterNetEvent("esx_adminmenu:toggle_Engine", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if Engine then
                Engine = false
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                SetVehicleEngineOn(veh, false, true, true)
            else
                Engine = true
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                SetVehicleEngineOn(veh, true, true, true)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_Engine")
end)

RegisterNetEvent("esx_adminmenu:ChangeNumberPlate", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local input = lib.inputDialog("TS Admin Menu", {"Number Plate Text"})
            if input then
                local platenumber = input[1]
                if platenumber == nil then
                    return 
                end
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                if veh ~= 0 then
                    SetVehicleNumberPlateText(veh, platenumber)
                end
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_ChangeNumberPlate")
end)

RegisterNetEvent("esx_adminmenu:FlipVehicle", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            SetVehicleOnGroundProperly(veh)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_FlipVehicle")
end)

RegisterNetEvent("esx_adminmenu:DeleteVehiclePlayer", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            TriggerServerEvent("esx_adminmenu:server:DeleteVehicle")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_DeleteVehiclePlayer")
end)

local VehicleGodMode = false
local vehgod = nil

RegisterNetEvent("esx_adminmenu:VehicleGodMode", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if VehicleGodMode then
                VehicleGodMode = false
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                SetEntityInvincible(veh, false)
                SetVehicleEngineCanDegrade(veh, true)
                SetVehicleCanBeVisiblyDamaged(veh, true)
                SetVehicleWheelsCanBreak(veh, true)
                SetVehicleHasStrongAxles(veh, false)
                SetVehicleTyresCanBurst(veh, true)
                SetDisableVehicleEngineFires(veh, false)
                ClearInterval(vehgod)
            else
                VehicleGodMode = true
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                SetEntityInvincible(veh, true)
                SetVehicleEngineCanDegrade(veh, false)
                SetVehicleCanBeVisiblyDamaged(veh, false)
                SetVehicleWheelsCanBreak(veh, false)
                SetVehicleHasStrongAxles(veh, true)
                SetVehicleTyresCanBurst(veh, false)
                SetDisableVehicleEngineFires(veh, true)
                vehgod = SetInterval(function()
                    if IsVehicleDamaged(veh) then
                        RemoveDecalsFromVehicle(veh)
                        SetVehicleFixed(veh)
                        SetVehicleDeformationFixed(veh)
                    end
                    if IsVehicleEngineOnFire(veh) then
                        SetDisableVehicleEngineFires(veh, true)
                    end
                    if ESX.Math.Round(GetVehicleEngineHealth(veh), 1) < 1000 then
                        SetVehicleFixed(veh)
                        SetVehicleEngineHealth(veh, 4000)
                    end
                end, 0)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_VehicleGodMode")
end)

RegisterNetEvent("esx_adminmenu:RepairVehicle", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if veh ~= 0 then
                SetVehicleFixed(veh)
                SetVehicleDeformationFixed(veh)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_RepairVehicle")
end)

RegisterNetEvent("esx_adminmenu:WashVehicle", function(data)
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if veh ~= 0 then
                SetVehicleDirtLevel(veh, 0.0)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_WashVehicle")
end)

local KeepVehicleClean = false
local keepclean = nil

RegisterNetEvent("esx_adminmenu:KeepVehicleClean", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if KeepVehicleClean then
                KeepVehicleClean = false
                ClearInterval(keepclean)
            else
                KeepVehicleClean = true
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                keepclean = SetInterval(function()
                    if GetVehicleDirtLevel(veh) > 0.0 then
                        SetVehicleDirtLevel(veh, 0.0)
                    end
                end, 0)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "VehicleRelatedOptions_KeepVehicleClean")
end)

RegisterNetEvent("esx_adminmenu:PlayerRelatedOptionsMenu", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            lib.registerContext({
                id = "player_related_options",
                title = "🧍‍♂️ Player Related Options",
                menu = "admin_menu",
                options = {
                    ["🧍‍♂️ Player Options"] = {event = "esx_adminmenu:client:PlayerOptions", description = "Player Options"},
                    ["🧍‍♂️ Ped Options"] = {event = "esx_adminmenu:client:PedOptions", description = "Ped Options"}
                }
            })
            lib.showContext("player_related_options")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions")
end)

RegisterNetEvent("esx_adminmenu:client:PlayerOptions", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            lib.registerContext({
                id = "player_options",
                title = "🧍‍♂️ Player Options",
                menu = "player_related_options",
                options = {
                    ["💪 Godmode"] = {event = "esx_adminmenu:toggle_GodMode", description = "Godmode"},
                    ["👀 Invisible"] = {event = "esx_adminmenu:toggle_Invisible", description = "Invisible"},
                    ["🏃🏻‍♀️ Unlimited Stamina"] = {event = "esx_adminmenu:toggle_Stamina", description = "Unlimited Stamina"},
                    ["🏊🏻‍♂️ Fast Swim"] = {event = "esx_adminmenu:toggle_FastSwim", description = "Fast Swim"},
                    ["🏃‍♀️ Super Jump"] = {event = "esx_adminmenu:toggle_SuperJump", description = "Super Jump"},
                    ["🏃‍♀️ No Ragdoll"] = {event = "esx_adminmenu:toggle_NoRagDoll", description = "No Ragdoll"},
                    ["💙 Set Armor"] = {event = "esx_adminmenu:SetArmor", description = "Set Armor"},
                    ["🚿 Clean Player Clothes"] = {event = "esx_adminmenu:CleanPlayerClothes", description = "Clean Player Clothes"},
                    ["🧺 Wet Player Clothes"] = {event = "esx_adminmenu:WetPlayerClothes", description = "Wet Player Clothes"},
                    ["🔅 Dry Player Clothes"] = {event = "esx_adminmenu:DryPlayerClothes", description = "Dry Player Clothes"},
                    ["💀 Commit Suicide"] = {event = "esx_adminmenu:CommitSuicide", description = "Commit Suicide"},
                    ["🧊 Freeze Player"] = {event = "esx_adminmenu:FeezePlayer", description = "Freeze Player"},
                    ["🪂 Toggle Noclip"] = {event = "esx_adminmenu:toggle_noclip", description = "Toggle Noclip"}
                }
            })
            lib.showContext("player_options")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_PlayerOptions")
end)

local GodMode = false
local god = nil

RegisterNetEvent("esx_adminmenu:toggle_GodMode", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if GodMode then
                GodMode = false
                SetPedCanRagdoll(PlayerPedId(), true)
                SetPedDiesWhenInjured(PlayerPedId(), true)
                SetPedDiesInstantlyInWater(PlayerPedId(), true)
                SetPedDiesInVehicle(PlayerPedId(), true)
                SetPedDiesInSinkingVehicle(PlayerPedId(), true)
                ClearInterval(god)
            else
                GodMode = true
                local ped = PlayerPedId()
                local maxh = GetEntityMaxHealth(ped)
                SetPedCanRagdoll(ped, false)
                SetPedDiesWhenInjured(ped, false)
                SetPedDiesInstantlyInWater(ped, false)
                SetPedDiesInVehicle(ped, false)
                SetPedDiesInSinkingVehicle(ped, false)
                god = SetInterval(function()
                    if CanPedRagdoll(PlayerPedId()) then
                        SetPedCanRagdoll(PlayerPedId(), false)
                    end
                    if GetEntityHealth(ped) < maxh then
                        SetEntityHealth(PlayerPedId(), maxh)
                    end
                end, 0)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_GodMode")
end)

local Invisible = false

RegisterNetEvent("esx_adminmenu:toggle_Invisible", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if Invisible then
                Invisible = false
                SetEntityVisible(PlayerPedId(), true, 0)
                SetPedAudioFootstepLoud(PlayerPedId(), true)
                SetPedAudioFootstepQuiet(PlayerPedId(), true)
            else
                Invisible = true
                SetEntityVisible(PlayerPedId(), false, 0)
                SetPedAudioFootstepLoud(PlayerPedId(), false)
                SetPedAudioFootstepQuiet(PlayerPedId(), false)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_Invisible")
end)

local Stamina = false
local stam = nil

RegisterNetEvent("esx_adminmenu:toggle_Stamina", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if Stamina then
                Stamina = false
                ClearInterval(stam)
            else
                Stamina = true
                stam = SetInterval(function()
                    RestorePlayerStamina(PlayerId(), 1.0)
                end, 100)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_Stamina")
end)

local FastSwim = false

RegisterNetEvent("esx_adminmenu:toggle_FastSwim", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if FastSwim then
                FastSwim = false
                SetSwimMultiplierForPlayer(PlayerId(), 1.0)
            else
                FastSwim = true
                SetSwimMultiplierForPlayer(PlayerId(), 1.49)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_FastSwim")
end)

local SuperJumpp = false
local superjump = nil

RegisterNetEvent("esx_adminmenu:toggle_SuperJump", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if SuperJumpp then
                SuperJumpp = false
                ClearInterval(superjump)
            else
                SuperJumpp = true
                superjump = SetInterval(function()
                    SetSuperJumpThisFrame(PlayerId())
                end, 0)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_SuperJump")
end)

local NoRagDoll = false
local ragdoll = nil

RegisterNetEvent("esx_adminmenu:toggle_NoRagDoll", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if NoRagDoll then
                NoRagDoll = false
                SetPedCanRagdollFromPlayerImpact(PlayerPedId(), true)
                SetPedCanRagdoll(PlayerPedId(), true)
                ClearInterval(ragdoll)
            else
                NoRagDoll = true
                ragdoll = SetInterval(function()
                    SetPedCanRagdoll(PlayerPedId(), false)
                    SetPedCanRagdollFromPlayerImpact(PlayerPedId(), false)
                end, 0)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_NoRagDoll")
end)

RegisterNetEvent("esx_adminmenu:SetArmor", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local input = lib.inputDialog("Set Armor", {
                {
                    type = "select",
                    label = "Select Armor",
                    options = {
                        {value = "20% Armor", label = "Super Light Armor"},
                        {value = "40% Armor", label = "Light Armor"},
                        {value = "60% Armor", label = "Standard Armor"},
                        {value = "80% Armor", label = "Heavy Armor"},
                        {value = "100% Armor", label = "Super Heavy Armor"}
                    }
                }
            })
            if input[1] == "20% Armor" then
                SetPedArmour(PlayerPedId(), 20)
            elseif input[1] == "40% Armor" then
                SetPedArmour(PlayerPedId(), 40)
            elseif input[1] == "60% Armor" then
                SetPedArmour(PlayerPedId(), 60)
            elseif input[1] == "80% Armor" then
                SetPedArmour(PlayerPedId(), 80)
            elseif input[1] == "100% Armor" then
                SetPedArmour(PlayerPedId(), 100)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_SetArmor")
end)

RegisterNetEvent("esx_adminmenu:CleanPlayerClothes", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            ClearPedBloodDamage(PlayerPedId())
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_CleanPlayerClothes")
end)

RegisterNetEvent("esx_adminmenu:WetPlayerClothes", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            SetPedWetnessHeight(PlayerPedId(), 2.0)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_WetPlayerClothes")
end)

RegisterNetEvent("esx_adminmenu:DryPlayerClothes", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            ClearPedWetness(PlayerPedId())
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_DryPlayerClothes")
end)

RegisterNetEvent("esx_adminmenu:CommitSuicide", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            SetEntityHealth(PlayerPedId(), 0.0)
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_CommitSuicide")
end)

local FeezePlayer = false

RegisterNetEvent("esx_adminmenu:FeezePlayer", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if FeezePlayer then
                FeezePlayer = false
                FreezeEntityPosition(PlayerPedId(), false)
            else
                FeezePlayer = true
                FreezeEntityPosition(PlayerPedId(), true)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_FeezePlayer")
end)

local Noclip = false

RegisterNetEvent("esx_adminmenu:toggle_noclip", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            if Noclip then
                Noclip = false
                SetNoClip(false)
            else
                Noclip = true
                SetNoClip(true)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_Noclip")
end)

local SetPlayerSkin = function(ped)
    local modelHash = GetHashKey(ped)
    if IsModelInCdimage(modelHash) and IsModelValid(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
        end
        if GetEntityModel(PlayerPedId()) ~= modelHash then
            SetPlayerModel(PlayerId(), modelHash)
            SetModelAsNoLongerNeeded(modelHash)
            SetPedDefaultComponentVariation(PlayerPedId())
            ClearAllPedProps(PlayerPedId())
            ClearPedDecorations(PlayerPedId())
            ClearPedFacialDecorations(PlayerPedId())
        end
    end
end

RegisterNetEvent("esx_adminmenu:client:PedOptions", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            lib.registerContext({
                id = "ped_options",
                title = "🧍‍♂️ Ped Options",
                menu = "player_related_options",
                options = {
                    ["👕 Change Appearance"] = {event = "esx_mroupa:openSaveableMenu", description = "Change Ped Appearance"},
                    ["👦🏻 Change To Addon Ped"] = {event = "esx_adminmenu:client:ChangePed", description = "Change Ped Model"}
                }
            })
            lib.showContext("ped_options")
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions")
end)

RegisterNetEvent("esx_adminmenu:client:ChangePed", function()
    ESX.TriggerServerCallback("esx_adminmenu:server:IsAllowed", function(allowed)
        if allowed then
            local input = lib.inputDialog("TS Admin Menu", {"Model Name"})
            if input then
                local ped = input[1]
                SetPlayerSkin(ped)
            end
        else
            lib.notify({title = "TS Admin Menu", description = "You are not an Admin", type = "error"})
        end
    end, "PlayerRelatedOptions_ChangePed")
end)