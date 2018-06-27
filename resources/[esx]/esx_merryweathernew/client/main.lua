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

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local LastEntity                = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0
local IsGagged          = false
local IsShackled          = false

ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 2,
    modBrakes       = 2,
    modTransmission = 2,
    modSuspension   = 3,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function OpenCloakroomMenu()

  local elements = {
    { label = _U('citizen_wear'), value = 'citizen_wear' }
  }

  if PlayerData.job.grade_name == 'rook' then
    table.insert(elements, {label = _U('cadet_wear'), value = 'mw_wear'})
  end

  if PlayerData.job.grade_name == 'uniform' then
    table.insert(elements, {label = _U('cadet_wear'), value = 'mw_wear'})
  end

  if PlayerData.job.grade_name == 'fra' then
  	table.insert(elements, {label = _U('cadet_wear'), value = 'mw_wear'})
  	table.insert(elements, {label = _U('detective_wear'), value = 'detective_wear'})
    table.insert(elements, {label = _U('sheriff_wear'), value = 'sheriff_wear'})
  end

  if PlayerData.job.grade_name == 'personal' then
  	table.insert(elements, {label = _U('cadet_wear'), value = 'mw_wear'})
    table.insert(elements, {label = _U('detective_wear'), value = 'detective_wear'})
  end

  if PlayerData.job.grade_name == 'arrt' then
  	table.insert(elements, {label = _U('cadet_wear'), value = 'mw_wear'})
  	table.insert(elements, {label = _U('detective_wear'), value = 'detective_wear'})
  	table.insert(elements, {label = _U('sheriff_wear'), value = 'sheriff_wear'})
    table.insert(elements, {label = _U('lieutenant_wear'), value = 'lieutenant_wear'})
    table.insert(elements, {label = _U('commandant_wear'), value = 'commandant_wear'})
  end
  if PlayerData.job.grade_name == 'super' then
  	table.insert(elements, {label = _U('cadet_wear'), value = 'mw_wear'})
  	table.insert(elements, {label = _U('detective_wear'), value = 'detective_wear'})
  	table.insert(elements, {label = _U('sheriff_wear'), value = 'sheriff_wear'})
    table.insert(elements, {label = _U('lieutenant_wear'), value = 'lieutenant_wear'})
    table.insert(elements, {label = _U('commandant_wear'), value = 'commandant_wear'})
  end
  if PlayerData.job.grade_name == 'second' then
  	table.insert(elements, {label = _U('cadet_wear'), value = 'mw_wear'})
  	table.insert(elements, {label = _U('detective_wear'), value = 'detective_wear'})
  	table.insert(elements, {label = _U('sheriff_wear'), value = 'sheriff_wear'})
    table.insert(elements, {label = _U('lieutenant_wear'), value = 'lieutenant_wear'})
    table.insert(elements, {label = _U('commandant_wear'), value = 'commandant_wear'})
  end
  if PlayerData.job.grade_name == 'boss' then
  	table.insert(elements, {label = _U('cadet_wear'), value = 'mw_wear'})
  	table.insert(elements, {label = _U('detective_wear'), value = 'detective_wear'})
  	table.insert(elements, {label = _U('sheriff_wear'), value = 'sheriff_wear'})
    table.insert(elements, {label = _U('lieutenant_wear'), value = 'lieutenant_wear'})
    table.insert(elements, {label = _U('commandant_wear'), value = 'commandant_wear'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = _U('cloakroom'),
      align    = 'bottom-right',
      elements = elements,
    },
    function(data, menu)
      menu.close()

      --Taken from SuperCoolNinja
      if data.current.value == 'citizen_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          local model = nil

          if skin.sex == 0 then
            model = GetHashKey("mp_m_freemode_01")
          else
            model = GetHashKey("mp_f_freemode_01")
          end

          RequestModel(model)
          while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
          end

          SetPlayerModel(PlayerId(), model)
          SetModelAsNoLongerNeeded(model)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end)
      end

      if data.current.value == 'detective_wear' then

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

				if skin.sex == 0 then

					local model = GetHashKey("s_m_m_highsec_01") --[FR]--Pour changer de Mal Male veuillez changer Ici !
																  																												--[EN]--Here for change Ped Skin Model Here is for Man

					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
			else
					local model = GetHashKey("s_f_y_sheriff_01") --[FR]--Pour changer de Femal Male veuillez changer Ici !
																  																											--[EN]--Here for change Ped Skin Model Here is for Girl

					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
					end

        end)
      end


      if data.current.value == 'mw_wear' then

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

				if skin.sex == 0 then

					local model = GetHashKey("s_m_m_chemsec_01") --[FR]--Pour changer de Mal Male veuillez changer Ici !
																  																												--[EN]--Here for change Ped Skin Model Here is for Man

					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
			else
					local model = GetHashKey("s_f_y_sheriff_01") --[FR]--Pour changer de Femal Male veuillez changer Ici !
																  																											--[EN]--Here for change Ped Skin Model Here is for Girl

					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
					end

        end)
      end

      if data.current.value == 'sheriff_wear' then

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

				if skin.sex == 0 then
					local model = GetHashKey("s_m_y_blackops_01") --[FR]--Pour changer de Mal Male veuillez changer Ici !
																																											--[EN]--Here for change Ped Skin Model Here is for Man

					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
			else
					local model = GetHashKey("s_f_y_cop_01") --[FR]--Pour changer de Femal Male veuillez changer Ici !
																 																											--[EN]--Here for change Ped Skin Model Here is for Girl

					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
					end

				end)
			end
			--Taken from SuperCoolNinja
			if data.current.value == 'lieutenant_wear'  then --Ajout de tenue par grades

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

					if skin.sex == 0 then
					local model = GetHashKey("s_m_y_blackops_02") --[FR]--Pour changer de Mal Male veuillez changer Ici !
																																									--[EN]--Here for change Ped Skin Model Here is for Man
					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
			else
					local model = GetHashKey("s_f_y_ranger_01") --[FR]--Pour changer de Femal Male veuillez changer Ici !
																																									--[EN]--Here for change Ped Skin Model Here is for Girl

					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
					end

				end)
			end

			if data.current.value == 'commandant_wear'  then --Ajout de tenue par grades

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

					if skin.sex == 0 then
					local model = GetHashKey("s_m_y_blackops_03") --[FR]--Pour changer de Mal Male veuillez changer Ici !
																																									--[EN]--Here for change Ped Skin Model Here is for Man
					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
			else
					local model = GetHashKey("s_m_m_ciasec_01") --[FR]--Pour changer de Femal Male veuillez changer Ici !
																																									--[EN]--Here for change Ped Skin Model Here is for Girl

					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)
					end

				end)
			end

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end
  )

