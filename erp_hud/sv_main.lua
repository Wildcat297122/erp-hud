local HarnessVehicles = {}

RegisterNetEvent("harness")
AddEventHandler("harness", function(vehicle)
    HarnessVehicles[vehicle] = true
    TriggerClientEvent('newHarness', -1, HarnessVehicles)
end)

RegisterNetEvent('echorp:playerSpawned')
AddEventHandler('echorp:playerSpawned', function(data)
    TriggerClientEvent('newHarness', data.source, HarnessVehicles)
end)

RegisterNetEvent("SetVehicleNitroPurgeEnabled")
AddEventHandler("SetVehicleNitroPurgeEnabled", function(vehicle, plate, amount)
    TriggerClientEvent('erp-purge', -1, vehicle)
    if math.random(100) == math.random(25) then
        if amount then
            TriggerClientEvent('NetworkNos', -1, plate, amount-math.random(1,3), vehicle, false)
        end
    end
end)