local prices = {
{id = 0, price = 36}, --compacts
{id = 1, price = 40}, --sedans
{id = 2, price = 52}, --SUV's
{id = 3, price = 64}, --coupes
{id = 4, price = 50}, --muscle
{id = 5, price = 65}, --sport classic
{id = 6, price = 72}, --sport
{id = 7, price = 100}, --super
{id = 8, price = 22}, --motorcycle
{id = 9, price = 38}, --offroad
{id = 10, price = 44}, --industrial
{id = 11, price = 34}, --utility
{id = 12, price = 34}, --vans
{id = 13, price = 4}, --bicycles
{id = 14, price = 2}, --boats
{id = 15, price = 4200}, --helicopter
{id = 16, price = 90}, --plane
{id = 17, price = 29}, --service
{id = 18, price = 50}, --emergency
{id = 19, price = 62}, --military
{id = 20, price = 34} --commercial
}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent("getVehPrice")
AddEventHandler("getVehPrice", function(class)
	for k, price in pairs(prices) do
		if class == price.id then
			vehPrice = price.price
			TriggerClientEvent("setVehPrice", -1, vehPrice)
		end
	end
end)

RegisterServerEvent("sellVehicle")
AddEventHandler("sellVehicle", function(vehPrice)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addAccountMoney('black_money', vehPrice)
	CancelEvent()
	end)

RegisterServerEvent("resetMoney")
AddEventHandler("resetMoney", function()
	TriggerEvent("es:getPlayerFromId", source, function(user)
		user.setMoney(0)
	end)
end)


