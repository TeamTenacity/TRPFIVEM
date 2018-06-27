local playerColor = {0,0,0}

RegisterNetEvent('sendOOCMessage')
AddEventHandler('sendOOCMessage', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "LOOC | "..name, {128, 128, 128}, message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 19.999 then
		TriggerEvent('chatMessage', "LOOC | "..name, {128, 128, 128}, message)
	end
end)

RegisterNetEvent('sendGlobalMessage')
AddEventHandler('sendGlobalMessage', function(id, name, message)
	TriggerEvent('chatMessage', "OOC | "..name, {128, 128, 128}, message)
end) 

RegisterNetEvent('sendGlobalMessage2')
AddEventHandler('sendGlobalMessage2', function(id, name, message)
	TriggerEvent('chatMessage', "OOC | "..name, {128, 128, 128}, message)
end) 

RegisterNetEvent('sendGlobalMessage3')
AddEventHandler('sendGlobalMessage3', function(id, name, message)
	TriggerEvent('chatMessage', "^6[^1URP^6] ^6| ^6"..name, {128, 128, 128}, message)
end)