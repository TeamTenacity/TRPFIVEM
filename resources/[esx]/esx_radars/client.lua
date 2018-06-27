--===============================================--===============================================
--= stationary radars based on  https://github.com/DreanorGTA5Mods/StationaryRadar           =
--===============================================--===============================================

ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local radares = {
    {x = 379.68807983398, y = -1048.3527832031, z = 29.250692367554, speed = 40}, -- Leigon
    {x = -253.10794067383, y = -630.20385742188, z = 33.002685546875, speed = 40}, -- By Real Estate
    {x = 1574.1353759766, y = 984.79626464844, z = 77.04525604248, speed = 70}, -- Senora (Pipes)
    {x = 2219.8210449219, y = 3011.7722167969, z = 44.654444122314, speed = 50}, -- Rt. 68 (Yellow Jack)
    {x = 2511.9743652344, y = 4133.5883789063, z = 36.986963653564, speed = 50}, -- E. Joshua (Grapeseed turnoff)
    {x = 1673.7271728516, y = 4280.419921875, z = 40.435766601562, speed = 50}, -- Grapeseed Main St.
    {x = -418.9107660156, y = 5952.2006835938, z = 31.327101135254, speed = 70}, -- Great Ocean, Paleto
    {x = -2590.4184570313, y = 31445.3349609375, z = 13.020771408081, speed = 70}, -- Great Ocean, Zancudo tunnel
    {x = 202.42625427246, y = 193.56840515137, z = 104.97498931885, speed = 45}, -- Bank
}

Citizen.CreateThread(function()
    while true do
        Wait(0)
        for k,v in pairs(radares) do
            local player = GetPlayerPed(-1)
            local coords = GetEntityCoords(player, true)
            if Vdist2(radares[k].x, radares[k].y, radares[k].z, coords["x"], coords["y"], coords["z"]) < 50 then
                if PlayerData.job ~= nil and not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
                    checkSpeed(radares[k].speed)
                end
            end
        end
    end
end)

function checkSpeed(maxspeed)
    local pP = GetPlayerPed(-1)
    local speed = GetEntitySpeed(pP)
    local vehicle = GetVehiclePedIsIn(pP, false)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    local plate = GetVehicleNumberPlateText(vehicle)
    local mphspeed = math.ceil(speed*2.236936)
    if mphspeed > maxspeed and driver == pP then
        Citizen.Wait(250)
        TriggerServerEvent('fineAmount')
        ESX.ShowNotification("You've been fined ~g~"..Config.Fine.."~s~ for ~r~speeding.~s~ Limit: ~b~" ..maxspeed.. "~s~ Your speed: ~b~"..mphspeed.."~s~." )
    end
end
