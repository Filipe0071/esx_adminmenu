fx_version "adamant"

game "gta5"

lua54 "yes"

shared_scripts {"@es_extended/imports.lua", "@ox_lib/init.lua", "config.lua"}

server_scripts {"@oxmysql/lib/MySQL.lua", "server/*.lua"}

client_scripts {"client/*.lua"}

ui_page "ui/index.html"

files {"ui/*"}

dependency "es_extended"