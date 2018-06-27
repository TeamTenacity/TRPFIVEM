-- [[-----------------------------------------------------------------------

	-- ActionMenu By WolfKnight
	-- Script By Kvetz
	-- Thanks Titch For The Help!

-- ---------------------------------------------------------------------]]--


resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "nui/ui.html"

files {
	"nui/ui.html",
	"nui/ui.js", 
	"nui/ui.css"
}

client_script 'cl_action.lua'
client_script 'client.lua'
server_script 'server.lua'
client_script 'weapon.lua'
client_script 'devh.lua'
client_script 'buttons.lua'
server_script 'serverdeath.lua'
client_script 'serverclient.lua'




