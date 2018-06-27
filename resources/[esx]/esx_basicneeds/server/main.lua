ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- ESX.RegisterUsableItem('bread', function(source)

-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	xPlayer.removeInventoryItem('bread', 1)

-- 	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
-- 	TriggerClientEvent('esx_basicneeds:onEat', source)
-- 	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))

-- end)

ESX.RegisterUsableItem('dontac', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('dontac', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEatDT', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_dontac'))

end)

ESX.RegisterUsableItem('water', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_water'))

end)

ESX.RegisterUsableItem('cig', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cig', 1)

	TriggerClientEvent('esx_basicneeds:onCig', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cig'))

end)