function getPlayerList()
	local players = {}
	local plyList = ESX.GetExtendedPlayers()
	for k, v in pairs(plyList) do
		local job = v.job.name
		local jobText = v.job.label .. " - " .. v.job.grade_label
		table.insert(players, {serverId = v.playerId, name = v.name .. " (" .. GetPlayerName(v.playerId) .. ")", group = v.group, jobText = jobText})
	end
	return players
end

ESX.RegisterServerCallback("requestServerPlayers", function(source, cb)
	local xSource = ESX.GetPlayerFromId(source)
	--if not CheckAllowed(xSource.source, 'OnlinePlyOptions_Spectate', 'OnlinePlyOptions') then
		--return cb(false)
	--end
	cb(getPlayerList())
end)

ESX.RegisterServerCallback("requestPlayerCoords", function(source, cb, serverId)
	local targetPed = GetPlayerPed(serverId)
	if targetPed <= 0 then
		return cb(false)
	end
	cb(GetEntityCoords(targetPed))
end)

ESX.RegisterServerCallback("kickPlayerSpectate", function(source, cb, target)
	local xSource = ESX.GetPlayerFromId(source)
	local yPlayer = ESX.GetPlayerFromId(target)
	--if not CheckAllowed(xSource.source, 'OnlinePlyOptions_Spectate', 'OnlinePlyOptions') then
		--return
	--end
	DropPlayer(target, "Spectate menu ~ Admin: " .. GetPlayerName(source))
	cb(getPlayerList())
end)

RegisterNetEvent('fl_spectate:server:openSpectateMenu', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	--if not CheckAllowed(xPlayer.source, 'OnlinePlyOptions_Spectate', 'OnlinePlyOptions') then
		--return
	--end
	TriggerClientEvent("openSpectateMenu", xPlayer.source, getPlayerList())
end)