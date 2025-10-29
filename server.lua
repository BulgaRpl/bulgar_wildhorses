local currentHost = nil

local function SelectNewHost()
    local players = GetPlayers()
    if #players == 0 then
        currentHost = nil
        if Config.Debug then
            print("[bulgar_wilds] No players online — host not selected.")
        end
        return
    end

    local randomPlayer = players[math.random(1, #players)]
    currentHost = randomPlayer

    if Config.Debug then
        print(string.format("[bulgar_wilds] New host selected: %s (%s)", currentHost, GetPlayerName(currentHost) or "unknown"))
    end
end

Citizen.CreateThread(function()
    Citizen.Wait(Config.StartScriptAfter)

    if Config.Debug then
        print("[bulgar_wilds] Starting timers...")
    end

    SelectNewHost()

    for index, data in ipairs(Config.Locations) do
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(data.respawnTimer)

                if not currentHost or not GetPlayerPed(currentHost) then
                    SelectNewHost()
                end

                if not currentHost then
                    if Config.Debug then
                        print("[bulgar_wilds] No host, skipping respawn.")
                    end
                else
                    TriggerClientEvent("bulgar_wilds:respawnLocation", currentHost, index)
                    if Config.Debug then
                        print(string.format("[bulgar_wilds] Host %s (%s) respawned horses for the location #%d", currentHost, GetPlayerName(currentHost) or "unknown", index))
                    end
                end
            end
        end)
    end
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    if currentHost == tostring(src) then
        if Config.Debug then
            print(string.format("[bulgar_wilds] Host %s left the server (%s) — i am choosing a new host.", src, reason))
        end
        Citizen.SetTimeout(3000, function()
            SelectNewHost()
        end)
    end
end)
