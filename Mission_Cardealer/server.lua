local QBCore = exports['qb-core']:GetCoreObject()

-- Événement pour payer le joueur
RegisterNetEvent('payPlayer')
AddEventHandler('payPlayer', function(playerId, amount)
    local Player = QBCore.Functions.GetPlayer(playerId)
    
    if Player then
        Player.Functions.AddMoney('cash', amount, 'mission-payment')
        print("Paiement de " .. amount .. " effectué pour le joueur avec l'ID: " .. playerId)
    else
        print("Erreur: Joueur non trouvé pour le paiement.")
    end
end)

-- Callback pour vérifier le job du joueur
QBCore.Functions.CreateCallback('checkJob', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player and Player.PlayerData.job.name == 'cardealer' then
        cb(true)
    else
        cb(false)
    end
end)
