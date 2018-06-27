----------------------------------------------------------------------
----------------------- Developped by AlphaKush ----------------------
----------------------------------------------------------------------

Config              = {}
Config.DrawDistance = 100.0
Config.MarkerColor  = {r = 120, g = 120, b = 240}
Config.Locale = 'en'

Config.Zones = {
	---------------- Prison ------------------

    EnterParloirPrison = { -- marker entré dans le parloir
        Pos = { x = 1800.5021972656, y = 2483.1120605469, z = -123.68949127197},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 25
    },

    ExitParloirPrison = { -- marker quitter le parloir prisonnier
        Pos = { x = 1699.6072998047, y = 2574.9650878906, z = -70.41259765625},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 25
    },

    SpawnParloirPrison = { -- spawn parloir pour prisonnier
        Pos = { x = 1700.0384521484, y = 2577.2641601563, z = -70.402481079102},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
    },

    SpawnInterieurPrison = { -- spawn interieur de la prison
        Pos = { x = 1798.4055175781, y = 2483.2380371094, z = -123.70260620117},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
    },

	-------------- Parloir comico -------------
    EnterParloir = { -- marker Entré parloir
        Pos = { x = 462.77740478516, y = -1009.7374267578, z = 24.562419891357},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 1
    },

    SpawnParloirinterior = { -- Spawn parloir
        Pos = { x = 1704.8670654297, y = 2581.1635742188, z = -70.421897888184},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
    },

    SpawnParloirExterieur = { --- Spawn comico
        Pos = { x = 463.95819091797, y = -1007.7111206055, z = 24.561367034912},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = -1
    },

    ExitParloir = { -- marker quitter le parloir
        Pos = { x = 1706.1396484375, y = 2581.1411132813, z = -70.415794372559},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 204, b = 3},
		Type  = 1
    },

    ------ Policier ------
    EnterPrisoncop = { -- marker entrer dans la prison
        Pos = { x = 1711.3067626953, y = 2571.9147949219, z = -70.440444946289},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 0, g = 204, b = 3},
        Type  = 1
    },

    SpawnPrisoncopinterior = { -- Spawn interieur prison policier
        Pos = { x = 1786.8297119141, y = 2484.6303710938, z = -123.6990814209},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 0, g = 204, b = 3},
        Type  = -1
    },

    SpawnParloircopinterior = { -- spawn parloir policier
        Pos = { x = 1707.9953613281, y = 2571.4833984375, z = -70.427024841309},
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 0, g = 204, b = 3},
        Type  = -1
    },
}
