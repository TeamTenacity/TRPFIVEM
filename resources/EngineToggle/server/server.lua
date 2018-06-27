local CurrentVersion = '2.2.0'

AddEventHandler('chatMessage', function(source, n, msg)
	local Message = string.lower(msg)
	if (Message == "/engine") then
		TriggerClientEvent('EngineToggle:Engine', source)
		CancelEvent()
	end
end)

PerformHttpRequest("https://raw.githubusercontent.com/Flatracer/EngineToggle_Resources/master/VERSION", function(Error, NewestVersion, Header)
	PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/EngineToggle_Resources/master/CHANGES', function(Error, Changes, Header)
		print('\n')
		print('####################################################################')
		print("########################## Engine Toggle ###########################")
		print('####################################################################')
		print('#####                  Current Version: ' .. CurrentVersion .. '                  #####')
		print('#####                   Newest Version: ' .. NewestVersion .. '                  #####')
		print('####################################################################')
		if CurrentVersion ~= NewestVersion then
			print('##### Outdated, please check the Topic for the newest Version! #####')
			print('####################################################################')
			print('CHANGES:\n' .. Changes)
		else
			print('#####                        Up to date!                       #####')
			print('####################################################################')
		end
		print('\n')
	end)
end)
