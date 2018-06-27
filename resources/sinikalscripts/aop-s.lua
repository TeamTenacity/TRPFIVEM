CurrentAOP = "San"
CurrentAOP2 = "Andreas"
peacetime = false

AddEventHandler('chatMessage', function(source, name, msg)
	local args = stringsplit(msg, " ")
	if args[1] == "/aop" then
		if tablelength(args) > 2 then
			CancelEvent()
			CurrentAOP = args[2]
			CurrentAOP2 = args[3]
			TriggerEvent('aop:requestSync')
			TriggerClientEvent('chatMessage', -1, '^1[!]', {255, 255, 255}, " ^7AOP has been changed to ^1" .. CurrentAOP .. " " .. CurrentAOP2 .. '^7.\n Please finish your current RP and move.')
		else
			TriggerClientEvent('chatMessage', -1, '', {255, 255, 255}, '^7Incorrect syntax.')
   		end
	elseif args[1] == "/peacetime" then
		peacetime = not peacetime
		TriggerEvent('aop:requestSync')
		TriggerClientEvent('chatMessage', -1, '^1[!]', {255, 255, 255}, 'Peacetime toggled.')
	end
end)

RegisterServerEvent('aop:requestSync')
AddEventHandler('aop:requestSync', function()
    TriggerClientEvent('aop:updateAOP', -1, CurrentAOP, CurrentAOP2, peacetime)
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end