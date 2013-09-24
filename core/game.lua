local game = game
local parse = parse

Game = {}

setmetatable(Game, {
    __index = function(_, key)
        return game(key)
    end,
    __newindex = function(_, key, value)
        parse(key .. " " .. value)
    end
})
