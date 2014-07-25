local tile = tile

Tile = {}
Tile.mt = {}
Tile.data = {}

setmetatable(Tile, {
    __call = function(_, x, y)
        if not Tile.data[y] then
            Tile.data[y] = {}
        end

        if not Tile.data[y][x] then
            local t = setmetatable({x = x, y = y}, Tile.mt)
            Tile.data[y][x] = t
            return t
        end

        return Tile.data[y][x]
    end,
    __index = function(_, key)
        local m = rawget(Tile, key)
        if m then return m end

        return rawget(Tile.mt, key)
    end
})

function Tile.mt:__index(key)
    local m = rawget(Tile.mt, key)
    if m then
        return m
    end

    return tile(self.x, self.y, key)
end

function Tile.mt:set(frame)
    Parse("settile", self.x, self.y, frame)
end
