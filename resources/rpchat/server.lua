function getIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
  if result[1] ~= nil then
    local identity = result[1]

    return {
      firstname   = identity['firstname'],
      lastname  = identity['lastname'],
      dateofbirth = identity['dateofbirth'],
      sex   = identity['sex'],
      height    = identity['height']
    }
  else
    return {
      firstname   = '',
      lastname  = '',
      dateofbirth = '',
      sex   = '',
      height    = ''
    }
    end
end

AddEventHandler('chatMessage', function(source, name, message)
    if string.sub(message,1,string.len("/"))=="/" then
        --ne doit rien se passer c'est une commande
    else
    local identity = getIdentity(source)
        TriggerClientEvent("sendProximityMessage", -1, source, identity.firstname .. " " .. identity.lastname, message)
    end
    CancelEvent()
end)

TriggerEvent('es:addCommand', 'me', function(source, args, user)
 -- table.remove(args, 1)
  --local pname = GetPlayerName(source)
  local identity = getIdentity(source)
  TriggerClientEvent("sendProximityMessageMe", -1, source , identity.firstname .. " " .. identity.lastname, table.concat(args, " "))
end)

TriggerEvent('es:addCommand', 'do', function(source, args, user)
--  table.remove(args, 1)
  local identity = getIdentity(source)
  TriggerClientEvent("sendProximityMessageDo", -1, source, identity.firstname .. " " .. identity.lastname, table.concat(args, " "))
end)

TriggerEvent('es:addCommand', 'id', function(source, args, user)
  table.remove(args, 1)
  local identity = getIdentity(source)
  TriggerClientEvent("showid", -1, source, identity.firstname .. " " .. identity.lastname, table.concat(args, " "))
end)

TriggerEvent('es:addCommand', 'help', function(source, args, user)
  table.remove(args, 1)
  local identity = getIdentity(source)
  TriggerClientEvent('chatMessage', source, "(Help)", {244, 204, 0}, "^4Looks like you're a little lost...")
  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^7Use ^3/commands^7 to see a list of text commands")
  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^7Use ^3/controls^7 to see a list of hotkeys for buttons")
end)

TriggerEvent('es:addCommand', 'commands', function(source, args, user)
  table.remove(args, 1)
  local name = getIdentity(source)
  TriggerClientEvent('chatMessage', source, "(Commands)", {155, 0, 0}, "")
  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^4/ooc^7 and ^4/o^7 = Out of Character  ^4/looc^7 = Local OOC  ^4/bleet^7 or ^4/b^7 = Bleeter")
  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^4/advert^7  = Advertisement  ^4/news^7 = News")
  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^4/me^7 and ^4/do^7 = Character Text-Actions (ex. '^6John Doe is unconcious^7')")
  --TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^4/k^7 = Surrender (use twice to cancel animation)")
  --TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^4/engine^7 = Toggle engine ^2ON^7/^1OFF")
end)

TriggerEvent('es:addCommand', 'controls', function(source, args, user)
  table.remove(args, 1)
  local name = getIdentity(source)
  TriggerClientEvent('chatMessage', source, "(Controls)", {0, 160, 0}, "")
  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^4[F1]^7 = Phone  ^4[F2]^7 = Inventory  ^4[F3]^7 = Emote Menu  ^4[F6]^7 = Job Menu  ^4[F7]^7 = Invoice")
  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^4[Z]^7 = Playerlist  ^4[X]^7 = Hands Up  ^4[B]^7 = Point  ^4[U]^7 = Ragdoll")
  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^1(In-Vehicle) ^4[B]^7 = Cruise Control  ^4[M]^7 = Vehicle Menu  ^4[←]^7/^4[→]^7 = Left/Right Indicators")
  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^1(In-Vehicle) ^4[↓]^7 = Hazards On/Off  ^4[L]^7 = Lock/Unlock Vehicle")
end)

