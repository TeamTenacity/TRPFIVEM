AddEventHandler('chatMessage', function(source, name, message)
	if message:sub(1, 3) == '/td' then
		TriggerClientEvent('topdown:td',source)
		CancelEvent()
	end
end)