local tackleKey = 22 -- Change to a number which can be found here: https://wiki.fivem.net/wiki/Controls

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedJumping(PlayerPedId()) and IsControlJustPressed(0, tackleKey) then
			if IsPedInAnyVehicle(PlayerPedId()) then
				TriggerEvent('chatMessage', 'Tackle', {255, 255, 255}, 'You cannot tackle someone in a vehicle')
			else
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				SetPedToRagdollWithFall(PlayerPedId(), 1500, 2000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
				local stillGoing = IsPedRagdoll(PlayerPedId())
				local done = {}
				while stillGoing do
					Citizen.Wait(0)
					local tp = GetTouchedPlayer()
					stillGoing = IsPedRagdoll(PlayerPedId())
					for index, value in ipairs(tp) do
						if not done[index] then
							done[index] = true
							local playerID = GetPlayerServerId(value)
							TriggerServerEvent('tackleServer', playerID, ForwardVector.x, ForwardVector.y, ForwardVector.z)
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('tackleClient')
AddEventHandler('tackleClient', function(FVX, FVY, FVZ)
	message = math.random(1,5)
	if message == 1 then
		TriggerEvent('chatMessage', 'PoliceTackle', {255, 0, 0}, 'Take a load off.')
	elseif message == 2 then
		TriggerEvent('chatMessage', 'PoliceTackle', {255, 0, 0}, 'Take a seat.')
	elseif message == 3 then
		TriggerEvent('chatMessage', 'PoliceTackle', {255, 0, 0}, 'Take a nap, you earned it.')
	elseif message == 4 then
		TriggerEvent('chatMessage', 'PoliceTackle', {255, 0, 0}, 'Bedtime already?')
	elseif message == 5 then
		TriggerEvent('chatMessage', 'PoliceTackle', {255, 0, 0}, 'SIT YO ASS DOWN BOI')
	end
	Citizen.Wait(1)
	SetPedToRagdollWithFall(PlayerPedId(), 2000, 2000, 0, FVX, FVY, FVZ, 10.0, 500.0, 5000.0, 5000.0, 5000.0, 5000.0, 5000.0)
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetTouchedPlayer()
	local touchedPlayer = {}
    for index, value in ipairs(GetPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(), GetPlayerPed(value)) then
			table.insert(touchedPlayer, value)
		end
    end
    return touchedPlayer
end
