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

RegisterNetEvent("esx_adminmenu:OpenInvPlayer", function()
    TriggerServerEvent("esx_adminmenu:server:ShowInventory", selectedPlayer)
end)

local noclip = false

RegisterNetEvent("esx_adminmenu:toggle_noclip", function()
    if noclip then
        noclip = false
        SetNoClip(false)
    else
        noclip = true
        SetNoClip(true)
    end
end)

local Godmode = false

RegisterNetEvent("esx_adminmenu:toggle_Godmode", function()
    if Godmode then
        Godmode = false
        SetPedCanRagdoll(PlayerPedId(), true)
        SetPedDiesWhenInjured(PlayerPedId(), true)
        SetPedDiesInstantlyInWater(PlayerPedId(), true)
        SetPedDiesInVehicle(PlayerPedId(), true)
        SetPedDiesInSinkingVehicle(PlayerPedId(), true)
        ClearInterval(god)
        lib.notify({
            title = "Toggle GodMode",
            description = "GodMode Disable",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "red",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    else
        Godmode = true
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
        lib.notify({
            title = "Toggle GodMode",
            description = "GodMode Enable",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "green",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    end
end)

local Invisible = false

RegisterNetEvent("esx_adminmenu:toggle_Invisible", function()
    if Invisible then
        Invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
        SetPedAudioFootstepLoud(PlayerPedId(), true)
        SetPedAudioFootstepQuiet(PlayerPedId(), true)
        lib.notify({
            title = "Toggle Invisible",
            description = "Invisible Disable",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "red",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    else
        Invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
        SetPedAudioFootstepLoud(PlayerPedId(), false)
        SetPedAudioFootstepQuiet(PlayerPedId(), false)
        lib.notify({
            title = "Toggle Invisible",
            description = "Invisible Enable",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "green",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    end
end)

local Stamina = false

RegisterNetEvent("esx_adminmenu:toggle_Stamina", function()
    if Stamina then
        Stamina = false
        ClearInterval(stam)
        lib.notify({
            title = "Toggle Stamina",
            description = "Stamina Disable",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "red",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    else
        Stamina = true
        stam = SetInterval(function()
            RestorePlayerStamina(PlayerId(), 1.0)
        end, 100)
        lib.notify({
            title = "Toggle Stamina",
            description = "Stamina Enable",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "green",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    end
end)

local FastRun = false

RegisterNetEvent("esx_adminmenu:toggle_FastRun", function()
    if FastRun then
        FastRun = false
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        lib.notify({
            title = "Toggle FastRun",
            description = "FastRun Disable",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "red",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    else
        FastRun = true
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
        lib.notify({
            title = "Toggle FastRun",
            description = "FastRun Enable",
            position = "top",
            duration = 5000,
            style = {
                backgroundColor = "green",
                color = "white"
            },
            icon = "fa-solid fa-circle-info",
            iconColor = "white"
        })
    end
end)

RegisterNetEvent("esx_adminmenu:client:ChangeSkin", function()
    TriggerServerEvent("esx_adminmenu:server:ChangeSkin", selectedPlayer)
end)

RegisterNetEvent("esx_adminmenu:troll:TruckPunchline", function()
    local playerPed = PlayerPedId()
    local pCoords = GetEntityCoords(playerPed)
    local pRot = GetEntityRotation(playerPed)
    RequestModel("rubble")
    repeat
        Wait(10)
    until HasModelLoaded("rubble")
    FreezeEntityPosition(playerPed, true)
    if IsPedInAnyVehicle(playerPed, false) then
        FreezeEntityPosition(GetVehiclePedIsIn(playerPed, false), true)
    end
    local arrowSpawn = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 3.0, 0.0)
    local vehSpawn = GetOffsetFromEntityInWorldCoords(playerPed, -10.0, 0.0, 0.0)
    local veh = CreateVehicle("rubble", vehSpawn, pRot.z - 90, true, false)
    DisableVehicleWorldCollision(veh)
    SetEntityCoords(veh, vehSpawn, 0.0, 0.0, pRot.z - 90.0, true)
    FreezeEntityPosition(veh, true)
    local i = 1
    local loop = 0
    local draw = true
    repeat
        i = i + 1
        if i == 1 then
            draw = true
        elseif i == 80 then
            draw = false
        elseif i == 160 then
            draw = false
            loop = loop + 1
            i = 0
        end
        if draw then
            DrawMarker(21, arrowSpawn.x, arrowSpawn.y, arrowSpawn.z + 0.5, 0.0, 0.0, 0.0, 0.0, 270.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 160, false, true, 2)
        end
        Wait(0)
    until (loop == 3)
    FreezeEntityPosition(veh, false)
    SetEntityRotation(veh, 0.0, 0.0, pRot.z - 90.0, 0, true)
    SetVehicleForwardSpeed(veh, 80.0)
    FreezeEntityPosition(playerPed, false)
    if IsPedInAnyVehicle(playerPed, false) then
        FreezeEntityPosition(GetVehiclePedIsIn(playerPed, false), false)
    end
    Wait(6000)
    SetEntityAsMissionEntity(veh, true, true)
    DeleteEntity(veh)
    FreezeEntityPosition(playerPed, false)
end)

RegisterNetEvent("esx_adminmenu:troll:Crashply", function()
    repeat
    until false
end)