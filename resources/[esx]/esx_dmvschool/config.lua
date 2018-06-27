Config                 = {}
Config.DrawDistance    = 100.0
Config.MaxErrors       = 5
Config.SpeedMultiplier = 2.236936
Config.Locale          = 'en'

Config.Prices = {
  dmv         = 200,
  drive       = 500,
  drive_bike  = 500,
  drive_truck = 500
}

Config.VehicleModels = {
  drive       = 'blista',
  drive_bike  = 'faggio',
  drive_truck = 'mule3'
}

Config.SpeedLimits = {
  residence = 50,
  town      = 80,
  freeway   = 120
}

Config.Zones = {

  DMVSchool = {
    Pos   = {x = 825.481, y = -1290.038, z = 27.640},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = 1
  },

  VehicleSpawnPoint = {
    Pos   = {x = 833.341, y = -1271.319, z = 25.628},
    Heading = 3.0,
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = -1
  },

}

Config.CheckPoints = {

  {
    Pos = {x = 814.036, y = -1263.129, z = 25.727}, -- Pulling out of driveway
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('stop_look_left') .. Config.SpeedLimits['residence'] .. 'mph', 5000)
    end
  },



  {
    Pos = {x = 802.795, y = -1256.046, z = 25.727},  --First traffic lights
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('stop_for_ped'), 5000)
    end
  },



  {
    Pos = {x = 799.535, y = -1162.910, z = 28.467},  --Traffic lights under HWY
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('good_lets_cont'), 5000)
    end
  },



  {
    Pos = {x = 780.863, y = -1025.747, z = 25.862}, --Turn Left onto bridge towards legion
    Action = function(playerPed, vehicle, setCurrentZoneType)
      Citizen.CreateThread(function()
        DrawMissionText(_U('stop_for_ped'), 5000)
        
        --[[PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, false)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText(_U('good_lets_cont'), 5000)]]--

      end)
    end
  },




  {
    Pos = {x = 413.449, y = -1045.402, z = 28.811}, --Stop at lights (next to PD). Then turn left.
    Action = function(playerPed, vehicle, setCurrentZoneType)

      setCurrentZoneType('town')

      Citizen.CreateThread(function()
        DrawMissionText(_U('stop_for_ped') .. Config.SpeedLimits['town'] .. 'mph', 5000)
      end)
    end
  },




  {
    Pos = {x = 395.525, y = -1117.036, z = 28.789}, -- Lights across from boat shop. Turn right.
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('watch_traffic_lightson'), 5000)
    end
  },




  {
    Pos = {x = 236.504, y = -1133.774, z = 28.674}, -- Left at lights
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
    end
  },




  {
    Pos = {x = 209.605, y = -1268.185, z = 28.654}, -- Continue through lights (past servo)
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('stop_for_passing'), 5000)
    end
  },




  {
    Pos = {x = 113.424, y = -1364.622, z = 28.736}, --Continue at lights
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
    end
  },




  {
    Pos = {x = -211.938, y = -1413.683, z = 30.689}, --Innocence Blvd | Carson Ave | Strawberry
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
    end
  },




  {
    Pos = {x = -439.643, y = -1417.732, z = 28.719}, -- Entrance to freeway
    Action = function(playerPed, vehicle, setCurrentZoneType)

      setCurrentZoneType('freeway')

      DrawMissionText(_U('hway_time') .. Config.SpeedLimits['freeway'] .. 'mph', 5000)
      PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },




  {
    Pos = {x = -463.237, y = -1592.178, z = 38.526},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
    end
  },




  {
    Pos = {x = -900.647, y = -1986.28, z = 27.153},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
    end
  },



  {
    Pos = {x = 1155.062, y = -1856.347, z = 29.899},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
    end
  },



  {
    Pos = {x = 1082.130, y = -1534.765, z = 26.824},  -- Exit freeway onto Olympic Fwy
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
    end
  },


  {
    Pos = {x = 757.359, y = -1163.579, z = 44.426},  -- Exit freeway on loop
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
    end
  },


    {
    Pos = {x = 819.205, y = -1150.619, z = 28.287}, --Turn left towards home
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
    end
  },



  {
    Pos = {x =  813.117, y =  -1266.949, z =  25.767}, -- enter driveway
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('gratz_stay_alert'), 5000)
      PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },




  {
    Pos = {x = 828.094, y = -1257.642, z = 25.682},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      ESX.Game.DeleteVehicle(vehicle)
    end
  },

}