end

function OpenArmoryMenu(station)

  if Config.EnableArmoryManagement then

    local elements = {
      {label = _U('get_weapon'), value = 'get_weapon'},
      {label = _U('put_weapon'), value = 'put_weapon'},
      {label = 'Get Object',  value = 'get_stock'},
      {label = 'Put Object',  value = 'put_stock'}
    }

    if PlayerData.job.grade_name == 'boss' then
      table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'get_weapon' then
          OpenGetWeaponMenu()
        end

        if data.current.value == 'put_weapon' then
          OpenPutWeaponMenu()
        end

        if data.current.value == 'buy_weapons' then
          OpenBuyWeaponsMenu(station)
        end

        if data.current.value == 'put_stock' then
              OpenPutStocksMenu()
            end

            if data.current.value == 'get_stock' then
              OpenGetStocksMenu()
            end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
      end
    )

  else

    local elements = {}

    for i=1, #Config.MWHQs[station].AuthorizedWeapons, 1 do
      local weapon = Config.MWHQs[station].AuthorizedWeapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
        TriggerServerEvent('esx_merryweather:giveWeapon', weapon,  1000)
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}

      end
    )

  end

end

function OpenVehicleSpawnerMenu(station, partNum)

  local vehicles = Config.MWHQs[station].Vehicles

  ESX.UI.Menu.CloseAll()

  if Config.EnableSocietyOwnedVehicles then

    local elements = {}

    ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(garageVehicles)

      for i=1, #garageVehicles, 1 do
        table.insert(elements, {label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i]})
      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_spawner',
        {
          title    = _U('vehicle_menu'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

          menu.close()

          local vehicleProps = data.current.value

          ESX.Game.SpawnVehicle(vehicleProps.model, vehicles[partNum].SpawnPoint, 270.0, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
            local playerPed = GetPlayerPed(-1)
            TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
          end)

          TriggerServerEvent('esx_society:removeVehicleFromGarage', 'merryweather', vehicleProps)

        end,
        function(data, menu)

          menu.close()

          CurrentAction     = 'menu_vehicle_spawner'
          CurrentActionMsg  = _U('vehicle_spawner')
          CurrentActionData = {station = station, partNum = partNum}

        end
      )

    end, 'merryweather')

  else

    local elements = {}

    table.insert(elements, { label = 'Gresley (Civilian Patrol)', value = 'mwgresley' })
    table.insert(elements, { label = 'Premier (Civilian Patrol)', value = 'mwpremier' })
    table.insert(elements, { label = 'Stanier (Civilian Patrol)', value = 'mwstanier'})

    if PlayerData.job.grade_name == 'rook' then
      table.insert(elements, { label = 'Panto (Recruit)', value = 'securityp'})
    end

    if PlayerData.job.grade_name == 'uniform' then
      table.insert(elements, { label = 'Panto (Recruit)', value = 'securityp'})
      table.insert(elements, { label = 'Buffalo S (Uniformed Security)', value = 'security'})
      table.insert(elements, { label = 'Oracle (Uniformed Security)', value = 'security2'})
      table.insert(elements, { label = 'XLS (Uniformed Security)', value = 'security3'})
    end

    if PlayerData.job.grade_name == 'personal' then
      table.insert(elements, { label = 'Panto (Recruit)', value = 'securityp'})
      table.insert(elements, { label = 'Buffalo S (Uniformed Security)', value = 'security'})
      table.insert(elements, { label = 'Oracle (Uniformed Security)', value = 'security2'})
      table.insert(elements, { label = 'XLS (Uniformed Security)', value = 'security3'})
      table.insert(elements, { label = 'Karuma (PPU)', value = 'security7'})
      table.insert(elements, { label = 'Armored XLS (PPU)', value = 'security5'})
    end

    if PlayerData.job.grade_name == 'fra' then
      table.insert(elements, { label = 'Panto (Recruit)', value = 'securityp'})
      table.insert(elements, { label = 'Buffalo S (Uniformed Security)', value = 'security'})
      table.insert(elements, { label = 'Oracle (Uniformed Security)', value = 'security2'})
      table.insert(elements, { label = 'XLS (Uniformed Security)', value = 'security3'})
      table.insert(elements, { label = 'Karuma (PPU)', value = 'security7'})
      table.insert(elements, { label = 'Armored XLS (PPU)', value = 'security5'})
    end

    if PlayerData.job.grade_name == 'arrt' then
      table.insert(elements, { label = 'Panto (Recruit)', value = 'securityp'})
      table.insert(elements, { label = 'Buffalo S (Uniformed Security)', value = 'security'})
      table.insert(elements, { label = 'Oracle (Uniformed Security)', value = 'security2'})
      table.insert(elements, { label = 'XLS (Uniformed Security)', value = 'security3'})
      table.insert(elements, { label = 'Karuma (PPU)', value = 'security7'})
      table.insert(elements, { label = 'Armored XLS (PPU)', value = 'security5'})
      table.insert(elements, { label = 'Yosemite (K9)', value = 'securityt2'})
      table.insert(elements, { label = 'Cavalcade Mk. II (ARRT)', value = 'securityarrt1'})
      table.insert(elements, { label = 'Rumpo Trail (ARRT)', value = 'securityt'})
      table.insert(elements, { label = 'Nightshark (ARRT)', value = 'securityarrt2'})
      table.insert(elements, { label = 'Riot (ARRT)', value = 'securityarrt3'})
    end

   	if PlayerData.job.grade_name == 'super' then
      table.insert(elements, { label = 'Panto (Recruit)', value = 'securityp'})
      table.insert(elements, { label = 'Buffalo S (Uniformed Security)', value = 'security'})
      table.insert(elements, { label = 'Oracle (Uniformed Security)', value = 'security2'})
      table.insert(elements, { label = 'XLS (Uniformed Security)', value = 'security3'})
      table.insert(elements, { label = 'Karuma (PPU)', value = 'security7'})
      table.insert(elements, { label = 'Armored XLS (PPU)', value = 'security5'})
      table.insert(elements, { label = 'Yosemite (K9)', value = 'securityt2'})
      table.insert(elements, { label = 'Cavalcade Mk. II (ARRT)', value = 'securityarrt1'})
      table.insert(elements, { label = 'Rumpo Trail (ARRT)', value = 'securityt'})
      table.insert(elements, { label = 'Nightshark (ARRT)', value = 'securityarrt2'})
      table.insert(elements, { label = 'Riot (ARRT)', value = 'securityarrt3'})
    end

    if PlayerData.job.grade_name == 'second' then
      table.insert(elements, { label = 'Panto (Recruit)', value = 'securityp'})
      table.insert(elements, { label = 'Buffalo S (Uniformed Security)', value = 'security'})
      table.insert(elements, { label = 'Oracle (Uniformed Security)', value = 'security2'})
      table.insert(elements, { label = 'XLS (Uniformed Security)', value = 'security3'})
      table.insert(elements, { label = 'Karuma (PPU)', value = 'security7'})
      table.insert(elements, { label = 'Armored XLS (PPU)', value = 'security5'})
      table.insert(elements, { label = 'Yosemite (K9)', value = 'securityt2'})
      table.insert(elements, { label = 'Cavalcade Mk. II (ARRT)', value = 'securityarrt1'})
      table.insert(elements, { label = 'Rumpo Trail (ARRT)', value = 'securityt'})
      table.insert(elements, { label = 'Nightshark (ARRT)', value = 'securityarrt2'})
      table.insert(elements, { label = 'Riot (ARRT)', value = 'securityarrt3'})
    end

    if PlayerData.job.grade_name == 'boss' then
      table.insert(elements, { label = 'Panto (Recruit)', value = 'securityp'})
      table.insert(elements, { label = 'Buffalo S (Uniformed Security)', value = 'security'})
      table.insert(elements, { label = 'Oracle (Uniformed Security)', value = 'security2'})
      table.insert(elements, { label = 'XLS (Uniformed Security)', value = 'security3'})
      table.insert(elements, { label = 'Karuma (PPU)', value = 'security7'})
      table.insert(elements, { label = 'Armored XLS (PPU)', value = 'security5'})
      table.insert(elements, { label = 'Yosemite (K9)', value = 'securityt2'})
      table.insert(elements, { label = 'Cavalcade Mk. II (ARRT)', value = 'securityarrt1'})
      table.insert(elements, { label = 'Rumpo Trail (ARRT)', value = 'securityt'})
      table.insert(elements, { label = 'Nightshark (ARRT)', value = 'securityarrt2'})
      table.insert(elements, { label = 'Riot (ARRT)', value = 'securityarrt3'})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_spawner',
      {
        title    = _U('vehicle_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        local model = data.current.value

        local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x,  vehicles[partNum].SpawnPoint.y,  vehicles[partNum].SpawnPoint.z,  3.0,  0,  71)

        if not DoesEntityExist(vehicle) then

          local playerPed = GetPlayerPed(-1)

          if Config.MaxInService == -1 then

            ESX.Game.SpawnVehicle(model, {
              x = vehicles[partNum].SpawnPoint.x,
              y = vehicles[partNum].SpawnPoint.y,
              z = vehicles[partNum].SpawnPoint.z
            }, vehicles[partNum].Heading, function(vehicle)
              TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
              SetVehicleMaxMods(vehicle)
            end)

          else

            ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

              if canTakeService then

                ESX.Game.SpawnVehicle(model, {
                  x = vehicles[partNum].SpawnPoint.x,
                  y = vehicles[partNum].SpawnPoint.y,
                  z = vehicles[partNum].SpawnPoint.z
                }, vehicles[partNum].Heading, function(vehicle)
                  TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  SetVehicleMaxMods(vehicle)
                end)

              else
                ESX.ShowNotification(_U('service_max') .. inServiceCount .. '/' .. maxInService)
              end

            end, 'merryweather')

          end

        else
          ESX.ShowNotification(_U('vehicle_out'))
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = _U('vehicle_spawner')
        CurrentActionData = {station = station, partNum = partNum}

      end
    )

  end

