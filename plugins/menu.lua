Menu = {}
Menu.mt = {}
Menu.next_page = "Next page"

setmetatable(Menu, {
    __call = function(_, ply, title, func)
        local m = setmetatable({
            ply = ply,
            title = title,
            flag = "",
            buttons = {},
            func = func
        }, Menu.mt)
        ply.Menu = m
        return m
    end
})

function Menu.hook_menu(ply, title, button)
    if not ply.Menu then return end
    
    local page = title:len() - ply.Menu.title:len() - ply.Menu.page_str:len()
    local button_id = "error"
    
    if button == 0 then
        button_id = "cancel"
    elseif #ply.Menu.buttons <= 9 then
        button_id = ply.Menu.buttons[button][1]
    elseif button == 9 then
        button_id = "next"
    else
        button_id = ply.Menu.buttons[(page - 1) * 8 + button][1]
    end
    
    if button_id ~= "next" then
        ply.Menu.func(ply, button_id)
    else
        if page == math.ceil(#ply.Menu.buttons / 8) then -- last page
            ply.Menu:show(1)
        else
            ply.Menu:show(page + 1)
        end
    end
end
Hook('menu', Menu.hook_menu)

function Menu.mt:__index(key)
    local m = rawget(Menu.mt, key)
    if m then return m end
end

function Menu.mt:big()
    self.flag = "@b"
    return self
end

function Menu.mt:invisible()
    self.flag = "@i"
    return self
end

function Menu.mt:add_button(id, text)
    table.insert(self.buttons, {id, text})
    return self
end

function Menu.mt:set_buttons(table)
    self.buttons = {unpack(table)}  -- copy table
    return self
end

function Menu.mt:show(page)
    if not page then page = 1 end
    
    local last_page = 1
    local buttons = {}
    local start = (page - 1) * 8 + 1
    local stop = start + 7
    
    for i = start, stop do
        if self.buttons[i] then
            table.insert(buttons, self.buttons[i][2])
        else
            table.insert(buttons, "")
        end
    end
    
    if #self.buttons > 9 then
        last_page = math.ceil(#self.buttons / 8)
        table.insert(buttons, Menu.next_page)
    end
    
    local page_str = " " .. page .. "/" .. last_page
    local menu_str = self.title .. page_str .. string.rep(" ",page) .. self.flag
    for k,v in pairs(buttons) do
        menu_str = menu_str .. ',' .. v
    end
    
    self.page_str = page_str
    menu(self.ply.id, menu_str)
end
