--Coded by Albo1125.

local cJ = false
local eJE = false

RegisterNetEvent("JP")
AddEventHandler("JP", function(jT)
	if cJ == true then
		return
	end
	local pP = GetPlayerPed(-1)
	if DoesEntityExist(pP) then
		
		Citizen.CreateThread(function()
			local playerOldLoc = GetEntityCoords(pP, true)
			SetEntityCoords(pP, 1789.622, 2483.133, -123.301)
			cJ = true
			eJE = false
			while jT > 0 and not eJE do
				pP = GetPlayerPed(-1)
				RemoveAllPedWeapons(pP, true)
				SetEntityInvincible(pP, true)
				if IsPedInAnyVehicle(pP, false) then
					ClearPedTasksImmediately(pP)
				end
				if jT % 30 == 0 then
					TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, jT .." more seconds until release.")
				end
				Citizen.Wait(500)
				local pL = GetEntityCoords(pP, true)
				local D = Vdist(1789.622, 2483.133, -123.301, pL['x'], pL['y'], pL['z'])
				if D > 190 then
					SetEntityCoords(pP, 1789.622, 2483.133, -123.301)
					if D > 200 then
						jT = jT + 60
						--if jT > 1500 then
						--	jT = 1500
						--end
						TriggerEvent('chatMessage', 'JUDGE', { 0, 0, 0 }, "Your jail time was extended for an unlawful escape attempt.")
					end
				end
				jT = jT - 0.5
			end
			TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." was released from jail.")
			SetEntityCoords(pP, 1855.807, 2601.949, 45.323)
			cJ = false
			SetEntityInvincible(pP, false)
		end)
	end
end)

RegisterNetEvent("UnJP")
AddEventHandler("UnJP", function()
	eJE = true
end)
--Coded by Albo1125