Hook = {}
Hook.count = 0
Hook.mt = {}
Hook.support = {
    attack = true,
    attack2 = true,
    bombdefuse = true,
    bombexplode = true,
    bombplant = true,
    build = true,
    buildattempt = true,
    buy = true,
    clientdata = true,
    collect = true,
    die = true,
    dominate = true,
    drop = true,
    flagcapture = true,
    flagtake = true,
    flashlight = true,
    hit = true,
    hostagerescue = true,
    join = true,
    kill = true,
    leave = true,
    menu = true,
    move = true,
    movetile = true,
    name = true,
    radio = true,
    reload = true,
    say = true,
    sayteam = true,
    select = true,
    serveraction = true,
    spawn = true,
    spray = true,
    team = true,
    use = true,
    usebutton = true,
    vipescape = true,
    vote = true,
    walkover = true
}

function Hook.add(hook, func, prio)
    local id = 'Hook_' .. Hook.count
    
    if Hook.support[hook] then
        if hook == "kill" then
            Hook[id] = function(killer, victim, ...)
                return _G[func](Player(killer), Player(victim), unpack(arg))
            end
        else
            Hook[id] = function(id, ...) -- create a wrapper function
                return _G[func](Player(id), unpack(arg))
            end
        end
    else
        Hook[id] = _G[func]
    end
    
    if prio then
        addhook(hook, 'Hook.' .. id, prio)
    else
        addhook(hook, 'Hook.' .. id)
    end
    Hook.count = Hook.count + 1
    
    local tbl = {
        hook = hook,
        func = func,
        prio = prio,
        id = 'Hook.' .. id
    }
    return setmetatable(tbl, Hook.mt)
end

function Hook.mt:remove()
    freehook(self.hook, self.id)
end

