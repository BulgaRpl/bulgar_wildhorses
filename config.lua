Config = {}

Config.Debug = false -- Dev Stuff Dont use on Live Server!

-- Start spawning 60 seconds after script/server start.
Config.StartScriptAfter = 60000

-- Protections
Config.AreaProtect = 200.0 -- If someone is within this range, horses will not be removed or re-spawned in this area to keep things realistic.
Config.TimerProtect = 30000 -- Wait 30 seconds before checking again if the player is around, refers to the option above.

-- Spawn Locations
Config.Locations = {
    {
        model = "a_c_horse_criollo_blueroanovero", -- Horse model
        loc = {x = 1024.2264, y = -736.4341, z = 89.4998}, -- Spawn Coords
        heading = 178.2852, -- Spawn Heading, will be randomized anyway to keep realism
        groupSize = 2, -- More = more horses spawn in this area, recommended between 1 and 2
        radius = 7, -- Spawn radius 7 from coords
		respawnTimer = 900000 -- How often should the horses be renewed in this place? works with Config.AreaProtect and Config.TimerProtect
    },
    {
        model = "a_c_horse_kladruber_black",
        loc = {x = 287.1924, y = -43.6423, z = 107.9053},
        heading = 121.9056,
        groupSize = 2,
        radius = 7,
		respawnTimer = 900000
    },
    {
        model = "a_c_horse_gypsycob_whiteblagdon",
        loc = {x = -1949.2925, y = 1815.9117, z = 238.3860},
        heading = 214.5685,
        groupSize = 2,
        radius = 7,
		respawnTimer = 900000
    },
    {
        model = "a_c_horse_norfolkroadster_black",
        loc = {x = -2719.2649, y = -406.0753, z = 152.4004},
        heading = 325.6404,
        groupSize = 2,
        radius = 7,
		respawnTimer = 900000
    },
    {
        model = "a_c_horse_hungarianhalfbred_piebaldtobiano",
        loc = {x = -5654.3008, y = -3312.7708, z = -22.9758},
        heading = 306.6470,
        groupSize = 2,
        radius = 7,
		respawnTimer = 900000
    }
}