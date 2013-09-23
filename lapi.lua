if not lapi then
    dofile("sys/lua/lapi/player.lua")
    dofile("sys/lua/lapi/object.lua")
    dofile("sys/lua/lapi/image.lua")
    dofile("sys/lua/lapi/hook.lua")
    dofile("sys/lua/lapi/timer.lua")
    dofile("sys/lua/lapi/map.lua")
    dofile("sys/lua/lapi/game.lua")
    lapi = {
        version = "0.1"
    }
end
