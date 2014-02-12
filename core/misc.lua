local map = map
local game = game
local parse = parse

Color = {}
setmetatable(Color, {
    __call = function(_, red, green, blue)
        return string.char(169) .. string.format("%03d%03d%03d", red, green, blue)
    end
})

Map = {}
setmetatable(Map, {
    __index = function(_, key)
        return map(key)
    end
})

Game = {}
setmetatable(Game, {
    __index = function(_, key)
        return game(key)
    end,
    __newindex = function(_, key, value)
        Parse(key, value)
    end
})

function Parse(cmd, ...)
    local str = cmd

    for k,v in pairs({...}) do
        if type(v) == 'string' then
            str = str .. ' "' .. v .. '"'
        else
            str = str .. ' ' .. v
        end
    end

    parse(str)
end

-- shortcuts
P = Parse
H = Hook
T = Timer
O = Object
I = Image
G = Game
M = Map
F = File
C = Color
