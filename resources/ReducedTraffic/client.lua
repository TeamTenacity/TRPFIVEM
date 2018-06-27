local LastZone                = nil
local CurrentAction           = nil
local HasAlreadyEnteredMarker = false


Citizen.CreateThread(function()
    while true 
    	do
    		-- These natives has to be called every frame.
    	SetVehicleDensityMultiplierThisFrame(0.25)
		SetPedDensityMultiplierThisFrame(0.6)
		SetRandomVehicleDensityMultiplierThisFrame(0.1)
		SetParkedVehicleDensityMultiplierThisFrame(0.5)
		SetScenarioPedDensityMultiplierThisFrame(0.5, 0.7)
		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(20)
		
		--local playerPed = GetPlayerPed(-1)
		--local pos = GetEntityCoords(playerPed) 
		--RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
		
		
		-- These natives do not have to be called everyframe.
		--SetGarbageTrucks(0)
		--SetRandomBoats(0)
    	
		Citizen.Wait(1)
	end

end)

Citizen.CreateThread(function()
	Citizen.InvokeNative(0xDC0F817884CDD85, 1, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 5, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 7, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 8, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 9, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 11, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 4, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 6, false)
	Citizen.InvokeNative(0xDC0F817884CDD85, 12, false)
	Citizen.InvokeNative(0xC142BE3BB9CE125F, true)
	Citizen.InvokeNative(0xC142BE3BB9CE125F, -1)
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


function TeleportFadeEffect(entity, coords)

	Citizen.CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)
		end)

	end)

end

AddEventHandler('HasEnteredMarker', function(zone)

	if zone == 'Exit1' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.Outside.Pos)
	end

	if zone == 'Exit2' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.Outside2.Pos)
	end

	if zone == 'Entrance1' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.Inside.Pos)
	end

	if zone == 'ArmoryEnter' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.ArmoryIn.Pos)
	end

	if zone == 'ArmoryExit' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.ArmoryOut.Pos)
	end

	if zone == 'ClubEnter' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.InClub.Pos)
	end

	if zone == 'ClubExit' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.OutClub.Pos)
	end

	if zone == 'BarEnter' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.InBar.Pos)
	end

	if zone == 'BarExit' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.OutBar.Pos)
	end

	if zone == 'GarageEnter' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.InGarage.Pos)
	end

	if zone == 'GarageExit' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.OutGarage.Pos)
	end

	if zone == 'RanchEnter' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.InRanch.Pos)
	end

	if zone == 'RanchExit' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.OutRanch.Pos)
	end

	if zone == 'NewsEnter' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.InNews.Pos)
	end

	if zone == 'NewsExit' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.OutNews.Pos)
	end

end)

AddEventHandler('HasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do

			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end

	end
end)

Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone                = currentZone
			TriggerEvent('HasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('HasExitedMarker', lastZone)
		end

	end
end)
