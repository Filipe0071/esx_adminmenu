local TSAdmins = {}

RegisterNetEvent("onResourceStart", function()
    for k, v in ipairs(Admins) do
        TSAdmins[v] = {
            permission = {OpenAdminmenu = true}
        }
        for i, j in ipairs(FullAccess) do
            if TSAdmins[j] then
                TSAdmins[j].permission.FullAccess = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_SendMessage) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_SendMessage = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_ChangeSkin) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_ChangeSkin = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_OpenInventory) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_OpenInventory = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_SetJob) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_SetJob = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_GiveItem) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_GiveItem = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_RemoveInventoryItem) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_RemoveInventoryItem = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_GiveMoney) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_GiveMoney = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_RemoveMoney) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_RemoveMoney = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_License) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_License = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_Heal) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_Heal = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_Revive) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_Revive = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_Goto) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_Goto = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_Bring) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_Bring = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_PRINTID) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_PRINTID = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_KillPlayer) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_KillPlayer = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_KickPlayer) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_KickPlayer = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_ScreenShopPlayer) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_ScreenShopPlayer = true
            end
        end
        for i, j in ipairs(OnlinePlyOptions_SpectatePlayer) do
            if TSAdmins[j] then
                TSAdmins[j].permission.OnlinePlyOptions_SpectatePlayer = true
            end
        end
    end
end)

CheckAllowed = function(source, type, type2)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local group = xPlayer.getGroup()
    local identifier = xPlayer.getIdentifier()
    local tonyaction = type
    local tonyaction2 = type2
    local allowed = false
    if group == "admin" or group == "superadmin" then
        allowed = true
    else
        if TSAdmins[identifier] then
            if TSAdmins[identifier].permission[tonyaction] or TSAdmins[identifier].permission[tonyaction2] or
                TSAdmins[identifier].permission.FullAccess then
                allowed = true
                goto continue
            end
        else
            for k, v in pairs(GetPlayerIdentifiers(xPlayer.source)) do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then
                    if TSAdmins[v] then
                        if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or
                            TSAdmins[v].permission.FullAccess then
                            allowed = true
                            goto continue
                        end
                    end
                elseif string.sub(v, 1, string.len("license:")) == "license:" then
                    if TSAdmins[v] then
                        if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or
                            TSAdmins[v].permission.FullAccess then
                            allowed = true
                            goto continue
                        end
                    end
                elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                    if TSAdmins[v] then
                        if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or
                            TSAdmins[v].permission.FullAccess then
                            allowed = true
                            goto continue
                        end
                    end
                elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                    if TSAdmins[v] then
                        if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or
                            TSAdmins[v].permission.FullAccess then
                            allowed = true
                            goto continue
                        end
                    end
                elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                    if TSAdmins[v] then
                        if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or
                            TSAdmins[v].permission.FullAccess then
                            allowed = true
                            goto continue
                        end
                    end
                elseif string.sub(v, 1, string.len("live:")) == "live:" then
                    if TSAdmins[v] then
                        if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or
                            TSAdmins[v].permission.FullAccess then
                            allowed = true
                            goto continue
                        end
                    end
                end
            end
        end
    end
    ::continue::
    return allowed
end

ESX.RegisterServerCallback("esx_adminmenu:server:IsAllowed", function(source, cb, action, action2)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local allowed = false
    if xPlayer then
        local group = xPlayer.getGroup()
        local identifier = xPlayer.getIdentifier()
        local tonyaction = action
        local tonyaction2 = action2 or action
        if group == "admin" or group == "superadmin" then
            allowed = true
        else
            if TSAdmins[identifier] then
                if TSAdmins[identifier].permission[tonyaction] or TSAdmins[identifier].permission[tonyaction2] or TSAdmins[identifier].permission.FullAccess then
                    allowed = true
                    goto continue
                end
            else
                for k, v in pairs(GetPlayerIdentifiers(xPlayer.source)) do
                    if string.sub(v, 1, string.len("steam:")) == "steam:" then
                        if TSAdmins[v] then
                            if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or TSAdmins[v].permission.FullAccess then
                                allowed = true
                                goto continue
                            end
                        end
                    elseif string.sub(v, 1, string.len("license:")) == "license:" then
                        if TSAdmins[v] then
                            if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or TSAdmins[v].permission.FullAccess then
                                allowed = true
                                goto continue
                            end
                        end
                    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                        if TSAdmins[v] then
                            if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or TSAdmins[v].permission.FullAccess then
                                allowed = true
                                goto continue
                            end
                        end
                    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                        if TSAdmins[v] then
                            if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or TSAdmins[v].permission.FullAccess then
                                allowed = true
                                goto continue
                            end
                        end
                    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                        if TSAdmins[v] then
                            if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or TSAdmins[v].permission.FullAccess then
                                allowed = true
                                goto continue
                            end
                        end
                    elseif string.sub(v, 1, string.len("live:")) == "live:" then
                        if TSAdmins[v] then
                            if TSAdmins[v].permission[tonyaction] or TSAdmins[v].permission[tonyaction2] or TSAdmins[v].permission.FullAccess then
                                allowed = true
                                goto continue
                            end
                        end
                    end
                end
            end
        end
    end
    ::continue::
    cb(allowed)
end)

local TSGetPlayers = function()
    local players = ESX.GetPlayers()
    local plylist = {}
    for i = 1, #players, 1 do
  	local plytable = {source = players[i], name = GetPlayerName(players[i])}
        table.insert(plylist, plytable)
    end
    table.sort(plylist, function(a, b) return a.name:upper() < b.name:upper() end)
    return plylist
end

lib.callback.register("esx_adminmenu:server:GetOnlinePlayers", function()
    return TSGetPlayers()
end)

