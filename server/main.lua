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
        --print("tu n és admin")
    end
end)

RegisterNetEvent("esx_adminmenu:server:ChangeSkin", function(ply)
    local yPlayer = ESX.GetPlayerFromId(ply)
    local xPlayer = ESX.GetPlayerFromId(source)
    local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_ChangeSkin", "OnlinePlyOptions")
    if allowed then
        yPlayer.triggerEvent("esx_mroupa:openSaveableMenu")
    else
        --print("tu n és admin")
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
        --print("tu n és admin")
    end
end)

ESX.RegisterServerCallback("esx_adminmenu:server:GetJobs", function(source, cb)
    local jobs = ESX.GetJobs()
    cb(jobs)
end)
