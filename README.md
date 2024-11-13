🚗 Mission CarDealer - Livraison de véhicules pour QBCore 🚗

Bienvenue dans le tout premier script de LittlePork1 !

Ce script est conçu pour ajouter une mission de livraison de véhicules immersive pour les concessionnaires (cardealer) sur les serveurs GTA V utilisant le framework QBCore. En intégrant ce script à votre serveur, vous offrez à vos joueurs une expérience unique de livraison de véhicules avec des récompenses et des défis, rendant le métier de concessionnaire plus dynamique et divertissant !
🎉 Fonctionnalités

    🔑 Mission de livraison : Les concessionnaires peuvent commencer une mission pour livrer un véhicule à un point spécifique.
    🚗 Véhicules aléatoires : Un véhicule est assigné au hasard à chaque mission pour plus de variété.
    📍 Blips dynamiques : Blips clairs sur la carte pour guider le joueur jusqu’au point de départ et la destination de livraison.
    💰 Récompenses : Paiement automatique des joueurs après une livraison réussie.
    🛑 Gestion des échecs : Si le véhicule est perdu, la mission échoue automatiquement.

🌟 Prérequis

Avant d’ajouter ce script, assurez-vous que votre serveur est configuré avec :

    QBCore Framework
    Ressources qb-core et qb-vehiclekeys pour la gestion des clés et des véhicules.

📦 Installation
Étape 1 : Cloner le projet

Clonez le dépôt directement dans votre dossier de ressources du serveur :

git clone https://github.com/LittlePork1/Mission_CarDealer.git

Étape 2 : Ajouter la ressource

Placez le dossier Mission_CarDealer dans votre dossier resources/[qb].
Étape 3 : Configurer le démarrage

Dans votre server.cfg, ajoutez la ligne suivante pour démarrer la ressource avec le serveur :

ensure Mission_CarDealer

🚀 Utilisation
Démarrer une mission

    Accès requis : Seuls les joueurs avec le métier cardealer peuvent démarrer une mission.
    Point de départ : Un blip "Démarrer la livraison" apparaît pour les concessionnaires.
    Début de la mission : En approchant du point et en appuyant sur E, le joueur démarre la mission. Un véhicule aléatoire est généré, et un point de livraison est assigné.
    Livraison réussie : Si le joueur atteint le point de livraison avec le véhicule, il reçoit un paiement de 250.
    Mission échouée : Si le joueur perd le véhicule, la mission est annulée et le joueur est informé de l’échec.

Commandes disponibles

    /finlivraison : Annule la mission en cours, pratique si le joueur souhaite abandonner la livraison.

⚙️ Configuration et Personnalisation

Vous pouvez ajuster plusieurs paramètres dans le script :

    Position de démarrage de la mission : Modifiable via startMissionPoint.
    Point de spawn du véhicule : Configurable dans spawnPoint.
    Points de livraison : Ajoutez ou modifiez les points dans deliveryPoints.
    Véhicules disponibles : Ajoutez ou retirez des modèles dans vehicles pour varier les livraisons.

📂 Structure du Projet

Mission_CarDealer/
├── client.lua      # Script côté client
├── server.lua      # Script côté serveur
├── fxmanifest.lua  # Configuration de la ressource pour FiveM
└── README.md       # Documentation

Merci d'avoir découvert et utilisé ce premier script de LittlePork1 ! C'est avec beaucoup de passion que ce projet a été créé pour offrir un gameplay enrichi à la communauté FiveM. Votre soutien et vos retours sont les bienvenus !