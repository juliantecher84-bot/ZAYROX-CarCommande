RegisterCommand("car", function(source, args, rawCommand)
    local vehicleName = args[1]

    if not vehicleName then
        TriggerEvent('chat:addMessage', {
            args = {"🚨 Utilisation: /car [nom_du_véhicule]"}
        })
        return
    end

    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)

    -- Charge le modèle du véhicule
    local model = GetHashKey(vehicleName)
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(100)
    end

    -- Crée le véhicule
    local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    -- Place le joueur dans le véhicule
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    -- Libère le modèle
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(model)
end, false)