Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 102, g = 0, b = 102 }

local second = 1000
local minute = 60 * second

-- How much time before auto respawn at hospital
Config.RespawnDelayAfterRPDeath   = 10 * minute

-- How much time before a menu opens to ask the player if he wants to respawn at hospital now
-- The player is not obliged to select YES, but he will be auto respawn
-- at the end of RespawnDelayAfterRPDeath just above.
Config.RespawnToHospitalMenuTimer   = false
Config.MenuRespawnToHospitalDelay   = 10 * minute

Config.EnablePlayerManagement       = true
Config.EnableSocietyOwnedVehicles   = false

Config.RemoveWeaponsAfterRPDeath    = false
Config.RemoveCashAfterRPDeath       = false
Config.RemoveItemsAfterRPDeath      = false

-- Will display a timer that shows RespawnDelayAfterRPDeath time remaining
Config.ShowDeathTimer               = true

-- Will allow to respawn at any time, don't use RespawnToHospitalMenuTimer at the same time !
Config.EarlyRespawn                 = false
-- The player can have a fine (on bank account)
Config.RespawnFine                  = false
Config.RespawnFineAmount            = 500

Config.Locale                       = 'en'

Config.Blip = {
  Pos     = { x = -498.9716, y = -335.7394, z = 33.8917 },
  Sprite  = 61,
  Display = 4,
  Scale   = 0.8,
  Colour  = 2,
}

Config.HelicopterSpawner = {
  SpawnPoint  = { x = 313.33, y = -1465.2, z = 45.5 },
  Heading     = 0.0
}

Config.Zones = {

  HospitalInteriorEntering1 = { -- Enter Hospital Teleporter
    Pos  = { x = -498.9716, y = -335.7394, z = 33.8917 },
    Size = { x = 1.5, y = 1.5, z = 0.4 },
    Type = 1
  },

  HospitalInteriorInside1 = { -- Enter Hospital Teleporter Destination
    Pos  = { x = -458.435, y = -367.3579, z = -187.054 },
    Size = { x = 1.5, y = 1.5, z = 1.0 },
    Type = -1
  },

  HospitalInteriorOutside1 = { -- Exit Hospital Teleporter Destinatin
    Pos  = { x = -495.9638, y = -335.9077, z = 33.9016 },
    Size = { x = 1.5, y = 1.5, z = 1.0 },
    Type = -1
  },

  HospitalInteriorExit1 = { -- Exit Hospital Teleporter
    Pos  = { x = -456.0498, y = -368.0931, z = -187.1608 },
    Size = { x = 1.5, y = 1.5, z = 0.4 },
    Type = 1
  },

  HospitalInteriorEntering2 = { -- To Helipad Teleporter 
    Pos  = { x = -454.296, y = -370.9114, z = -187.1625 },
    Size = { x = 1.5, y = 1.5, z = 0.4 },
    Type = 1
  },

  HospitalInteriorInside2 = { -- To Helipad Teleporter Destination
    Pos  = { x = 333.1,  y = -1434.9, z = 45.5 },
    Size = { x = 1.5, y = 1.5, z = 1.0 },
    Type = -1
  },

  HospitalInteriorOutside2 = { -- From Helipad Destination
    Pos  = { x = -452.5936,  y = -371.0712, z = -187.054818 },
    Size = { x = 1.5, y = 1.5, z = 1.0 },
    Type = -1
  },

  HospitalInteriorExit2 = { -- From Helipad Teleporter
    Pos  = { x = 335.5, y = -1432.0, z = 45.5 },
    Size = { x = 1.5, y = 1.5, z = 0.4 },
    Type = 1
  },

  AmbulanceActions = { -- CLOACKROOM
    Pos  = { x = 1209.074, y = -1480.805, z = 33.782 },
    Size = { x = 1.5, y = 1.5, z = 0.4 },
    Type = 1
  },

  VehicleSpawner = {
    Pos  = { x = 1193.754, y = -1486.938, z = 33.771 },
    Size = { x = 1.5, y = 1.5, z = 0.4 },
    Type = 1
  },

  VehicleSpawnPoint = {
    Pos  = { x = 1198.308, y = -1495.358, z = 33.615 },
    Heading = 183,
    Size = { x = 1.5, y = 1.5, z = 1.0 },
    Type = -1
  },

  VehicleDeleter = {
    Pos  = { x = 1203.456, y = -1493.321, z = 33.614 },
    Size = { x = 3.0, y = 3.0, z = 0.4 },
    Type = 1
  },

  Pharmacy = { -- Purchase medkits and bandages
    Pos  = { x = 1207.865, y = -1467.485, z = 33.782 },
    Size = { x = 1.5, y = 1.5, z = 0.4 },
    Type = 1
  },

  ParkingDoorGoOutInside = { -- Morgue Exit Teleporter
    Pos  = { x = 275.7, y = -1361.5, z = 23.5 },
    Size = { x = 1.5, y = 1.5, z = 0.4 },
    Type = 1
  },

  ParkingDoorGoOutOutside = { -- Morgue Exit Teleporter Destination
    Pos  = { x = 239.073, y = -1381.437, z = 33.141 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Type = -1
  },

  ParkingDoorGoInInside = { -- Morgue Enter Destination
    Pos  = { x = 272.8, y = -1358.8, z = 23.5 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Type = -1
  },

  ParkingDoorGoInOutside = { -- Morgue Enter Teleporter
    Pos  = { x = 241.253, y = -1379.08, z = 33.041 },
    Size = { x = 1.5, y = 1.5, z = 0.4 },
    Type = 1
  },

  StairsGoTopTop = { --Top of stairs
    Pos  = { x = 251.91, y = -1363.3, z = 38.53 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Type = -1
  },

  StairsGoTopBottom = { --Teleport spot from offices to bottom of the stars
    Pos  = { x = 237.45, y = -1373.89, z = 26.30 },
    Size = { x = 3.5, y = 3.5, z = 0.4 },
    Type = -1
  },

  StairsGoBottomTop = { -- Teleport spot from Patient rooms to Offices
    Pos  = { x = 256.58, y = -1357.7, z = 37.30 },
    Size = { x = 3.5, y = 3.5, z = 0.4 },
    Type = -1
  },

  StairsGoBottomBottom = { -- Bottom of stairs
    Pos  = { x = 240.94, y = -1369.91, z = 23.53 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
    Type = -1
  }

}
