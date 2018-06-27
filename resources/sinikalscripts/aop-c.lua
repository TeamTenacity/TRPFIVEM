CurrentAOP = "San"
CurrentAOP2 = "Andreas"
peacetime = false

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('aop:requestSync')
end)

RegisterNetEvent('aop:updateAOP')
AddEventHandler('aop:updateAOP', function(newCurrentAOP, newCurrentAOP2, newPeacetime)
    CurrentAOP = newCurrentAOP
	CurrentAOP2 = newCurrentAOP2
	peacetime = newPeacetime
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		if not peacetime then
			DrawText2(0.663, 1.314, 1.0,1.0,0.45, "AOP: " .. CurrentAOP .. " " .. CurrentAOP2, 255, 255, 255, 255)
		else
			DrawText2(0.663, 1.314, 1.0,1.0,0.45, "AOP: " .. CurrentAOP .. " " .. CurrentAOP2, 255, 0, 0, 255)
		end
	end
end)

function DrawText2(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end