end

function OpenPoliceActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'police_actions',
    {
      title    = 'Merryweather Menu',
      align    = 'bottom-right',
      elements = {
        {label = _U('citizen_interaction'), value = 'citizen_interaction'},
        {label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
        {label = _U('object_spawner'),      value = 'object_spawner'},
      },
    },
    function(data, menu)

      if data.current.value == 'citizen_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('citizen_interaction'),
            align    = 'bottom-right',
            elements = {
              {label = _U('id_card'),       value = 'identity_card'},
              {label = _U('search'),        value = 'body_search'},
              {label = _U('handcuff'),    value = 'handcuff'},
              {label = _U('shackle'),         value = 'shackle'},
              {label = 'Revive',        value = 'revive'},
              {label = _U('drag'),      value = 'drag'},
              {label = _U('put_in_vehicle'),  value = 'put_in_vehicle'},
              {label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
              {label = _U('fine'),            value = 'fine'},
              {label = _U('gag'),            value = 'gag'}
            },
          },
          function(data2, menu2)

            local player, distance = ESX.Game.GetClosestPlayer()

            if distance ~= -1 and distance <= 3.0 then

              if data2.current.value == 'identity_card' then
                OpenIdentityCardMenu(player)
              end

              if data2.current.value == 'body_search' then
                OpenBodySearchMenu(player)
              end

              if data2.current.value == 'handcuff' then
                TriggerServerEvent('esx_merryweather:handcuff', GetPlayerServerId(player))
              end

              if data2.current.value == 'shackle' then
                TriggerServerEvent('esx_merryweather:shackle', GetPlayerServerId(player))
              end

              if data2.current.value == 'gag' then
                TriggerServerEvent('esx_merryweather:gag', GetPlayerServerId(player))
              end

              if data2.current.value == 'drag' then
                TriggerServerEvent('esx_merryweather:drag', GetPlayerServerId(player))
              end

              if data2.current.value == 'put_in_vehicle' then
                TriggerServerEvent('esx_merryweather:putInVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'out_the_vehicle' then
                  TriggerServerEvent('esx_merryweather:OutVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'fine' then
                OpenFineMenu(player)
              end
              
              if data2.current.value == 'revive' then
                menu2.close()
              --  if ems == 0 then
                  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                     local ped    = GetPlayerPed(closestPlayer)
                     local health = GetEntityHealth(ped)
                
                  if health == 0 then

                  local playerPed        = GetPlayerPed(-1)
                  local closestPlayerPed = GetPlayerPed(closestPlayer)

                  Citizen.CreateThread(function()

                    ESX.ShowNotification('~b~Performing CPR on the subject...')

                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    Citizen.Wait(5000)
                    ClearPedTasks(playerPed)

                    if GetEntityHealth(closestPlayerPed) == 0 then
                      TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                      ESX.ShowNotification('~g~CPR completed')
                    else
                      ESX.ShowNotification('The subject is ~r~dead~s~.')
                    end

                  end)

                  else
                    ESX.ShowNotification('~r~The subject does not currently require ~b~CPR~s~.')
                  end
                --else
                --  ESX.ShowNotification('~r~There are EMS on duty. Please call them instead.')
                --end
              end

            else
              ESX.ShowNotification(_U('no_players_nearby'))
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'vehicle_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'vehicle_interaction',
          {
            title    = _U('vehicle_interaction'),
            align    = 'bottom-right',
            elements = {
              {label = _U('vehicle_info'), value = 'vehicle_infos'},
              {label = _U('pick_lock'),    value = 'hijack_vehicle'},
              {label = 'Tow', value = 'del_vehicle'},
              {label = 'Repair', value = 'fix_vehicle'},
            },
          },
          function(data2, menu2)
            if data2.current.value == 'del_vehicle' then
      
              local ped = GetPlayerPed( -1 )

              if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
                local pos = GetEntityCoords(ped)

                if (IsPedSittingInAnyVehicle(ped)) then 
                  local vehicle = GetVehiclePedIsIn(ped, false)

                  if (GetPedInVehicleSeat(vehicle, -1) == ped) then 
                      TriggerEvent('esx:showNotification', '~g~Vehicle Towed')
                      SetEntityAsMissionEntity(vehicle,  false,  true)
                      DeleteVehicle(vehicle)
                  else 
                    TriggerEvent('esx:showNotification', '~r~Could not tow vehicle')
                  end 
                else
                  local playerPed = GetPlayerPed(-1)
                  local coords    = GetEntityCoords(playerPed)
                  local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

                  if DoesEntityExist(vehicle) then
                    TriggerEvent('esx:showNotification', '~g~Vehicle Towed')
                      SetEntityAsMissionEntity(vehicle,  false,  true)
                      DeleteVehicle(vehicle)
                  else 
                    TriggerEvent('esx:showNotification', 'You must be near a ~b~vehicle~s~ to ~r~tow~s~ it.')
                  end 
                end 
              end
            end


            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

            if DoesEntityExist(vehicle) then

              local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

              if data2.current.value == 'vehicle_infos' then
                OpenVehicleInfosMenu(vehicleData)
              end

              if data.current.value == 'fix_vehicle' then
      
                    local playerPed = GetPlayerPed(-1)
                    local coords    = GetEntityCoords(playerPed)
                    
                    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
                      
                      local vehicle = nil

                      if IsPedInAnyVehicle(playerPed, false) then
                        vehicle = GetVehiclePedIsIn(playerPed, false)
                      else
                        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                      end
                      
                      if DoesEntityExist(vehicle) then
                        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                        Citizen.CreateThread(function()
                          Citizen.Wait(5000)
                          SetVehicleFixed(vehicle)
                          SetVehicleDeformationFixed(vehicle)
                          SetVehicleUndriveable(vehicle, false)
                          ClearPedTasksImmediately(playerPed)
                          TriggerEvent('esx:showNotification', '~g~Vehicle repaired')
                        end)
                      end
                    end
                  end

              if data2.current.value == 'hijack_vehicle' then

                local playerPed = GetPlayerPed(-1)
                local coords    = GetEntityCoords(playerPed)

                if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then

                  local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

                  if DoesEntityExist(vehicle) then

                    Citizen.CreateThread(function()

                      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)

                      Wait(20000)

                      ClearPedTasksImmediately(playerPed)

                      SetVehicleDoorsLocked(vehicle, 1)
                      SetVehicleDoorsLockedForAllPlayers(vehicle, false)

                      TriggerEvent('esx:showNotification', _U('vehicle_unlocked'))

                    end)

                  end

                end

              end

            else
              ESX.ShowNotification(_U('no_vehicles_nearby'))
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'object_spawner' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('traffic_interaction'),
            align    = 'bottom-right',
            elements = {
              {label = _U('cone'),     value = 'prop_roadcone02a'},
              --{label = _U('barrier'), value = 'prop_barrier_work05'},
              {label = _U('barrier2'), value = 'prop_mp_barrier_02'},
              {label = _U('barrier3'), value = 'prop_mp_barrier_02b'},
              --{label = _U('spikestrips'),    value = 'p_ld_stinger_s'}
              --{label = _U('box'),   value = 'prop_boxpile_07d'},
              --{label = _U('cash'),   value = 'hei_prop_cash_crate_half_full'}
            },
          },
          function(data2, menu2)


            local model     = data2.current.value
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local forward   = GetEntityForwardVector(playerPed)
            local x, y, z   = table.unpack(coords + forward * 1.0)

            if model == 'prop_roadcone02a' then
              z = z - 2.0
            end

            ESX.Game.SpawnObject(model, {
              x = x,
              y = y,
              z = z
            }, function(obj)
              SetEntityHeading(obj, GetEntityHeading(playerPed))
              PlaceObjectOnGroundProperly(obj)
            end)

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

    end,
    function(data, menu)

      menu.close()

    end
  )

