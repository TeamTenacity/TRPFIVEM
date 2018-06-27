-- Created by Murtaza

RegisterNetEvent('murtaza:fix')

AddEventHandler('murtaza:fix',function()
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleEngineHealth(vehicle, 9999)
		SetVehiclePetrolTankHealth(vehicle, 9999)
		SetVehicleFixed(vehicle)
		notification('~g~Your vehicle has been fixed!')
	else
		notification('~r~You are not in a vehicle!')
	end
end)

function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)
  end
end)