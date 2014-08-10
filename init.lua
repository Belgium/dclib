if not dclib then
    dclib = {}
    dclib.path = debug.getinfo(1).source:sub(2, -10)
    dclib.loaded = {}
    dclib.load = function(file)
        if not dclib.loaded[file] then
            print("dclib load: " .. file)
            dclib.loaded[file] = true
            dofile(dclib.path .. '/' .. file)
        end
    end

    dclib.core = {
        'player',
        'object',
        'image',
        'hudtxt',
        'tile',
        'hook',
        'menu',
        'timer',
        'file',
        'util',
        'misc'
    }

    for k,v in pairs(dclib.core) do
        dclib.load('core/' .. v .. '.lua')
    end
end
