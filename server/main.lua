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

local TSGetNearbyEntities = function(entities, coords, modelFilter, maxDistance, isPed)
	local nearbyEntities = {}
	coords = type(coords) == "number" and GetEntityCoords(GetPlayerPed(coords)) or vector3(coords.x, coords.y, coords.z)
	for _, entity in pairs(entities) do
		if not isPed or (isPed and not IsPedAPlayer(entity)) then
			if not modelFilter or modelFilter[GetEntityModel(entity)] then
				local entityCoords = GetEntityCoords(entity)
				if not maxDistance or #(coords - entityCoords) <= maxDistance then
					nearbyEntities[#nearbyEntities+1] = {entity=entity, coords=entityCoords}
				end
			end
		end
	end
	return nearbyEntities
end

local TSGetVehiclesInArea = function(coords, maxDistance, modelFilter)
	return TSGetNearbyEntities(GetAllVehicles(), coords, modelFilter, maxDistance)
end

local TSSpawnVehicle = function(model, coords, heading, cb)
	if type(model) == "string" then
        model = GetHashKey(model)
    end
	CreateThread(function()
		local entity = Citizen.InvokeNative(`CREATE_AUTOMOBILE`, model, coords.x, coords.y, coords.z, heading)
		while not DoesEntityExist(entity) do
            Wait(50)
        end
		cb(entity)
	end)
end

RegisterNetEvent("esx_adminmenu:server:SpawnVehicle", function(veh)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerPed = GetPlayerPed(source)
    local model = veh
    local vehicle = GetVehiclePedIsIn(playerPed)
    --local allowed = CheckAllowed(source, "VehicleRelated_Spawner", "VehicleRelatedOptions")
    --if allowed then
        if vehicle then
            DeleteEntity(vehicle)
        end
        Wait(100)
        TSSpawnVehicle(model or `baller2`, GetEntityCoords(playerPed), GetEntityHeading(playerPed), function(car)
            local timeout = 50
            repeat
                Wait(0)
                timeout = timeout - 1
                SetPedIntoVehicle(playerPed, car, -1)
            until GetVehiclePedIsIn(playerPed, false) ~= 0 or timeout < 1
        end)
    --else
    --end
end)

RegisterNetEvent("esx_adminmenu:server:DeleteVehicle", function(radi)
    local xPlayer = ESX.GetPlayerFromId(source)
    --local allowed = CheckAllowed(xPlayer.source, "VehicleRelated_DeleteVehicle", "VehicleRelatedOptions")
    local radius = 1.0
    if radi then
        radius = tonumber(radi) + 0.0
    end
    local veh = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source))
    --if allowed then
        if veh ~= 0 then
            DeleteEntity(veh)
        else
            veh = TSGetVehiclesInArea(GetEntityCoords(GetPlayerPed(xPlayer.source)), radius)
            for i = 1, #veh do
                DeleteEntity(veh[i].entity)
            end
        end
        --TriggerClientEvent("esx_adminmenu:client:DeleteVehicle", xPlayer.source, radius)
    --else
    --end
end)

ESX.RegisterServerCallback("esx_adminmenu:server:GetJobs", function(source, cb)
    local jobs = ESX.GetJobs()
    cb(jobs)
end)

RegisterNetEvent("esx_adminmenu:server:SetJob", function(pid, job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = job
    local grade = tonumber(grade)
    local yPlayer = ESX.GetPlayerFromId(pid)
    --local allowed = CheckAllowed(xPlayer.source, "OnlinePlyOptions_SetJob", "OnlinePlyOptions")
    --if allowed then
        if ESX.DoesJobExist(job, grade) then
            yPlayer.setJob(job, grade)
        else
            --xPlayer.showNotification("Job or grade invalid!")
        end
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