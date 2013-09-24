Hat = {}
Hat.data = {}

setmetatable(Hat, {
    __call = function(_, name, path, scalex, scaley)
        local scalex = scalex or 1
        local scaley = scaley or 1
        local m = {path = path, scalex = scalex, scaley = scaley}
        Hat.data[name] = m
        return m
    end
})

function Player.mt:set_hat(name, fade)    
    local hat_data = Hat.data[name]
    local fade = fade or 1000
    
    self:remove_hat()
    
    self.Hat_name = name
    self.Hat = Image(hat_data.path, 1, 0, (self.id+200))
    self.Hat:scale(hat_data.scalex, hat_data.scaley)
    self.Hat:alpha(0)
    self.Hat:t_alpha(fade, 1)
end

function Player.mt:remove_hat()
    if self.Hat then
        self.Hat:remove()
        self.Hat = nil
        self.Hat_name = nil
    end
end

function Player.mt:redraw_hat()
    if self.Hat_name then
        self:set_hat(self.Hat_name, 0)
    end
end
