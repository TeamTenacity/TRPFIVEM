-- Created by Murtaza

TriggerEvent('es:addGroupCommand', 'fix', 'admin', function(source, args, user)
		TriggerClientEvent('murtaza:fix', source)
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end)