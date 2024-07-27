fx_version 'cerulean'
game 'gta5'

author 'Littlepork1'
description 'Mission de livraison avec paiement'
version '1.0.0'

-- Les scripts serveur et client
server_scripts {
    'server.lua'
}

client_scripts {
    'vehicle_delivery.lua'
}

-- Dépendances
dependencies {
    'qb-core'
}
