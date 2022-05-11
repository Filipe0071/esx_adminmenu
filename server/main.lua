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
