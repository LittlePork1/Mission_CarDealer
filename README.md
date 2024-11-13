# **🚗 Mission CarDealer - Vehicle Delivery for QBCore 🚗**

## Welcome to LittlePork1's very first script!

### This script is designed to add an immersive vehicle delivery mission for car dealers on GTA V servers using the QBCore framework. By integrating this script into your server, you provide your players with a unique vehicle delivery experience, complete with rewards and challenges, making the dealership role more dynamic and entertaining!

🎉 Features

    🔑 Delivery Mission: Car dealers can start a mission to deliver a vehicle to a specific point.
    🚗 Randomized Vehicles: A random vehicle is assigned for each mission to add variety.
    📍 Dynamic Blips: Clear map blips guide the player from the starting point to the delivery destination.
    💰 Rewards: Automatic payment is provided to players after a successful delivery.
    🛑 Failure Handling: If the vehicle is lost, the mission automatically fails.

**🌟 Requirements**

Before adding this script, make sure your server has the following:

    QBCore Framework
    qb-core and qb-vehiclekeys resources for key and vehicle management.

**📦 Installation**

### Step 1: Clone the Project

Clone the repository directly into your server's resources folder:

git clone https://github.com/LittlePork1/Mission_CarDealer.git

### Step 2: Add the Resource

Place the Mission_CarDealer folder in your resources/[qb] folder.

### Step 3: Configure Startup

In your server.cfg, add the following line to start the resource with the server:

ensure Mission_CarDealer

**🚀 Usage**

Starting a Mission

    Access Required: Only players with the cardealer job can start a mission.
    Starting Point: A "Start Delivery" blip will appear for players with the dealer role.
    Starting the Mission: By approaching the starting point and pressing E, the player will begin the mission. A random vehicle is generated, and a delivery point is assigned.
    Successful Delivery: If the player reaches the delivery point with the vehicle, they receive a payment of 250.
    Mission Failure: If the player loses the vehicle, the mission is canceled, and they are notified of the failure.

Available Commands

    /finlivraison: Cancels the current mission, useful if the player wants to abandon the delivery.

**⚙️ Configuration and Customization**

You can adjust several parameters within the script:

    Mission Start Location: Modifiable through startMissionPoint.
    Vehicle Spawn Point: Configurable in spawnPoint.
    Delivery Points: Add or modify points in deliveryPoints.
    Available Vehicles: Add or remove models in vehicles to diversify the deliveries.

**📂 Project Structure**

Mission_CarDealer/
├── client.lua      # Client-side script
├── server.lua      # Server-side script
├── fxmanifest.lua  # Resource configuration for FiveM
└── README.md       # Documentation

## Thank you for checking out and using LittlePork1's first script! This project was created with a lot of passion to enhance the gameplay experience for the FiveM community. Your support and feedback are much appreciated!