RegisterNetEvent("esx_adminmenu:server:SendMessage", function(pid, msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local message = msg
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_SendMessage", "OnlinePlyOptions")
    if allowed then
        print(xPlayer.getName(), msg)
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:ChangeSkin", function(ply)
    local yPlayer = ESX.GetPlayerFromId(ply)
    local xPlayer = ESX.GetPlayerFromId(source)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_ChangeSkin", "OnlinePlyOptions")
    if allowed then
        yPlayer.triggerEvent("esx_mroupa:openSaveableMenu")
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:ShowInventory", function(ply)
    local src = source
    local Ply = ply
    local allowed = CheckAllowed(src, "OnlinePlyOptions_OpenInventory", "OnlinePlyOptions")
    if allowed then
        local inv = exports.ox_inventory:Inventory(tonumber(Ply))
        TriggerClientEvent("ox_inventory:viewInventory", src, inv)
    else
        print("tu n és admin")
    end
end)

ESX.RegisterServerCallback("esx_adminmenu:server:GetJobs", function(source, cb)
    local jobs = ESX.GetJobs()
    cb(jobs)
end)

RegisterNetEvent("esx_adminmenu:server:GiveItem", function(pid, item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = pid
    local titem = item
    local amount = count
    local yPlayer = ESX.GetPlayerFromId(playerId)
    local allowed = CheckAllowed(source, "OnlinePlyOptions_GiveItem", "OnlinePlyOptions")
    if allowed then
        exports.ox_inventory:AddItem(yPlayer.playerId, titem, amount, nil, nil, nil)
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:GetItems", function(pid)
    local src = source
    local playerId = pid
    local yPlayer = ESX.GetPlayerFromId(playerId)
    local item = exports.ox_inventory:Inventory(playerId).items
    local allowed = CheckAllowed(source, "OnlinePlyOptions_RemoveInventoryItem", "OnlinePlyOptions")
    if allowed then
        table.sort(item, function(a, b)
            return a.name:upper() < b.name:upper()
        end)
        TriggerClientEvent("esx_adminmenu:client:RemoveItem", src, pid, item)
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:RemoveItem", function(pid, item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = pid
    local yPlayer = ESX.GetPlayerFromId(playerId)
    local titem = item
    local amount = count
    local allowed = CheckAllowed(source, "OnlinePlyOptions_RemoveInventoryItem", "OnlinePlyOptions")
    if allowed then
        exports.ox_inventory:RemoveItem(yPlayer.playerId, titem, amount, nil, nil)
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:GiveAccMoney", function(pid, acc, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_GiveMoney", "OnlinePlyOptions")
    local account = acc
    local money = tonumber(amount)
    if allowed then
        if account == "money" or account == "bank" or account == "black_money" then
            yPlayer.addAccountMoney(account, money)
        end
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:RemoveAccMoney", function(pid, acc, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_RemoveMoney", "OnlinePlyOptions")
    local account = acc
    local money = tonumber(amount)
    if allowed then
        if account == "money" or account == "bank" or account == "black_money" then
            yPlayer.removeAccountMoney(account, money)
        end
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:ToggleLicense", function(playerId, license)
    local playerId = playerId
    local license = license
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(playerId)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_License", "OnlinePlyOptions")
    if allowed then
        local found = false
        TriggerEvent("esx_license:getLicensesList", function(licenses)
            for i, l in pairs(licenses) do
                if l.type == license then
                    found = true
                    TriggerEvent("esx_license:checkLicense", playerId, license, function(hasLicense)
                        if hasLicense then
                            TriggerEvent("esx_license:removeLicense", playerId, license)
                            print(yPlayer.getName(playerId) .. " " .. license .. " has been removed ")
                        else
                            TriggerEvent("esx_license:addLicense", playerId, license)
                            print(yPlayer.getName(playerId) .. " has been added the license " .. license)
                        end
                    end)
                end
            end
        end)
        Wait(3000)
        if not found then
            print("This License does not exist.")
        end
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:HealPlayer", function(pid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_Heal", "OnlinePlyOptions")
    if allowed then
        yPlayer.triggerEvent("esx_basicneeds:healPlayer")
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:RevivePlayer", function(pid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_Revive", "OnlinePlyOptions")
    if allowed then
        yPlayer.triggerEvent("esx_ambulancejob:revive")
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:Goto", function(pid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_Goto", "OnlinePlyOptions")
    local yPlyCoords = yPlayer.getCoords()
    if allowed then
        xPlayer.setCoords(yPlyCoords)
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:Bring", function(pid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local xPlyCoords = xPlayer.getCoords()
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_Bring", "OnlinePlyOptions")
    if allowed then
        yPlayer.setCoords(xPlyCoords)
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:PrintID", function(pid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_PRINTID", "OnlinePlyOptions")
    local steamid, license, xbl, ip, discord, liveid = nil, nil, nil, nil, nil, nil
    if allowed then
        for k, v in pairs(GetPlayerIdentifiers(yPlayer.source)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamid = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xbl = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                ip = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            end
        end
        TriggerClientEvent("esx_adminmenu:PrintID", xPlayer.source, steamid, license, xbl, ip, discord, liveid)
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:KillPlayer", function(pid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_KillPlayer", "OnlinePlyOptions")
    if allowed then
        TriggerClientEvent("esx_adminmenu:client:Kill", yPlayer.source)
    else
        print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:KickPlayer", function(pid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_KickPlayer", "OnlinePlyOptions")
    if allowed then
        yPlayer.kick("You Have been kicked from the server by: " .. xPlayer.getName())
    else
        print("tu n és admin")
    end
end)

lib.callback.register("esx_adminmenu:server:GetSpectateData", function(source, pid)
    local src = source
    local target = pid
    local pCoords = GetEntityCoords(GetPlayerPed(target))
    return pCoords
end)