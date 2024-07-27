local QBCore = exports['qb-core']:GetCoreObject()

local startMissionPoint = { x = -1246.85, y = -348.18, z = 37.33 } -- Point de départ de la mission
local spawnPoint = { x = 1199.86, y = -3237.85, z = 5.77, heading = 359.3 } -- Point de spawn du véhicule
local deliveryPoints = {
    { x = -1230.77, y = -352.12, z = 37.33 }, -- Premier point de livraison
    -- Ajoutez autant de points de livraison que nécessaire
}

local vehicles = {
    "adder",       -- Supercar
    "zentorno",    -- Supercar
    "t20",         -- Supercar
    "infernus",    -- Supercar
    "entityxf",    -- Supercar
    "banshee",     -- Sports car
    "comet2",      -- Sports car
    "ninef",       -- Sports car
    "feltzer2",    -- Sports car
    "buffalo",     -- Muscle car
    "dominator",   -- Muscle car
    "vigero",      -- Muscle car
    "sabregt",     -- Muscle car
    "baller",      -- SUV
    "xls",         -- SUV
    "dubsta",      -- SUV
    "huntley",     -- SUV
    "rebel",       -- Pickup truck
    "rancherxl",   -- Pickup truck
    "dloader",     -- Pickup truck
    "brioso",      -- Compact car
    "panto",       -- Compact car
    "rumpo",       -- Van
    "speedo",      -- Van
    "prairie",     -- Hatchback
    "packer",      -- Truck
    "hauler"       -- Truck
}

local vehicle = nil
local missionStarted = false
local currentDeliveryPoint = nil
local deliveryBlip = nil
local startMissionBlip = nil

-- Fonction pour générer un point de livraison aléatoire
function GetRandomDeliveryPoint()
    return deliveryPoints[math.random(#deliveryPoints)]
end

-- Fonction pour choisir un véhicule aléatoire
function GetRandomVehicle()
    return vehicles[math.random(#vehicles)]
end

-- Fonction pour créer un blip sur la carte
function CreateDeliveryBlip(coords)
    if deliveryBlip then
        RemoveBlip(deliveryBlip)
    end
    deliveryBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(deliveryBlip, 1) -- Numéro du sprite du blip (1 est un point d'interrogation)
    SetBlipDisplay(deliveryBlip, 4)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipColour(deliveryBlip, 5) -- Couleur du blip (5 est le bleu)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Point de Livraison")
    EndTextCommandSetBlipName(deliveryBlip)
end

-- Fonction pour créer un blip pour le point de départ de la mission
function CreateStartMissionBlip()
    if not startMissionBlip then
        startMissionBlip = AddBlipForCoord(startMissionPoint.x, startMissionPoint.y, startMissionPoint.z)
        SetBlipSprite(startMissionBlip, 225) -- Numéro du sprite du blip
        SetBlipDisplay(startMissionBlip, 4)
        SetBlipScale(startMissionBlip, 0.9)
        SetBlipColour(startMissionBlip, 5) -- Couleur du blip (5 est le bleu)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Démarrer la livraison")
        EndTextCommandSetBlipName(startMissionBlip)
    end
end

-- Fonction pour supprimer le blip de démarrage
function RemoveStartMissionBlip()
    if startMissionBlip then
        RemoveBlip(startMissionBlip)
        startMissionBlip = nil
    end
end

-- Fonction pour démarrer la mission
function StartMission()
    if missionStarted then
        QBCore.Functions.Notify("La mission est déjà en cours.", "error")
        return
    end

    missionStarted = true
    local playerPed = PlayerPedId()
    local model = GetRandomVehicle() -- Choisir un véhicule aléatoire

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end

    -- Création du véhicule au point de spawn
    vehicle = CreateVehicle(model, spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.heading, true, false)
    SetVehicleNumberPlateText(vehicle, "DELIVERY")
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    -- Choisir un point de livraison aléatoire
    currentDeliveryPoint = GetRandomDeliveryPoint()
    CreateDeliveryBlip(currentDeliveryPoint) -- Créer le blip au point de livraison
    RemoveStartMissionBlip() -- Supprimer le blip de démarrage
    QBCore.Functions.Notify("Mission de livraison commencée. Rendez-vous au point de livraison indiqué sur la carte.", "success")

    -- Vérifier si le véhicule atteint le point de livraison
    Citizen.CreateThread(function()
        while missionStarted do
            Citizen.Wait(1000)
            if vehicle then
                local vehPos = GetEntityCoords(vehicle)
                local dist = Vdist(vehPos, currentDeliveryPoint.x, currentDeliveryPoint.y, currentDeliveryPoint.z)

                if dist < 10.0 then
                    -- Livraison réussie
                    EndMission(true)
                end
            else
                -- En cas de perte du véhicule, terminer la mission échouée
                EndMission(false)
            end
        end
    end)
end

-- Fonction pour terminer la mission
function EndMission(success)
    if not missionStarted then return end
    missionStarted = false

    if deliveryBlip then
        RemoveBlip(deliveryBlip) -- Supprimer le blip lorsque la mission est terminée
        deliveryBlip = nil
    end

    if startMissionBlip then
        RemoveBlip(startMissionBlip) -- Supprimer le blip de départ si il existe encore
        startMissionBlip = nil
    end

    if success then
        QBCore.Functions.Notify("Mission de livraison réussie !", "success")
        -- Récupérer l'ID du joueur et le payer
        local playerId = GetPlayerServerId(PlayerId())
        TriggerServerEvent('payPlayer', playerId, 250) -- Exemple de paiement de 250
    else
        QBCore.Functions.Notify("Mission échouée. Le véhicule a été perdu ou n'a pas atteint le point de livraison.", "error")
    end

    if vehicle then
        DeleteVehicle(vehicle)
        vehicle = nil
    end
end

-- Vérifier le job du joueur et créer les blips seulement si le joueur est un concessionnaire
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Vérifier toutes les secondes

        QBCore.Functions.TriggerCallback('checkJob', function(isCardealer)
            if isCardealer then
                CreateStartMissionBlip() -- Créer le blip pour démarrer la mission
            else
                RemoveStartMissionBlip() -- Retirer le blip si le joueur n'est plus un concessionnaire
            end
        end)
    end
end)

-- Vérifier si le joueur est à proximité du point de départ pour démarrer la mission
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local dist = Vdist(playerCoords, startMissionPoint.x, startMissionPoint.y, startMissionPoint.z)

        if dist < 5.0 then
            QBCore.Functions.DrawText3D(startMissionPoint.x, startMissionPoint.y, startMissionPoint.z, "[E] Démarrer Mission Livraison")
            if IsControlJustReleased(0, 38) then -- Touche "E"
                QBCore.Functions.TriggerCallback('checkJob', function(isCardealer)
                    if isCardealer then
                        StartMission()
                    else
                        QBCore.Functions.Notify("Vous devez être un concessionnaire pour commencer cette mission.", "error")
                    end
                end)
            end
        end
    end
end)

-- Commande pour terminer la mission manuellement
RegisterCommand("finlivraison", function(source, args, rawCommand)
    EndMission(false)
end, false)
