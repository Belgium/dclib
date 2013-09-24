local player = player
local parse = parse
local playerweapons = playerweapons
local reqcld = reqcld

Player = {}
Player.mt = {}
Player.data = {}
Player.indextable = {
    armor = 'setarmor',
    health = 'sethealth',
    speedmod = 'speedmod',
    score = 'setscore',
    deaths = 'setdeaths',
    maxhealth = 'setmaxhealth',
    score = 'setscore',
    money = 'setmoney',
    weapon = 'setweapon'
}

setmetatable(Player, {
    __call = function(_, arg)
        if type(arg) == "number" then
            if Player.data[arg] then
                return Player.data[arg]
            elseif arg > 0 and arg <= 32 then
                local p = setmetatable({id = arg}, Player.mt)
                Player.data[arg] = p
                return p
            else
                return 0
            end
        elseif type(arg) == "table" then
            local tbl = {}
            for k,v in pairs(arg) do
                table.insert(tbl, Player(v))
            end
            return tbl
        end
    end,
    __index = function(_, key)
        local m = rawget(Player, key)
        if m then return m end
        
        m = rawget(Player.mt, key)
        if m then return m end
        
        return Player(player(0, key))
    end
})

function Player.mt:__index(key)
    local m = rawget(Player.mt, key)
    if m then
        return m
    else
        if key == 'enemy' then
            local team = self.team
            if team == 1 then
                return 2
            elseif team == 2 then
                return 1
            else 
                return 0
            end
        elseif key == 'weapons' then
            return playerweapons(self.id)
        else
            return player(self.id, key)
        end
    end
end

function Player.mt:__newindex(key, value)
    if Player.indextable[key] ~= nil then
        parse(Player.indextable[key] .. ' ' .. self.id .. ' ' .. value)
    elseif key == 'name' then
        parse('setname ' .. self.id .. ' "' .. value .. '" 1')
    elseif key == 'team' then
        if value == 1 then
            parse('maket ' .. self.id)
        elseif value == 2 then
            parse('makect ' .. self.id)
        else
            parse('makespec ' .. self.id)
        end
    elseif key == 'x' then
        self:setpos(value, self.y)
    elseif key == 'tilex' then
        self:setpos(value * 16, self.y)
    elseif key == 'y' then
        self:setpos(self.x, value)
    elseif key == 'tiley' then
        self:setpos(self.x, value * 16)
    elseif key == 'enemy' then
        return
    elseif key == 'weapons' then
        local tbl = playerweapons(self.id)
        
        print("let's give weapons")
        for k,v in pairs(value) do
            local found = false
            for k2,v2 in pairs(tbl) do
                if v == v2 then
                    found = true
                end
            end
            if not found then
                self:equip(v)
            end
        end
        for k,v in pairs(tbl) do
            local found = false
            for k2,v2 in pairs(value) do
                print("v2 = " .. v2)
                if v == v2 then
                    found = true
                end
            end
            if not found then
                self:strip(v)
            end
        end
    else
        rawset(self, key, value)
    end
end

function Player.mt:equip(weapon)
    parse('equip ' .. self.id .. ' ' .. weapon)
end

function Player.mt:setpos(x, y)
    parse('setpos ' .. self.id .. ' ' .. x .. ' ' .. y) 
end

function Player.mt:reqcld(mode, ...)
    reqcld(self.id, mode, unpack(arg))
end

function Player.mt:kick(reason)
    parse('kick ' .. self.id .. ' ' .. reason)
end

function Player.mt:banip(duration, reason)
    parse('banip ' .. self.ip .. ' ' .. duration .. ' ' .. reason)
end

function Player.mt:banusgn(duration, reason)
    parse('banusgn ' .. self.usgn .. ' ' .. duration .. ' ' .. reason)
end

function Player.mt:spawn(x, y)
    parse('spawnplayer ' .. self.id .. ' ' .. x .. ' ' .. y)
end

function Player.mt:strip(wpn)
    parse('strip ' .. self.id .. ' ' .. wpn)
end

function Player.mt:slap()
    parse('slap ' .. self.id)
end

function Player.mt:kill()
    parse('killplayer ' .. self.id)
end

function Player.mt:customkill(killer, weapon)
    parse('customkill ' .. killer .. ' "' .. weapon .. '" ' .. self.id)
end

function Player.mt:msg(message)
    msg2(self.id, message)
end

function Player.mt:cmsg(message)
    parse('cmsg "' .. message .. '" ' .. self.id)
end

function Player.mt:reroute(address)
    parse('reroute ' .. self.id .. ' ' .. address)
end

function Player.mt:shake(power)
    parse('shake ' .. self.id .. ' ' .. power)
end

-- bots

function Player.mt:ai_aim(x, y)
    ai_aim(self.id, x, y)
end

function Player.mt:ai_attack(secondary)
    ai_attack(self.id, secondary)
end

function Player.mt:ai_build(building, x, y)
    ai_build(self.id, building, x, y)
end

function Player.mt:ai_buy(itemtype)
    ai_buy(self.id, itemtype)
end

function Player.mt:ai_debug(text)
    ai_debug(self.id, text)
end

function Player.mt:ai_drop()
    ai_drop(self.id)
end

function Player.mt:ai_findtarget()
    return Player(ai_findtarget(self.id))
end

function Player.mt:ai_freeline(x, y)
    return ai_freeline(self.id, x, y)
end

function Player.mt:ai_goto(x, y, walk)
    return ai_goto(self.id, x, y, walk)
end

function Player.mt:ai_iattack()
    ai_iattack(self.id)
end

function Player.mt:ai_move(angle, walk)
    ai_move(self.id, angle, walk)
end

function Player.mt:ai_radio(radioid)
    ai_radio(self.id, radioid)
end

function Player.mt:ai_reload()
    ai_reload(self.id)
end

function Player.mt:ai_respawn()
    ai_respawn(self.id)
end

function Player.mt:ai_rotate(angle)
    ai_rotate(self.id, angle)
end

function Player.mt:ai_say(text)
    ai_say(self.id, text)
end

function Player.mt:ai_sayteam(text)
    ai_sayteam(self.id, text)
end

function Player.mt:ai_selectweapon(itemtype)
    ai_selectweapon(self.id, itemtype)
end

function Player.mt:ai_spray()
    ai_spray(self.id)
end

function Player.mt:ai_use()
    ai_use(self.id)
end
