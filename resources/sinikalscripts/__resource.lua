resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
server_script "@mysql-async/lib/MySQL.lua"
client_script "va_client.lua"
server_script "va_server.lua"
client_script "trains-c.lua"
server_script "trains-s.lua"
client_script "topdown-c.lua"
server_script "topdown-s.lua"
client_script "ragdoll.lua"
client_script "snowballs-c.lua"
client_script "crouch-c.lua"
client_script "fix-c.lua"
server_script "fix-s.lua"
client_script "antitheft-c.lua"
client_script "handsup-c.lua"
server_script "handsup-s.lua"
client_script "heli-c.lua"
server_script "heli-s.lua"
client_script "looc-c.lua"
server_script "looc-s.lua"
client_script "neverwanted-c.lua"
client_script "ads-c.lua"
server_script "ads-s.lua"
client_script "afkkick-c.lua"
server_script "afkkick-s.lua"
client_script 'cl_radar.lua'
client_script {
	'vem-c.lua',
	'vem-gui.lua',
}
client_script "jailer-c.lua"
server_script "jailer-s.lua"
client_script "tackle-c.lua"
client_script "nomoreshotty-c.lua"
server_script "nomoreshotty-s.lua"
client_script "aim-c.lua"
client_script "famchat-c.lua"
client_script "binoc-c.lua"
server_script "binoc-s.lua"
client_script "aop-c.lua"
server_script "aop-s.lua"
client_script "celldoor-c.lua"
server_script "celldoor-s.lua"
client_script "idoverhead-c.lua"
client_script "vs_c.lua"
server_script "vs_s.lua"

exports {
    'getSurrenderStatus',
}

ui_page "nui/radar.html"

files {
	"nui/digital-7.regular.ttf", 
	"nui/radar.html",
	"nui/radar.css",
	"nui/radar.js",
	'carcols.meta',
}

data_file 'CARCOLS_FILE' 'carcols.meta'