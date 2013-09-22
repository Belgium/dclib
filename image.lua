--[[

]]

Image = {}
Image.mt = {}
Image.data = {}

setmetatable(Image, {
    __call = function(_, path, x, y, mode, pl)
        if str then
            return player(id, str)
        elseif Player.data[id] then
            return Player.data[id]
        else
            local p = setmetatable({id = id}, Player.mt)
            Player.data[id] = p
            return p
        end
    end
})
