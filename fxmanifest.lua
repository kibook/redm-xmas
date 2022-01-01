fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

dependency 'objectloader'
dependency 'weathersync'

files {
	'xmas.xml',
	'ui/index.html',
	'ui/style.css',
	'ui/script.js'
}

ui_page 'ui/index.html'

objectloader_map 'xmas.xml'

server_script 'server.lua'
client_script 'client.lua'
client_script 'phonographs.lua'
client_script 'trains.lua'
