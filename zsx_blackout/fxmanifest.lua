fx_version 'cerulean'
games{"gta5"}

author ".zeusx#0001"
description "FiveM Blackout Watch Dogs"

server_script {
	'server/server.lua',
	'@mysql-async/lib/MySQL.lua', 
}

client_script {
	'client/client.lua' 
}

shared_script 'config.lua'


