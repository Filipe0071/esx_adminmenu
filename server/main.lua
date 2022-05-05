local TSGetPlayers = function()
    local players = ESX.GetPlayers()
    local plylist = {}
    for i=1, #players, 1 do
  	local plytable = {source = players[i], name = GetPlayerName(players[i])}
        table.insert(plylist,plytable)
    end
    table.sort(plylist, function(a, b) return a.name:upper() < b.name:upper() end)
    return plylist
end
RegisterNetEvent("esx_adminmenu:server:SetPed", function(plyId, ped)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(plyId)
    local ped2 = ped
    --local allowed = CheckAllowed(xPlayer.source, "PlayerOptions_ChangePed", "PlayerOptions")
    --if yPlayer and allowed then
    if yPlayer then
        TriggerClientEvent("esx_adminmenu:client:SetPed", yPlayer.source, ped2)
    end
end)

RegisterNetEvent("esx_adminmenu:server:HealPlayer", function(pid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    --local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_Heal", "OnlinePlyOptions")
    --if allowed then
        yPlayer.triggerEvent("esx_basicneeds:healPlayer")
    --else
    --end
end)

RegisterNetEvent("esx_adminmenu:server:RevivePlayer", function(pid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(pid)
    --local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_Revive", "OnlinePlyOptions")
    --if allowed then
        yPlayer.triggerEvent("esx_ambulancejob:revive")
    --else
    --end
end)

local TSGetPlayers = function()
    local players = ESX.GetExtendedPlayers()
    local plylist = {}
    for i = 1, #players, 1 do
  	local plytable = {source = players[i], name = GetPlayerName(players[i])}
        table.insert(plylist, plytable)
    end
    return plylist
end

ESX.RegisterServerCallback('esx_adminmenu:server:GetOnlinePlayers', function(source, cb)
    cb(TSGetPlayers())
end)
