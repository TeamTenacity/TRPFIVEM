ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
  ESX = obj
end)


RegisterServerEvent('esx_truck_inventory:getInventory')
AddEventHandler('esx_truck_inventory:getInventory', function(plate)
  local inventory_ = {}
  local _source = source
  MySQL.Async.fetchAll(
    'SELECT * FROM `truck_inventory` WHERE `plate` = @plate',
    {
      ['@plate'] = plate
    },
    function(inventory)
      if inventory ~= nil and #inventory > 0 then
        for i=1, #inventory, 1 do
          table.insert(inventory_, {
            name      = inventory[i].item,
            label      = inventory[i].name,
            count     = inventory[i].count
          })
        end
      end

    local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_truck_inventory:getInventoryLoaded', xPlayer.source, inventory_)
    end)
end)


RegisterServerEvent('esx_truck_inventory:removeInventoryItem')
AddEventHandler('esx_truck_inventory:removeInventoryItem', function(plate, item, count)
local plate2 = plate
local item2 = item
local count2 = count
  local inventory_ = {}
  local _source = source
  MySQL.Async.fetchAll(
    'SELECT * FROM `truck_inventory` WHERE `plate` = @plate AND `item`= @item',
    {
      ['@plate'] = plate,
      ['@item'] = item,
    },
    function(inventory)
      if inventory ~= nil and #inventory > 0 then
        for i=1, #inventory, 1 do
			if inventory[i].weapon == 0 then
				TriggerEvent('esx_truck_inventory:removeInventoryItem2',plate2,item2,count2,_source)
			else
				TriggerEvent('esx_truck_inventory:removeInventoryItemW',plate2,item2,count2,_source)
			end
        end
      end
      end)
    end)

RegisterServerEvent('esx_truck_inventory:removeInventoryItem2')
AddEventHandler('esx_truck_inventory:removeInventoryItem2', function(plate, item, count, source)
  local _source = source
  local inventory_ = {}
  MySQL.Async.fetchAll(
    'UPDATE `truck_inventory` SET `count`= `count` - @qty WHERE `plate` = @plate AND `item`= @item',
    {
      ['@plate'] = plate,
      ['@qty'] = count,
      ['@item'] = item
    },
    function(result)
      local xPlayer  = ESX.GetPlayerFromId(source)
      if xPlayer ~= nil then
        xPlayer.addInventoryItem(item, count)
      end
    end)
end)

RegisterServerEvent('esx_truck_inventory:removeInventoryItemW')
AddEventHandler('esx_truck_inventory:removeInventoryItemW', function(plate, item, count, source)
  local _source = source
  MySQL.Async.fetchAll(
    'UPDATE `truck_inventory` SET `count`= `count` - @qty WHERE `plate` = @plate AND `item`= @item',
    {
      ['@plate'] = plate,
      ['@qty'] = count,
      ['@item'] = item
    },
    function(result)
      local xPlayer  = ESX.GetPlayerFromId(source)
      if xPlayer ~= nil then
        xPlayer.addWeapon(item, 10000)
      end
    end)
end)

RegisterServerEvent('esx_truck_inventory:addInventoryItem')
AddEventHandler('esx_truck_inventory:addInventoryItem', function(type, model, plate, item, count, name)
  local _source = source
  MySQL.Async.fetchAll(
    'INSERT INTO truck_inventory (item,count,plate,name) VALUES (@item,@qty,@plate,@name) ON DUPLICATE KEY UPDATE count=count+ @qty',
    {
      ['@plate'] = plate,
      ['@qty'] = count,
      ['@item'] = item,
      ['@name'] = name,
    },
    function(result)
      local xPlayer  = ESX.GetPlayerFromId(_source)
      xPlayer.removeInventoryItem(item, count)
    end)
end)

RegisterServerEvent('esx_truck_inventory:addInventoryItemW')
AddEventHandler('esx_truck_inventory:addInventoryItemW', function(type, model, plate, item, count, name)
  local _source = source
  MySQL.Async.fetchAll(
    'INSERT INTO truck_inventory (item,count,plate,weapon,name) VALUES (@item,@qty,@plate,@weapon,@name) ON DUPLICATE KEY UPDATE count=count+ @qty',
    {
      ['@plate'] = plate,
      ['@qty'] = count,
      ['@item'] = item,
      ['@name'] = name,
      ['@weapon'] = "1",
    },
    function(result)
      local xPlayer  = ESX.GetPlayerFromId(_source)
      xPlayer.removeWeapon(item, count)
    end)
end)