--TriggerEvent('es:addCommand', 'character', function(source, args, user)
--  table.remove(args, 1)
--  local name = getIdentity(source)
--  TriggerClientEvent('chatMessage', source, "(Character Options)", {0, 160, 0}, "")
--  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^4/char^7 will show active character ^4/charlist^7 will provide a list of your characters")
--  TriggerClientEvent('chatMessage', source, "", {244, 204, 0}, "^4/charselect [1 or 2]^7 will choose your character")
--end)

AddEventHandler('chatMessage', function(source, name, msg)
  if msg:sub(1, 1) == "/" then
    sm = stringsplit(msg, " ");
     if sm[1] == "/bleet" then
      local identity = getIdentity(source)
         CancelEvent()
  TriggerClientEvent('chatMessage', -1, "Bleeter | @" .. identity.firstname .. "" .. identity.lastname, {46, 175, 91}, string.sub(msg,7))
     end
  end
end)

AddEventHandler('chatMessage', function(source, name, msg)
  if msg:sub(1, 1) == "/" then
    sm = stringsplit(msg, " ");
     if sm[1] == "/b" then
      local identity = getIdentity(source)
         CancelEvent()
  TriggerClientEvent('chatMessage', -1, "Bleeter | @" .. identity.firstname .. "" .. identity.lastname, {46, 175, 91}, string.sub(msg,3))
     end
  end
end)

--AddEventHandler('chatMessage', function(source, name, msg)
--  if msg:sub(1, 1) == "/" then
--    sm = stringsplit(msg, " ");
--     if sm[1] == "/ooc" then
--      local identity = getIdentity(source)
--         CancelEvent()
--    TriggerClientEvent('chatMessage', -1, "OOC | " .. identity.firstname .. " " .. identity.lastname, { 10, 10, 10 }, string.sub(msg,5))
--     end
--  end
--end)

--AddEventHandler('chatMessage', function(source, name, msg)
--  if msg:sub(1, 1) == "/" then
--    sm = stringsplit(msg, " ");
--     if sm[1] == "/o" then
--      local identity = getIdentity(source)
--         CancelEvent()
--    TriggerClientEvent('chatMessage', -1, "OOC | " .. identity.firstname .. " " .. identity.lastname, { 10, 10, 10 }, string.sub(msg,3))
--     end
--  end
--end)

--AddEventHandler('chatMessage', function(source, name, msg)
--  if msg:sub(1, 1) == "/" then
--    sm = stringsplit(msg, " ");
--    if sm[1] == "/looc" then
--      local name = getIdentity(source)
--         CancelEvent()
--      TriggerClientEvent('sendProximityMessageLOOC', -1, source, name, message, string.sub(msg,6))
--     end
--  end
--end)

--[[AddEventHandler('chatMessage', function(source, name, msg)
  if msg:sub(1, 1) == "/" then
    sm = stringsplit(msg, " ");
     if sm[1] == "/ad" then
      local identity = getIdentity(source)
         CancelEvent()
    TriggerClientEvent('chatMessage', -1, "Advertisement | " .. identity.firstname .. " " .. identity.lastname, { 216, 152, 49 }, string.sub(msg,4))
     end
  end
end)--]]

AddEventHandler('chatMessage', function(source, name, msg)
  if msg:sub(1, 1) == "/" then
    sm = stringsplit(msg, " ");
     if sm[1] == "/advert" then
      local identity = getIdentity(source)
         CancelEvent()
    TriggerClientEvent('chatMessage', -1, "Advertisement | " .. identity.firstname .. " " .. identity.lastname, { 216, 152, 49 }, string.sub(msg,8))
     end
  end
end)

AddEventHandler('chatMessage', function(source, name, msg)
  if msg:sub(1, 1) == "/" then
    sm = stringsplit(msg, " ");
     if sm[1] == "/news" then
      local identity = getIdentity(source)
         CancelEvent()
    TriggerClientEvent('chatMessage', -1, "News | " .. identity.firstname .. " " .. identity.lastname, { 155, 0, 0 }, string.sub(msg,6))
     end
  end
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

function makeArgs(cmd)
    args = {}
    for i = 2, #cmd, 1 do
        table.insert(args, cmd[i])
    end
    return args
end

