Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = falseqw
Config.EnableLicenses             = true
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.MWHQs = {

  LSPD = {

    Blip = {
      Pos   = {x = 532.037, y = -3054.7, z = 18.7686},
      Sprite  = 84,
      Display = 4,
      Scale   = 1.2,
      Colour  = 76,
    },

    AuthorizedWeapons = {
      {name = 'WEAPON_FLASHLIGHT',       price = 100},
      {name = 'WEAPON_FIREEXTINGUISHER', price = 100},
      {name = 'WEAPON_NIGHTSTICK',       price = 200},
      {name = 'WEAPON_STUNGUN',          price = 250},
      {name = 'WEAPON_PISTOL_MK2',     price = 1200},
      {name = 'WEAPON_CARBINERIFLE_MK2', price = 2500},
      {name = 'WEAPON_PUMPSHOTGUN',      price = 2500}, 
    },

    AuthorizedVehicles = {
      { label = 'Panto (Recruit)', name = 'securityp'},
      { label = 'Buffalo S (Uniformed Security)', name = 'security'},
      { label = 'Oracle (Uniformed Security)', name = 'security2'},
      { label = 'XLS (Uniformed Security)', name = 'security3'},
      { label = 'Karuma (PPU)', name = 'security7'},
      { label = 'Armored XLS (PPU)', name = 'security5'},
      { label = 'Yosemite (K9)', name = 'securityt2'},
      { label = 'Cavalcade Mk. II (ARRT)', name = 'securityarrt1'},
      { label = 'Rumpo Trail (ARRT)', name = 'securityt'},
      { label = 'Nightshark (ARRT)', name = 'securityarrt2'},
      { label = 'Riot (ARRT)', name = 'securityarrt3'},
    },

    Cloakrooms = {
      {x = 569.414, y = -3125.930, z = 17.8},
    },

    Armories = {
      {x = 563.116, y = -3121.725, z = 17.8},
    },

    Vehicles = {
      {
        Spawner    = {x = 532.8845, y = -3053.8430, z = 5.289},
        SpawnPoint = {x = 540.479, y = -3048.31, z = 5.4696},
        Heading    = 360
      }
    },

    Helicopters = {
      {
        Spawner    = {x = 588.645, y = -3110.291, z = 31.062},
        SpawnPoint = {x = 613.218, y = -3037.360, z = 5.5701},
        Heading    = 360
      }
    },

    VehicleDeleters = {
      {x = 515.4583, y = -3053.2302, z = 5.289},
    },

    BossActions = {
      {x = 605.743, y = -3088.35, z = 5.289},
    },

  },

}
