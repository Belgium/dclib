Image = {}
Image.mt = {}

setmetatable(Image, {
    __call = function(_, ...)
        return setmetatable({id = image(unpack(arg))}, Image.mt)
    end
})

local transform = {
    remove = 'freeimage',
    alpha = 'imagealpha',
    blend = 'imageblend',
    color = 'imagecolor',
    hitzone = 'imagehitzone',
    pos = 'imagepos',
    scale = 'imagescale',
    t_alpha = 'tween_alpha',
    t_color = 'tween_color',
    t_move = 'tween_move',
    t_rotate = 'tween_rotate',
    t_rotateconstantly = 'tween_rotateconstantly',
    t_scale = 'tween_scale'
}

for k,v in pairs(transform) do  -- generate methods from transform table
    Image.mt[k] = function(self, ...)
        _G[v](self.id, unpack(arg))
    end
end

function Image.mt:__index(key)
    local m = rawget(Image.mt, key)
    if m then
        return m
    else
        error("Unknown method " .. key)
    end
end
