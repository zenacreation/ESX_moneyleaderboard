lua54 'yes'

fx_version 'cerulean'
game 'gta5'

author 'zenacreation'
description 'ESX Leaderboard - Top Richest Players'
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_script 'client.lua'
