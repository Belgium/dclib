if not lapi then
    lapi = {}
    lapi.path = debug.getinfo(1).source:sub(2, -10)
    lapi.loaded = {}
    lapi.load = function(file)
        if not lapi.loaded[file] then
            lapi.loaded[file] = true
            print("Love API load script: " .. file)
            dofile(lapi.path .. '/' .. file)
        end
    end
    
    lapi.core = {
        'player',
        'object',
        'image',
        'hudtxt',
        'hook',
        'menu',
        'timer',
        'file',
        'util',
        'misc'
    }
    
    for k,v in pairs(lapi.core) do
        lapi.load('core/' .. v .. '.lua')
    end
end
