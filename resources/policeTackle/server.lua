RegisterServerEvent('tackleServer')
AddEventHandler('tackleServer', function(closestID, FVX, FVY, FVZ)
	TriggerClientEvent("tackleClient", closestID, FVX, FVY, FVZ)
end)
