RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
    local myId = PlayerId()
    local herId = GetPlayerFromServerId(id)
    if herId == myId then
        TriggerEvent('chatMessage', "", {0, 153, 204}, "^4" .. name .."".."^7: " .. message )
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(herId)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {0, 153, 204}, "^4" .. name .."".."^7: " .. message )
    end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
    local myId = PlayerId()
    local herId = GetPlayerFromServerId(id)
    if herId == myId then
        TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message )
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(herId)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message )
    end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
    local myId = PlayerId()
    local herId = GetPlayerFromServerId(id)
    if herId == myId then
        TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6*" .. message .."".."^6*  (" .. name .. "^6)")
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(herId)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6*" .. message .."".."^6*  (" .. name .. "^6)")
    end
end)

RegisterNetEvent('showid')
AddEventHandler('showid', function(id, name, message)
    local myId = PlayerId()
    local herId = GetPlayerFromServerId(id)
    if herId == myId then
        TriggerEvent('chatMessage', "", {255, 0, 0}, "^8| [ID] -^7 " .. name .. " ^8|")
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(herId)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {255, 0, 0}, "^8| [ID] -^7 " .. name .. " ^8|")
    end
end)

--RegisterNetEvent('sendProximityMessageLOOC')
--AddEventHandler('sendProximityMessageLOOC', function(id, name, message)
--    local myId = PlayerId()
--    local herId = GetPlayerFromServerId(id)
--    if herId == myId then
--        TriggerEvent('chatMessage', "", {128, 128, 128}, "L OOC | " .. name .."".."^7: " .. message )
--    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(herId)), true) < 19.999 then
--        TriggerEvent('chatMessage', "", {128, 128, 128}, "L OOC | " .. name .."".."^7: " .. message )
--    end
--end)