File = {}

function File.read(path)
    local f = io.open(path, 'r')
    
    if not f then return false end
    
    local content = ''
    for line in io.lines(path) do
        content = content .. line .. '\n'
    end
    
    f:close()
    return loadstring('return ' .. content)()
end

function File.write(path, data)
    local f = io.open(path, 'wb')
    if not f then return false end
    
    f:write(File.serialize(data))
    f:close()
    return true
end

function File.serialize(val, name, depth)
    depth = depth or 0
    local tmp = string.rep(' ', depth*4)
    
    if name then
        tmp = tmp .. name .. ' = '
    end
    
    if type(val) == 'table' then
        tmp = tmp .. '{\n' -- table begin

        for k, v in pairs(val) do
            if type(k) == 'number' then
                tmp = tmp .. File.serialize(v, nil, depth+1) .. ',\n'
            else
                tmp = tmp .. File.serialize(v, k, depth + 1) .. ',\n'
            end
        end

        tmp = tmp .. string.rep(' ', depth*4) .. '}' -- table end
    elseif type(val) == 'number' then
        tmp = tmp .. tostring(val)
    elseif type(val) == 'string' then
        tmp = tmp .. string.format('%q', val)
    elseif type(val) == 'boolean' then
        tmp = tmp .. (val and 'true' or 'false')
    else
        tmp = tmp .. '\"[unknown data type:' .. type(val) .. ']\"'
    end

    return tmp
end
