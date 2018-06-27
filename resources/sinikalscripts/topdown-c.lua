
topdown = false

function init()
	view1=CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(view1, 10.5, 13.6, 75.3)
	SetCamRot(view1, 0.0, 0.0, 180.0)
	SetCamFov(view1, 45.0)
end

function toggleTopDown()
	Citizen.CreateThread(function()
		topdown = not topdown
	
		if topdown == true then
			-- LockMinimapAngle(0.0)
			RenderScriptCams(true, 1, 500,  true,  true)
			StartScreenEffect("SwitchShortTrevorMid", 500, false)
			PlaySound(-1, "slow", "SHORT_PLAYER_SWITCH_SOUND_SET", 0, 0, 1)
		else
			UnlockMinimapAngle(0.0)
			RenderScriptCams(false, 1, 500,  true,  true)
			StartScreenEffect("SwitchShortMichaelMid", 500, false)
			PlaySound(-1, "slow", "SHORT_PLAYER_SWITCH_SOUND_SET", 0, 0, 1)
		end
		Citizen.Wait(250)
		StopScreenEffect()
	end)
end

function translateAngle(x1, y1, ang, offset)
  x1 = x1 + math.sin(ang) * offset
  y1 = y1 + math.cos(ang) * offset
  return {x1, y1}
end

function processCTWCam()
	if IsPedInAnyVehicle(localPlayer, false) == 1 then
		x,y,z = table.unpack(GetEntityCoords(GetVehiclePedIsIn(localPlayer, false)))
		rotx, roty, rotz = table.unpack(GetEntityRotation(GetVehiclePedIsIn(localPlayer, false)))
		
		if IsEntityUpsidedown(GetVehiclePedIsIn(localPlayer, false)) == 1 then 
			rotz = -rotz 
		end
		
		speed = GetEntitySpeed(GetVehiclePedIsIn(localPlayer, false))/2
		-- x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(localPlayer, false), 0.0, -15.0+speed/4, 0.0))
		local ang = 0
		local cz = GetGameplayCamRelativeHeading()
		local rz = (rotz+cz)+ang
		local markPos = translateAngle(x, y, math.rad(-rz), -15+speed/4)
		local x, y = table.unpack(markPos)
		SetCamCoord(view1, x, y, z+25)
		SetCamRot(view1, -50.0, 0.0, rz)
		
	else
		x,y,z = table.unpack(GetEntityCoords(localPlayer))
		rotx, roty, rotz = table.unpack(GetEntityRotation(localPlayer))
		
		if IsEntityUpsidedown(GetVehiclePedIsIn(localPlayer, false)) == 1 then 
			rotz = -rotz 
		end
		
		-- x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(localPlayer, 0.0, -15.0, 0.0))
		local ang = 0
		local cz = GetGameplayCamRelativeHeading()
		local rz = (rotz+cz)+ang
		local markPos = translateAngle(x, y, math.rad(-rz), -15)
		local x, y = table.unpack(markPos)
		SetCamCoord(view1, x, y, z+25)
		SetCamRot(view1, -50.0, 0.0, rz)
	end
	
	-- local ang = 0
	-- local ped = GetPlayerPed(-1)
	-- local pos = GetEntityCoords(ped)
	-- local px, py, pz = table.unpack(pos)
	-- local rot = GetEntityRotation(ped)
	-- local rx, ry, rz = table.unpack(rot)
	-- local cz = GetGameplayCamRelativeHeading()
	-- local rz = (rz+cz)+ang
	-- local markPos = translateAngle(px, py, math.rad(-rz), 1)
	-- local x, y = table.unpack(markPos)
end

function processTopDownCam()
	if IsPedInAnyVehicle(localPlayer, false) == 1 then
		x,y,z = table.unpack(GetEntityCoords(GetVehiclePedIsIn(localPlayer, false)))
		rotx, roty, rotz = table.unpack(GetEntityRotation(GetVehiclePedIsIn(localPlayer, false)))
		-- SetEntityRotation(GetVehiclePedIsIn(localPlayer, false), 0.0, 0.0, rotz, false, true)
		
		speed = GetEntitySpeed(GetVehiclePedIsIn(localPlayer, false))/2
		x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(localPlayer, false), 0.0, 0.0+speed/2, 0.0))
		SetCamCoord(view1, x, y, z+25.0+speed*2)
		SetCamRot(view1, -90.0, 0.0, 0.0)
		
	else
		x,y,z = table.unpack(GetEntityCoords(localPlayer))
		rotx, roty, rotz = table.unpack(GetEntityRotation(localPlayer))
		
		SetCamCoord(view1, x, y, z+25.0)
		SetCamRot(view1, -90.0, 0.0, 0.0)
	end
end

function processTopDown()
while true do Citizen.Wait(0)
	localPlayer = GetPlayerPed(-1)
	
	processCTWCam()
	-- processTopDownCam()
	
	end
end

Citizen.CreateThread(processTopDown)
Citizen.CreateThread(init)

RegisterNetEvent('topdown:td')
AddEventHandler('topdown:td', toggleTopDown)