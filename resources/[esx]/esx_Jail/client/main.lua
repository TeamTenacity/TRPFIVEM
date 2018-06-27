local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                           = nil
local GUI                     = {}
GUI.Time                      = 0
local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

	PlayerData = xPlayer

	if PlayerData.job.name == 'police' then
		Config.Zones.EnterParloirPrison.Type = 1
		Config.Zones.ExitParloirPrison.Type = 1
		Config.Zones.EnterParloir.Type = 1
		Config.Zones.ExitParloir.Type = 1
		Config.Zones.EnterPrisoncop.Type = 1
	else
		Config.Zones.EnterParloirPrison.Type = 1
		Config.Zones.ExitParloirPrison.Type = 1
		Config.Zones.EnterParloir.Type = 1
		Config.Zones.ExitParloir.Type = 1
		Config.Zones.EnterPrisoncop.Type = -1
	end

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	
	PlayerData.job = job

	if PlayerData.job.name == 'police' then
		Config.Zones.EnterParloirPrison.Type = 1
		Config.Zones.ExitParloirPrison.Type = 1
		Config.Zones.EnterParloir.Type = 1
		Config.Zones.ExitParloir.Type = 1
		Config.Zones.EnterPrisoncop.Type = 1
	else
		Config.Zones.EnterParloirPrison.Type = 1
		Config.Zones.ExitParloirPrison.Type = 1
		Config.Zones.EnterParloir.Type = 1
		Config.Zones.ExitParloir.Type = 1
		Config.Zones.EnterPrisoncop.Type = -1
	end
end)

function PrisonToParloir()
	SetEntityCoords(GetPlayerPed(-1),  Config.Zones.SpawnParloirPrison.Pos.x,  Config.Zones.SpawnParloirPrison.Pos.y,  Config.Zones.SpawnParloirPrison.Pos.z)
end

function ParloirToPrison()
	SetEntityCoords(GetPlayerPed(-1),  Config.Zones.SpawnInterieurPrison.Pos.x,  Config.Zones.SpawnInterieurPrison.Pos.y,  Config.Zones.SpawnInterieurPrison.Pos.z)
end

function ComicoToParloir()
	SetEntityCoords(GetPlayerPed(-1),  Config.Zones.SpawnParloirinterior.Pos.x,  Config.Zones.SpawnParloirinterior.Pos.y,  Config.Zones.SpawnParloirinterior.Pos.z)
end

function ParloirToComico()
	SetEntityCoords(GetPlayerPed(-1),  Config.Zones.SpawnParloirExterieur.Pos.x,  Config.Zones.SpawnParloirExterieur.Pos.y,  Config.Zones.SpawnParloirExterieur.Pos.z)
end

function PrisonToParloirCop()
	SetEntityCoords(GetPlayerPed(-1),  Config.Zones.SpawnParloircopinterior.Pos.x,  Config.Zones.SpawnParloircopinterior.Pos.y,  Config.Zones.SpawnParloircopinterior.Pos.z)
end

function ParloirToPrisoncop()
	SetEntityCoords(GetPlayerPed(-1),  Config.Zones.SpawnPrisoncopinterior.Pos.x,  Config.Zones.SpawnPrisoncopinterior.Pos.y,  Config.Zones.SpawnPrisoncopinterior.Pos.z)
end

AddEventHandler('esx_jail:hasEnteredMarker', function(zone)

	------ Prison -------
	if zone == 'EnterParloirPrison' then
		if PlayerData.job.name == 'police' then
			CurrentAction = 'cop_tp_parloircop'
			CurrentActionMsg = _U('p_press_parloir_tp')
			CurrentActionData = {}
		else
			CurrentAction = 'p_tp_parloir'
			CurrentActionMsg = _U('p_press_parloir_tp')
			CurrentActionData = {}
		end
	end

	if zone == 'ExitParloirPrison' then
		CurrentAction = 'p_tp_parloir_exit'
		CurrentActionMsg = _U('p_press_parloir_tp_exit')
		CurrentActionData = {}
	end

	----- Parloir comico

	if zone == 'EnterParloir' then
		CurrentAction = 'c_tp_parloir'
		CurrentActionMsg = _U('c_press_parloir_tp')
		CurrentActionData = {}
	end

	if zone == 'ExitParloir' then
		CurrentAction = 'c_tp_parloir_exit'
		CurrentActionMsg = _U('c_press_parloir_tp_exit')
		CurrentActionData = {}
	end

	---- Police -----

	if zone == 'EnterPrisoncop' then
		CurrentAction = 'cop_tp_prisoncop'
		CurrentActionMsg = _U('cop_press_prison_tp')
		CurrentActionData = {}
	end

end)

AddEventHandler('esx_jail:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		if PlayerData.job ~= nil then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			for k,v in pairs(Config.Zones) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end

		end
	end
end)

-- Enter / Exit marker events
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

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_jail:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_jail:hasExitedMarker', LastZone)
		end

	end
end)

-- Key controls
Citizen.CreateThread(function()

	while playerJob == "" do
		Citizen.Wait(10)
	end

	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 300 and PlayerData.job ~= nil then
				
				if CurrentAction == 'p_tp_parloir' then
					PrisonToParloir()
				end

				if CurrentAction == 'p_tp_parloir_exit' then
					ParloirToPrison()
				end

				if CurrentAction == 'c_tp_parloir' then
					ComicoToParloir()
				end

				if CurrentAction == 'c_tp_parloir_exit' then
					ParloirToComico()
				end

				if CurrentAction == 'cop_tp_prisoncop' then
					ParloirToPrisoncop()
				end

				if CurrentAction == 'cop_tp_parloircop' then
					PrisonToParloirCop()
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()
			end
		end
	end
end)