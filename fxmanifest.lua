fx_version 'cerulean'
games { 'gta5' }

author 'SecondLife'
description 'Simple NPC Spawn Script'
version '1.0.0'

client_scripts {
    'client.lua',
}

shared_scripts{
    "config.lua" -- config ist in shared, damit es server und client ausgeführt wird für den print
}


client_script "@Badger-Anticheat/acloader.lua"