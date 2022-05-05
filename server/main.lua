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

RegisterNetEvent("esx_adminmenu:server:ChangeSkin", function(ply)
    local yPlayer = ESX.GetPlayerFromId(ply)
    local xPlayer = ESX.GetPlayerFromId(source)
    --local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_ChangeSkin", "OnlinePlyOptions")
    yPlayer.triggerEvent("esx_mroupa:openSaveableMenu")
end)

RegisterNetEvent("esx_adminmenu:server:ShowInventory", function(id)
    local src = source
    local Ply = id
    --local allowed = CheckAllowed(src, "OnlinePlyOptions_OpenInventory", "OnlinePlyOptions")
    --if allowed then
        local inv = exports.ox_inventory:Inventory(tonumber(Ply))
        TriggerClientEvent("ox_inventory:viewInventory", src, inv)
    --end
end)

RegisterNetEvent("esx_adminmenu:server:TruckPunchlinePly", function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(data.id)
    --local allowed = CheckAllowed(xPlayer.source, "TrollMenu_Truck", "TrollMenu")
    --if allowed then
        TriggerClientEvent("esx_adminmenu:troll:TruckPunchline", yPlayer.source)
    --else
    --end
end)

RegisterNetEvent("esx_adminmenu:server:FakeCallply", function(data2)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(data2.id)
    --local allowed = CheckAllowed(xPlayer.source, "TrollMenu_FakeSound", "TrollMenu")
    --if allowed then
        TriggerClientEvent("esx_adminmenu:troll:FakeCall", yPlayer.source, data2.type)
    --else
    --end
end)

RegisterNetEvent("esx_adminmenu:server:Crashply", function(data2)
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPlayer = ESX.GetPlayerFromId(data2.id)
    --local allowed = CheckAllowed(xPlayer.source, "TrollMenu_Crash", "TrollMenu")
    --if allowed then
        TriggerClientEvent("esx_adminmenu:troll:Crashply", yPlayer.source)
    --else
    --end
end)

ESX.RegisterServerCallback("esx_adminmenu:server:GetOnlinePlayers", function(source, cb)
    local players = ESX.GetPlayers()
    local plylist = {}
    for i = 1, #players, 1 do
  	local plytable = {source = players[i], name = GetPlayerName(players[i])}
        table.insert(plylist, plytable)
    end
    table.sort(plylist, function(a, b) return a.name:upper() < b.name:upper() end)
    cb(plylist)
end)