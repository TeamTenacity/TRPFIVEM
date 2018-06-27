Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- If set to true, you need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = false
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false
Config.ResellPercentage           = 0
Config.Locale                     = 'en'

Config.Zones = {

  ShopEntering = { -- Shop
    Pos   = { x = -467.32556152344, y = 6287.8940429688, z = 12.534559631348 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },

  ShopInside = { -- Car Spawn, Preview
    Pos     = { x = -470.05447387695, y = 6306.7641601563, z = 12.858254814148 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 66,
    Type    = -1,
  },

  ShopOutside = { -- Car Spawn, buy
    Pos     = { x = -470.05447387695, y = 6306.7641601563, z = 12.858254814148 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 66,
    Type    = -1,
  },

  BossActions = {
    Pos   = { x = -475.94030761719, y = 6286.76171875, z = 12.531778717041 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

--[[  GiveBackVehicle = { --?
    Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },

  ResellVehicle = { -- Sale
    Pos   = { x = -44.630, y = -1080.738, z = 25.683 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },
--]]
}