end

function OpenIdentityCardMenu(player)

  if Config.EnableESXIdentity then

    ESX.TriggerServerCallback('esx_merryweather:getOtherPlayerData', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil

      if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Job : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Job : ' .. data.job.label
      end

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Male'
        else
          sex = 'Female'
        end
        sexLabel = 'Sex : ' .. sex
      else
        sexLabel = 'Sex : Unknown'
      end

      if data.dob ~= nil then
        dobLabel = 'DOB : ' .. data.dob
      else
        dobLabel = 'DOB : Unknown'
      end

      if data.height ~= nil then
        heightLabel = 'Height : ' .. data.height
      else
        heightLabel = 'Height : Unknown'
      end

      if data.name ~= nil then
        idLabel = 'ID : ' .. data.name
      else
        idLabel = 'ID : Unknown'
      end

      local elements = {
        {label = _U('name') .. data.firstname .. " " .. data.lastname, value = nil},
        {label = sexLabel,    value = nil},
        {label = dobLabel,    value = nil},
        {label = heightLabel, value = nil},
        {label = jobLabel,    value = nil},
        {label = idLabel,     value = nil},
      }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licenses ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  else

    ESX.TriggerServerCallback('esx_merryweather:getOtherPlayerData', function(data)

      local jobLabel = nil

      if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Job : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Job : ' .. data.job.label
      end

        local elements = {
          {label = _U('name') .. data.name, value = nil},
          {label = jobLabel,              value = nil},
        }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licenses ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'bottom-right',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  end

end

function OpenBodySearchMenu(player)

  ESX.TriggerServerCallback('esx_merryweather:getOtherPlayerData', function(data)

    local elements = {}

    local blackMoney = 0

    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

    table.insert(elements, {
      label          = _U('confiscate_dirty') .. blackMoney,
      value          = 'black_money',
      itemType       = 'item_account',
      amount         = blackMoney
    })

    table.insert(elements, {label = '--- Armes ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = _U('confiscate') .. ESX.GetWeaponLabel(data.weapons[i].name),
        value          = data.weapons[i].name,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end

    table.insert(elements, {label = _U('inventory_label'), value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = _U('confiscate_inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
          value          = data.inventory[i].name,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end


    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'body_search',
      {
        title    = _U('search'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

        if data.current.value ~= nil then

          TriggerServerEvent('esx_merryweather:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)

          OpenBodySearchMenu(player)

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, GetPlayerServerId(player))

end

function OpenFineMenu(player)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'fine',
    {
      title    = _U('fine'),
      align    = 'bottom-right',
      elements = {
        {label = _U('traffic_offense'),   value = 0},
        {label = _U('minor_offense'),     value = 1},
        {label = _U('average_offense'),   value = 2},
        {label = _U('major_offense'),     value = 3}
      },
    },
    function(data, menu)

      OpenFineCategoryMenu(player, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenFineCategoryMenu(player, category)

  ESX.TriggerServerCallback('esx_merryweather:getFineList', function(fines)

    local elements = {}

    for i=1, #fines, 1 do
      table.insert(elements, {
        label     = fines[i].label .. ' $' .. fines[i].amount,
        value     = fines[i].id,
        amount    = fines[i].amount,
        fineLabel = fines[i].label
      })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fine_category',
      {
        title    = _U('fine'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        local label  = data.current.fineLabel
        local amount = data.current.amount

        menu.close()

        if Config.EnablePlayerManagement then
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_merryweather', _U('fine_total') .. label, amount)
        else
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total') .. label, amount)
        end

        ESX.SetTimeout(300, function()
          OpenFineCategoryMenu(player, category)
        end)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, category)

end

function OpenVehicleInfosMenu(vehicleData)

  ESX.TriggerServerCallback('esx_merryweather:getVehicleInfos', function(infos)

    local elements = {}

    table.insert(elements, {label = _U('plate') .. infos.plate, value = nil})

    if infos.owner == nil then
      table.insert(elements, {label = _U('owner_unknown'), value = nil})
    else
      table.insert(elements, {label = _U('owner') .. infos.owner, value = nil})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_infos',
      {
        title    = _U('vehicle_info'),
        align    = 'bottom-right',
        elements = elements,
      },
      nil,
      function(data, menu)
        menu.close()
      end
    )

  end, vehicleData.plate)

end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_merryweather:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_merryweather:removeArmoryWeapon', function()
          OpenGetWeaponMenu()
        end, data.current.value)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutWeaponMenu()

  local elements   = {}
  local playerPed  = GetPlayerPed(-1)
  local weaponList = ESX.GetWeaponList()

  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'bottom-right',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_merryweather:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('esx_merryweather:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #Config.MWHQs[station].AuthorizedWeapons, 1 do

      local weapon = Config.MWHQs[station].AuthorizedWeapons[i]
      local count  = 0

      for i=1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end

      table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = _U('buy_weapon_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('esx_merryweather:buy', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('esx_merryweather:addArmoryWeapon', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value)
          else
            ESX.ShowNotification(_U('not_enough_money'))
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_merryweather:getStockItems', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('merryweather_stock'),
        elements = elements,
		align    = 'bottom-right',
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_merryweather:getStockItem', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

  ESX.TriggerServerCallback('esx_merryweather:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
        elements = elements,
		align    = 'bottom-right',
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_merryweather:putStockItems', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)

  local specialContact = {
    name       = 'Merryweather',
    number     = 'merryweather',
    base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAABl0RVh0U29mdHdhcmUAcGFpbnQubmV0IDQuMC4xOKPRgvIAAANUSURBVFhH7ZRfSFNRGMBvm+EyLSJEt3v1brt3/RFLQgwi5ps2CcLGwIeeit4ioUxMHRg+BkqCOhEhAhUK//syEEwxxIeYzjYm+Q8s3D1uEzYWMXfvXd+5HoyZEZX20n5wuff7zvfnnO9836VSpEiR4g/QNDY23p2cnBzyeDzuD8D09PRQU1PTfVjL2DU5IiwWS8nU1NSqLMuJ/WAdrG1UVFRcJ+aHS35+vsHlcm1LkqQkOwhRFBNutzvCsuwF4nZ4tLS09K+vr8t9fX2S2WyWFuYX9naxuLgol5aWSr29vdLq6qrc3t4+SNwOjYyJiYkva2tr0tLSkjQ2Nia1tbWJcP2Sz+eTWltbxfHxcWUN28zMzHwFn9O7rn8BYgr4AGMoyUxLM4dCIeXE29vb8uDgoLi8vCyNjo5KOPHKyoo0MDAgBoNBxSYcDsun1OryjRzD1Y1sjifhfg+B5h9t6UwhgeEqs05k3YrFYkkXj/tgeHhYHBkZEff3BJYZLVO5mWuyIh0XQlruIQn7a/w5l0/6aa4fNuDZoo0mrNPr9VUHNR40nDw3N/fjAlBYWHgP+27m8gUCbfQJOuOrdZbVYN1PQXk8Bzt2Q+I3KLsgk6ipsrKyWhI3CTwRuPMPwmq12ok7FTh7PgsqOYAYo8vPsnqiTgYxnAWMAkIe95io9qipqXlJ4iaBk8fjcSIl09DQ8Jq47xGg+aeQByGtvpyoKCpBUcf8tKEeFmJ+hnuwRV804dKDzH/k+XQwUXV2dm7g08Ik+KHsYZwgGo2KMHZ18FRHIhGlDF6vN+J0Ojfxxnp6egTsi2PgWDgmeaoRY9hBNF+Hc1NQ8idw8nlI7oV790GZomAUFxijHRtoNBpzV1fXTlVVlQMCnoERewfdHnU4HLfxATAdHR03A4FAeHZ29j2Ip202W1t3d/dOenp6OcRQQRM+gzwS0imxcQ6vwJhcuNF3IxC2tAYzoo2fUd73EqnVahu8ruxKSrLnzc3NxUTcw263F0GlXhARU6RSqe6Qbwo2cQMa8ZOg464RVTJKt+qMziDNM0R16PhzWD1MhDOgPZf8qw4yJhoxptoEVXycqI4MPIow5vWIZXMVBdyRWmAMlxThH4JoU9FbikojYooUKf5bKOobunhsDMLyTHEAAAAASUVORK5CYII='
  }

  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

AddEventHandler('esx_merryweather:hasEnteredMarker', function(station, part, partNum)

  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = _U('open_cloackroom')
    CurrentActionData = {}
  end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = {station = station, partNum = partNum}
  end

  if part == 'HelicopterSpawner' then

    local helicopters = Config.MWHQs[station].Helicopters

    if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint.x, helicopters[partNum].SpawnPoint.y, helicopters[partNum].SpawnPoint.z,  3.0) then

      ESX.Game.SpawnVehicle('securityvalkyrie', {
        x = helicopters[partNum].SpawnPoint.x,
        y = helicopters[partNum].SpawnPoint.y,
        z = helicopters[partNum].SpawnPoint.z
      }, helicopters[partNum].Heading, function(vehicle)
        SetVehicleModKit(vehicle, 0)
        SetVehicleLivery(vehicle, 0)
      end)

    end

  end

  if part == 'VehicleDeleter' then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end

    end

  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_merryweather:hasExitedMarker', function(station, part, partNum)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

AddEventHandler('esx_merryweather:hasEnteredEntityZone', function(entity)

  local playerPed = GetPlayerPed(-1)

  if PlayerData.job ~= nil and PlayerData.job.name == 'merryweather' and not IsPedInAnyVehicle(playerPed, false) then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('remove_object')
    CurrentActionData = {entity = entity}
  end

  if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed)

      for i=0, 7, 1 do
        SetVehicleTyreBurst(vehicle,  i,  true,  1000)
      end

    end

  end

end)

AddEventHandler('esx_merryweather:hasExitedEntityZone', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)


RegisterNetEvent('esx_merryweather:handcuff')
AddEventHandler('esx_merryweather:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

      RequestAnimDict('anim@move_m@prisoner_cuffed')
      ESX.ShowNotification('You have been ~r~detained~s~')
      while not HasAnimDictLoaded('anim@move_m@prisoner_cuffed') do
        Wait(100)
      end

      TaskPlayAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)

    else
      ESX.ShowNotification('~s~You have been ~b~uncuffed~s~')
      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)

    end

  end)
end)

RegisterNetEvent('esx_merryweather:shackle')
AddEventHandler('esx_merryweather:shackle', function()

  IsShackled    = not IsShackled;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsShackled then
    	ESX.ShowNotification('You have been ~r~shackled~s~.')
    	FreezeEntityPosition(playerPed, true)
    else
    	ESX.ShowNotification('You have been ~g~unshackled~s~.')
    	FreezeEntityPosition(playerPed, false)
    end

  end)
end)

RegisterNetEvent('esx_merryweather:gag')
AddEventHandler('esx_merryweather:gag', function()

  IsGagged    = not IsGagged;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsGagged then
      ESX.ShowNotification('You have been ~r~gagged~s~.')
    else
      ESX.ShowNotification('You have been ~g~gagged~s~.')
    end

  end)
end)

RegisterNetEvent('esx_merryweather:drag')
AddEventHandler('esx_merryweather:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('esx_merryweather:putInVehicle')
AddEventHandler('esx_merryweather:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end

    end

  end

end)

RegisterNetEvent('esx_merryweather:OutVehicle')
AddEventHandler('esx_merryweather:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Shackle
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsShackled then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
      DisableControlAction(0, 289, true) -- Inventory
      DisableControlAction(0, 288, true) -- Phone
      DisableControlAction(0, 73, true) -- HandsUp
      DisableControlAction(0, 170, true) -- EmoteMenu
      DisableControlAction(0, 322, true) -- Esc to prevent logging
      DisableControlAction(1, 322, true) -- Esc to prevent logging
      DisableControlAction(0, 29, true) --pointing
      DisableControlAction(1, 323, true) --handsup
      DisableControlAction(0, 323, true) --handsup
      DisableControlAction(0, 22, true) --jump
      DisableControlAction(0, 44, true) --cover_input
      --DisableControlAction(0, 245,  true) --textchat
      --DisableControlAction(1, 245,  true) --textchat
      DisableControlAction(0, 246,  true) --ragdoll
      DisableControlAction(1, 246,  true) --ragdoll
      DisableControlAction(0, 263,  true) --melee1
      DisableControlAction(1, 263,  true) --melee1
      DisableControlAction(0, 264,  true) --melee2
      DisableControlAction(1, 264,  true) --melee2
      DisableControlAction(0, 257,  true) --attack 
      DisableControlAction(1, 257,  true) --attack
      DisableControlAction(0, 71,  true) --drivew
      DisableControlAction(1, 71,  true) --drivew
      DisableControlAction(0, 38,  true) --E
      DisableControlAction(1, 38,  true) --E
      DisableControlAction(0, 68,  true) --vehaim
      DisableControlAction(1, 68,  true) --vehaim
      DisableControlAction(0, 75,  true) --vehexit
      DisableControlAction(1, 75,  true) --vehexit
      DisableControlAction(0, 72,  true) --vehbrake
      DisableControlAction(1, 72,  true) --vehbrake
      DisableControlAction(0, 37,  true) --wpnwhl
      DisableControlAction(1, 37,  true) --wpnwhl
      DisableControlAction(0, 59,  true) --vehLR
      DisableControlAction(1, 59,  true) --vehLR
      DisableControlAction(0, 60,  true) --vehUD
      DisableControlAction(1, 60,  true) --vehUD
      DisableControlAction(0, 61,  true) --vehUonly
      DisableControlAction(1, 61,  true) --vehUonly
      DisableControlAction(0, 62,  true) --vehDonly
      DisableControlAction(1, 62,  true) --vehDonly
      DisableControlAction(0, 63,  true) --vehLonly
      DisableControlAction(1, 63,  true) --vehLonly
      DisableControlAction(0, 64,  true) --vehRonly
      DisableControlAction(1, 64,  true) --vehRonly
      DisableControlAction(0, 86,  true) --horn
      DisableControlAction(1, 86,  true) --horn
      DisableControlAction(0, 47,  true) --siren(toggle)
      DisableControlAction(1, 47,  true) --siren(toggle)
      DisableControlAction(0, 24,  true) --attack
      DisableControlAction(1, 24,  true) --attack
      DisableControlAction(0, 25,  true) --aim
      DisableControlAction(1, 25,  true) --aim
      DisableControlAction(0, 50,  true) --accurateaim
      DisableControlAction(1, 50,  true) --accurateaim
      DisableControlAction(0, 140,  true) -- atklite
      DisableControlAction(1, 140,  true) -- atklite
      DisableControlAction(0, 141,  true) -- atkheav
      DisableControlAction(1, 141,  true) -- atkheav
      DisableControlAction(0, 142,  true) -- atkalt
      DisableControlAction(1, 142,  true) -- atkalt
      DisableControlAction(0, 143,  true) -- meleeblk
      DisableControlAction(1, 143,  true) -- meleeblk
      DisableControlAction(0, 156,  true) -- map
      DisableControlAction(1, 156,  true) -- map
      DisableControlAction(0, 157,  true) -- wpn_unarm
      DisableControlAction(1, 157,  true) -- wpn_unarm
      DisableControlAction(0, 158,  true) -- wpn_melee
      DisableControlAction(1, 158,  true) -- wpn_melee
      DisableControlAction(0, 199,  true) -- pause
      DisableControlAction(1, 199,  true) -- pause
      DisableControlAction(0, 113,  true) -- g_veh
      DisableControlAction(1, 113,  true) -- g_veh
    end
  end
end)

--Handcuff
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 289, true) -- Inventory
      DisableControlAction(0, 288, true) -- Phone
      DisableControlAction(0, 73, true) -- HandsUp
      DisableControlAction(0, 170, true) -- EmoteMenu
      DisableControlAction(0, 322, true) -- Esc to prevent logging
      DisableControlAction(1, 322, true) -- Esc to prevent logging
      DisableControlAction(0, 29, true) --pointing
      DisableControlAction(1, 323, true) --handsup
      DisableControlAction(0, 323, true) --handsup
      DisableControlAction(0, 142, true) --MeleeAttackAlternate
      DisableControlAction(0, 22, true) --jump
      DisableControlAction(0, 44, true) --cover_input
      DisableControlAction(0, 246,  true) --ragdoll
      DisableControlAction(1, 246,  true) --ragdoll
      DisableControlAction(0, 263,  true) --melee1
      DisableControlAction(1, 263,  true) --melee1
      DisableControlAction(0, 264,  true) --melee2
      DisableControlAction(1, 264,  true) --melee2
      DisableControlAction(0, 257,  true) --attack 
      DisableControlAction(1, 257,  true) --attack
      DisableControlAction(0, 38,  true) --E
      DisableControlAction(1, 38,  true) --E
      DisableControlAction(0, 68,  true) --vehaim
      DisableControlAction(1, 68,  true) --vehaim
      DisableControlAction(0, 37,  true) --wpnwhl
      DisableControlAction(1, 37,  true) --wpnwhl
      DisableControlAction(0, 59,  true) --vehLR
      DisableControlAction(1, 59,  true) --vehLR
      DisableControlAction(0, 63,  true) --vehLonly
      DisableControlAction(1, 63,  true) --vehLonly
      DisableControlAction(0, 64,  true) --vehRonly
      DisableControlAction(1, 64,  true) --vehRonly
      DisableControlAction(0, 86,  true) --horn
      DisableControlAction(1, 86,  true) --horn
      DisableControlAction(0, 47,  true) --siren(toggle)
      DisableControlAction(1, 47,  true) --siren(toggle)
      DisableControlAction(0, 24,  true) --attack
      DisableControlAction(1, 24,  true) --attack
      DisableControlAction(0, 25,  true) --aim
      DisableControlAction(1, 25,  true) --aim
      DisableControlAction(0, 50,  true) --accurateaim
      DisableControlAction(1, 50,  true) --accurateaim
      DisableControlAction(0, 140,  true) -- atklite
      DisableControlAction(1, 140,  true) -- atklite
      DisableControlAction(0, 141,  true) -- atkheav
      DisableControlAction(1, 141,  true) -- atkheav
      DisableControlAction(0, 142,  true) -- atkalt
      DisableControlAction(1, 142,  true) -- atkalt
      DisableControlAction(0, 143,  true) -- meleeblk
      DisableControlAction(1, 143,  true) -- meleeblk
      DisableControlAction(0, 156,  true) -- map
      DisableControlAction(1, 156,  true) -- map
      DisableControlAction(0, 157,  true) -- wpn_unarm
      DisableControlAction(1, 157,  true) -- wpn_unarm
      DisableControlAction(0, 158,  true) -- wpn_melee
      DisableControlAction(1, 158,  true) -- wpn_melee
      DisableControlAction(0, 199,  true) -- pause
      DisableControlAction(1, 199,  true) -- pause
      DisableControlAction(0, 113,  true) -- g_veh
      DisableControlAction(1, 113,  true) -- g_veh
      DisableControlAction(0, 75,  true) --vehexit
      DisableControlAction(1, 75,  true) --vehexit
    end
  end
end)

-- Gag
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsGagged then
      DisableControlAction(0, 46,  true) --input_talk
      DisableControlAction(1, 46,  true) --input_talk
      DisableControlAction(0, 249,  true) --PTT
      DisableControlAction(1, 249,  true) --PTT
      --DisableControlAction(0, 245,  true) --textchat
      --DisableControlAction(1, 245,  true) --textchat
      --TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('gagged') .. targetXPlayer.name )
      --TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('gaggedby') .. targetXPlayer.name )

    end 
  end
end)

-- Create blips
Citizen.CreateThread(function()

for k,v in pairs(Config.MWHQs) do

    local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)

    SetBlipSprite (blip, v.Blip.Sprite)
    SetBlipDisplay(blip, v.Blip.Display)
    SetBlipScale  (blip, v.Blip.Scale)
    SetBlipColour (blip, v.Blip.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('map_blip'))
    EndTextCommandSetBlipName(blip)

  end

end)

-- Display markers
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.job ~= nil and PlayerData.job.name == 'merryweather' then

      local playerPed = GetPlayerPed(-1)
      local coords    = GetEntityCoords(playerPed)

      for k,v in pairs(Config.MWHQs) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'merryweather' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end

        end

      end

    end

  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

  while true do

    Wait(0)

    if PlayerData.job ~= nil and PlayerData.job.name == 'merryweather' then

      local playerPed      = GetPlayerPed(-1)
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k,v in pairs(Config.MWHQs) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Cloakroom'
            currentPartNum = i
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Armory'
            currentPartNum = i
          end
        end

        for i=1, #v.Vehicles, 1 do

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.Helicopters, 1 do

          if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'HelicopterSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Helicopters[i].SpawnPoint.x,  v.Helicopters[i].SpawnPoint.y,  v.Helicopters[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'HelicopterSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleDeleter'
            currentPartNum = i
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'merryweather' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
              isInMarker     = true
              currentStation = k
              currentPart    = 'BossActions'
              currentPartNum = i
            end
          end

        end

      end

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

        if
          (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_merryweather:hasExitedMarker', LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_merryweather:hasEnteredMarker', currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

        HasAlreadyEnteredMarker = false

        TriggerEvent('esx_merryweather:hasExitedMarker', LastStation, LastPart, LastPartNum)
      end

    end

  end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()

  local trackedEntities = {
    'prop_roadcone02a',
    'prop_mp_barrier_02',
    'prop_mp_barrier_02b'
  }

  while true do

    Citizen.Wait(0)

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity   = nil

    for i=1, #trackedEntities, 1 do

      local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  GetHashKey(trackedEntities[i]), false, false, false)

      if DoesEntityExist(object) then

        local objCoords = GetEntityCoords(object)
        local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)

        if closestDistance == -1 or closestDistance > distance then
          closestDistance = distance
          closestEntity   = object
        end

      end

    end

    if closestDistance ~= -1 and closestDistance <= 3.0 then

      if LastEntity ~= closestEntity then
        TriggerEvent('esx_merryweather:hasEnteredEntityZone', closestEntity)
        LastEntity = closestEntity
      end

    else

      if LastEntity ~= nil then
        TriggerEvent('esx_merryweather:hasExitedEntityZone', LastEntity)
        LastEntity = nil
      end

    end

  end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0,  Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'merryweather' and (GetGameTimer() - GUI.Time) > 150 then

        if CurrentAction == 'menu_cloakroom' then
          OpenCloakroomMenu()
        end

        if CurrentAction == 'menu_armory' then
          OpenArmoryMenu(CurrentActionData.station)
        end

        if CurrentAction == 'menu_vehicle_spawner' then
          OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
        end

        if CurrentAction == 'delete_vehicle' then

          if Config.EnableSocietyOwnedVehicles then

            local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
            TriggerServerEvent('esx_society:putVehicleInGarage', 'merryweather', vehicleProps)

          else

            if
              GetEntityModel(vehicle) == GetHashKey('police')  or
              GetEntityModel(vehicle) == GetHashKey('police2') or
              GetEntityModel(vehicle) == GetHashKey('police3') or
              GetEntityModel(vehicle) == GetHashKey('police4') or
              GetEntityModel(vehicle) == GetHashKey('policeb') or
              GetEntityModel(vehicle) == GetHashKey('policet')
            then
              TriggerServerEvent('esx_service:disableService', 'merryweather')
            end

          end

          ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
        end

        if CurrentAction == 'menu_boss_actions' then

          ESX.UI.Menu.CloseAll()

          TriggerEvent('esx_society:openBossMenu', 'merryweather', function(data, menu)

            menu.close()

            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = _U('open_bossmenu')
            CurrentActionData = {}

          end)

        end

        if CurrentAction == 'remove_entity' then
          DeleteEntity(CurrentActionData.entity)
        end

        CurrentAction = nil
        GUI.Time      = GetGameTimer()

      end

    end

    if IsControlPressed(0,  Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'merryweather' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') and (GetGameTimer() - GUI.Time) > 150 then
      OpenPoliceActionsMenu()
      GUI.Time = GetGameTimer()
    end

  end
end)

function openPolice()
  if PlayerData.job ~= nil and PlayerData.job.name == 'merryweather' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') and (GetGameTimer() - GUI.Time) > 150 then
    OpenPoliceActionsMenu()
    GUI.Time = GetGameTimer()
  end
end

function getJob()
  if PlayerData.job ~= nil then
	return PlayerData.job.name
  end
end