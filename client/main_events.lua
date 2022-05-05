RegisterNetEvent("esx_adminmenu:record", function()
    StartRecording(1)
    lib.notify({
        title = "Rockstar Editor",
        description = "Started recording",
        position = "top",
        duration = 5000,
        style = {
            backgroundColor = "green",
            color = "white"
        },
        icon = "fa-solid fa-circle-info",
        iconColor = "white"
    })
end)

RegisterNetEvent("esx_adminmenu:saveclip", function()
    StartRecording(0)
    StopRecordingAndSaveClip()
    lib.notify({
        title = "Rockstar Editor",
        description = "Saved recording",
        position = "top",
        duration = 5000,
        style = {
            backgroundColor = "green",
            color = "white"
        },
        icon = "fa-solid fa-circle-info",
        iconColor = "white"
    })
end)

RegisterNetEvent("esx_adminmenu:delclip", function()
    StopRecordingAndDiscardClip()
    lib.notify({
        title = "Rockstar Editor",
        description = "Discarded recording",
        position = "top",
        duration = 5000,
        style = {
            backgroundColor = "green",
            color = "white"
        },
        icon = "fa-solid fa-circle-info",
        iconColor = "white"
    })
end)

RegisterNetEvent("esx_adminmenu:editor", function()
    lib.notify({
        title = "Rockstar Editor",
        description = "Opening Rockstar Editor",
        position = "top",
        duration = 5000,
        style = {
            backgroundColor = "green",
            color = "white"
        },
        icon = "fa-solid fa-circle-info",
        iconColor = "white"
    })
    NetworkSessionLeaveSinglePlayer()
    ActivateRockstarEditor()
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

RegisterNetEvent("esx_adminmenu:client:SetPed", function(ped)
    SetPlayerSkin(ped)
end)

RegisterNetEvent("esx_adminmenu:client:ChangePed", function()
    local input = lib.inputDialog("TS Admin Menu", {"Player ID", "Model Name"})
    if input then
        local playerID = tonumber(input[1])
        local modelName = input[2]
        TriggerServerEvent("esx_adminmenu:server:SetPed", playerID, modelName)
    end
end)

RegisterNetEvent("esx_adminmenu:ttm", function()
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local playerPed = PlayerPedId()
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(playerPed, waypointCoords.x, waypointCoords.y, height + 0.0)
            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y,
                height + 0.0)
            if foundGround then
                SetPedCoordsKeepVehicle(playerPed, waypointCoords.x, waypointCoords.y, height + 0.0)
                break
            end

            Wait(5)
        end
        lib.notify({
            title = "Misc Settings",
            description = "Successfully Teleported",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "green",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    else
        lib.notify({
            title = "Misc Settings",
            description = "No Waypoint Set",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "blue",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    end
end)

RegisterNetEvent("esx_adminmenu:ttc", function()
    local input = lib.inputDialog("TS Admin Menu", {"Coords X", "Coords Y", "Coords Z"})
    if input then
        local cx = tonumber(input[1])
        local cy = tonumber(input[2])
        local cz = tonumber(input[3])
        if cx ~= nil and cy ~= nil and cz ~= nil then
            SetPedCoordsKeepVehicle(PlayerPedId(), vec3(tonumber(cx), tonumber(cy), tonumber(cz)))
        end
    end
end)

RegisterNetEvent("esx_adminmenu:ca", function()
    local coords = GetEntityCoords(PlayerPedId())
    ClearAreaLeaveVehicleHealth(coords.x, coords.y, coords.z, 100.0, false, false, false, false)
end)

RegisterNetEvent("esx_adminmenu:HealPlayer", function()
    TriggerServerEvent("esx_adminmenu:server:HealPlayer", GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent("esx_adminmenu:RevivePlayer", function()
    TriggerServerEvent("esx_adminmenu:server:RevivePlayer", GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent("esx_adminmenu:activate_noclip", function()
    SetNoClip(true)
end)

RegisterNetEvent("esx_adminmenu:disable_noclip", function()
    SetNoClip(false)
end)