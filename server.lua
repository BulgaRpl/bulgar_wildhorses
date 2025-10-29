Citizen.CreateThread(function()
    Citizen.Wait(Config.StartScriptAfter)
	
	if Config.Debug then
		print("[bulgar_wilds] Starting timers...")
	end

    for index, data in ipairs(Config.Locations) do
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(data.respawnTimer)
                TriggerClientEvent("bulgar_wilds:respawnLocation", -1, index)
				if Config.Debug then
					print(string.format("[bulgar_wilds] Horse respawn for locations #%d (%s)", index, data.model))
				end
            end
        end)
    end
end)
