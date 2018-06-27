local PlayersWashing = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function WashMoney(source,percent)
	local _source=source
	SetTimeout(2500, function()

		if PlayersWashing[source] == true then
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local blackMoney = xPlayer.getAccount('black_money')
			--local _percent
				if blackMoney.money < Config.Slice then
					TriggerClientEvent('esx_moneywash:showNotification', source, '~y~Launder Money\n~b~Minimum: ~g~$' .. Config.Slice)
				else
					
					bonus=math.random(10,65)
					local washedMoney = math.floor(Config.Slice / 100 * 80 + bonus)
					
					xPlayer.removeAccountMoney('black_money', Config.Slice)
					xPlayer.addMoney(washedMoney)

					WashMoney(source,_percent)
				end

			
		end
	end)
end

RegisterServerEvent('esx_moneywash:startWash')
AddEventHandler('esx_moneywash:startWash', function(percent)
	PlayersWashing[source] = true
	TriggerClientEvent('esx_moneywash:showNotification', source, '~g~Laundering money...\n~b~($250 minimum)')
	WashMoney(source,percent)
end)

RegisterServerEvent('esx_moneywash:pasLa')
AddEventHandler('esx_moneywash:pasLa', function()
	PlayersWashing[source] = false
	TriggerClientEvent('esx_moneywash:showNotification', source, '~r~Laundering currently unavailable.\nStop by to check another time.')
end)


RegisterServerEvent('esx_moneywash:stopWash')
AddEventHandler('esx_moneywash:stopWash', function()
	PlayersWashing[source] = false
end)
