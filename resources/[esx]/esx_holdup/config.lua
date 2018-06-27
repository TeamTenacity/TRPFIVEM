Config = {}
Config.Locale = 'en'

Config.PoliceNumberRequired =2
Config.TimerBeforeNewRob = 1800 -- seconds


-- Change secondsRemaining if you want another timer
Stores = {
    ["pacstand"] = {
        position = { ['x'] = 253.36247253418, ['y'] = 228.34393310547, ['z'] = 101.753265 },
        reward = math.random(75000,100000),
        nameofstore = "Pacific Standard (Vinewood Blvd)",
        secondsRemaining = 600, -- seconds
        CopsNeeded = 4,
        lastrobbed = 0
    },
    ["blainecounty"] = {
        position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.72670135498 },
        reward = math.random(25000,50000),
        nameofstore = "Blaine County Savings (Paleto Bay)",
        secondsRemaining = 450, -- seconds
        CopsNeeded = 3,
        lastrobbed = 0
    },
    ["fleeca_legion"] = {
        position = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.37802482605 },
        reward = math.random(10000,25000),
		nameofstore = "Fleeca Bank (Legion Sq)",
        secondsRemaining = 300, -- seconds
        CopsNeeded = 3,
        lastrobbed = 0
    },
    ["fleeca_greatocean"] = {
        position = { ['x'] = -2957.5678710938, ['y'] = 481.23922729492, ['z'] = 15.816854820251 },
        reward = math.random(17500,35000),
		nameofstore = "Fleeca Bank (Great Ocean Hwy)",
        secondsRemaining = 300, -- seconds
        CopsNeeded = 3,
        lastrobbed = 0
    },
    ["vangelico"] = {
        position = { ['x'] = -622.09362792969, ['y'] = -230.71449279785, ['z'] = 38.079151153564 },
        reward = math.random(17500,25000),
		nameofstore = "Vangelico's Jewlers (Rockford Dr.)",
        secondsRemaining = 300, -- seconds
        CopsNeeded = 3,
        lastrobbed = 0
    },
    ["lifeinvader"] = {
        position = { ['x'] = -1052.3038, ['y'] = -232.1761, ['z'] = 44.0209 },
        reward = math.random(15000,17500),
        nameofstore = "LifeInvader Offices (Rockford Hills)",
        secondsRemaining = 300, -- seconds
        CopsNeeded = 3,
        lastrobbed = 0
    },
    ["paleto_twentyfourseven"] = {
        position = { ['x'] = 1736.32092285156, ['y'] = 6419.4970703125, ['z'] = 35.037223815918 },
        reward = math.random(1000,1500),
        nameofstore = "24/7. (Paleto Bay)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 2,
        lastrobbed = 0
    },
    ["palamino_twentyfourseven"] = {
        position = { ['x'] = 2550.2172851563, ['y'] = 387.15063476563, ['z'] = 108.69900512695 },
        reward = math.random(9750,11750),
        nameofstore = "24/7. (Palomino Fwy)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 2,
        lastrobbed = 0
    },
    ["sandyshores_twentyfourseven"] = {
        position = { ['x'] = 1961.24682617188, ['y'] = 3749.46069335938, ['z'] = 32.3437461853027 },
        reward = math.random(1250,6135),
        nameofstore = "24/7 (Sandy Shores)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 2,
        lastrobbed = 0
    },
    ["chumash_twentyfourseven"] = {
        position = { ['x'] = -3249.1850585938, ['y'] = 1006.6576679688, ['z'] = 12.920708503723 },
        reward = math.random(2634,6674),
        nameofstore = "24/7 (Chumash)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 2,
        lastrobbed = 0
    },
    ["bar_one"] = {
        position = { ['x'] = 1990.579, ['y'] = 3044.957, ['z'] = 47.215171813965 },
        reward = math.random(2736,5694),
        nameofstore = "Yellow Jack (Sandy Shores)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 2,
        lastrobbed = 0
    },
    ["sanandreas_liquor"] = {
        position = { ['x'] = -1219.85607910156, ['y'] = -916.276550292969, ['z'] = 11.3262157440186 },
        reward = math.random(1986,6425),
        nameofstore = "Robs Liquor (San andreas Avenue)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 2,
        lastrobbed = 0
    },
    ["grove_ltd"] = {
        position = { ['x'] = 1707.0904541016, ['y'] = 4919.2231445313, ['z'] = 42.09364440918 },
        reward = math.random(1163,2501),
        nameofstore = "LTD Gasoline (Grapeseed)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 1,
        lastrobbed = 0
    },
    ["grape_ltd"] = {
        position = { ['x'] = -43.4035377502441, ['y'] = -1749.20922851563, ['z'] = 29.421012878418 },
        reward = math.random(1163,2101),
        nameofstore = "LTD Gasoline (Grove Street)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 1,
        lastrobbed = 0
    },
    ["mirror_ltd"] = {
        position = { ['x'] = 1160.67578125, ['y'] = -314.400451660156, ['z'] = 69.2050552368164 },
        reward = math.random(3582,9541),
        nameofstore = "LTD Gasoline (Mirror Park Boulevard)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 2,
        lastrobbed = 0
    },
    ["littleseoul_ltd"] = {
        position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.215591430664 },
        reward = math.random(4574,6123),
        nameofstore = "LTD Gasoline (Little Seoul)",
        secondsRemaining = 150, -- seconds
        CopsNeeded = 2,
        lastrobbed = 0
    }
}
