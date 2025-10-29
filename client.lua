local rareHorses = {}

local function IsPlayerNearLocation(loc, radius)
    local players = GetActivePlayers()
    for _, player in pairs(players) do
        local ped = GetPlayerPed(player)
        local coords = GetEntityCoords(ped)
        local dist = #(vector3(loc.x, loc.y, loc.z) - coords)
        if dist < radius then
            return true
        end
    end
    return false
end

local function IsHorseBeingRidden(horse)
    local players = GetActivePlayers()
    for _, player in pairs(players) do
        local ped = GetPlayerPed(player)
        local mount = GetMount(ped)
        if mount and mount == horse then
            return true
        end
    end
    return false
end

RegisterNetEvent("bulgar_wilds:respawnLocation")
AddEventHandler("bulgar_wilds:respawnLocation", function(index)
    local v = Config.Locations[index]
    if not v then return end

    if IsPlayerNearLocation(v.loc, Config.AreaProtect) then
        if Config.Debug then
            print(("[bulgar_wilds] Ignoring respawn. #%s — player is nearby."):format(index))
        end
        Citizen.SetTimeout(Config.TimerProtect, function()
            TriggerEvent("bulgar_wilds:respawnLocation", index)
        end)
        return
    end

    if rareHorses[index] then
        for _, horse in pairs(rareHorses[index]) do
            if DoesEntityExist(horse) then
                if not IsHorseBeingRidden(horse) then
                    DeletePed(horse)
                elseif Config.Debug then
                    print(("[bulgar_wilds] I am not removing the horse from the location #%s — player is sitting on it."):format(index))
                end
            end
        end
    end
    rareHorses[index] = {}

    local hashModel = GetHashKey(v.model)
    if IsModelValid(hashModel) then
        RequestModel(hashModel)
        while not HasModelLoaded(hashModel) do
            Wait(100)
        end
    end

    local maxgroupSize = math.random(1, v.groupSize)
    for i = 1, maxgroupSize do
        local locx = v.loc.x + math.random(-v.radius, v.radius)
        local locy = v.loc.y + math.random(-v.radius, v.radius)
        local locz = v.loc.z
        local head = v.heading + math.random(-100, 100)

        local horse = CreatePed(hashModel, locx, locy, locz, head, true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, horse, true)
        Citizen.InvokeNative(0xAEB97D84CDF3C00B, horse, true)

        table.insert(rareHorses[index], horse)
        Wait(1000)
    end

    if Config.Debug then
        print(("[bulgar_wilds] Horses were respawned for the location #%s"):format(index))
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, horses in pairs(rareHorses) do
            for _, horse in pairs(horses) do
                if DoesEntityExist(horse) then
                    DeletePed(horse)
                end
            end
        end
    end
end)