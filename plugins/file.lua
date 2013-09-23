File = {}

setmetatable(File, {
    __call = function(_, path)
        return setmetatable({path = path}, File)
    end
})

function File:__index(key)
    return rawget(File, key)
end

function File:read()
    local file = io.open(self.path, 'r')
    if file then
        local content = ''
        for line in io.lines(self.path) do
            content = content .. line .. '\n'
        end
        file:close()
        return loadstring('return ' .. content)()
    end
end

function File:write(data)
    local str = serialize(data)
    local file = io.open(self.path, 'wb')
    if file then
        file:write(str)
        file:close()
        return true
    else
        return false
    end
end


-- thanks to Henrik Ilgen
-- at http://stackoverflow.com/questions/6075262/lua-table-tostringtablename-and-table-fromstringstringtable-functions
function serialize(val, name, depth)
    depth = depth or 0
    local tmp = string.rep(' ', depth)
    
    if name then
        tmp = tmp .. name .. ' = '
    end
    
    if type(val) == 'table' then
        tmp = tmp .. '{\n' -- table begin

        for k, v in pairs(val) do
            if type(k) == 'number' then
                tmp = tmp .. serialize(v, nil, depth+1) .. ',\n'
            else
                tmp = tmp .. serialize(v, k, depth + 1) .. ',\n'
            end
        end

        tmp = tmp .. string.rep(' ', depth) .. '}' -- table end
    elseif type(val) == 'number' then
        tmp = tmp .. tostring(val)
    elseif type(val) == 'string' then
        tmp = tmp .. string.format('%q', val)
    elseif type(val) == 'boolean' then
        tmp = tmp .. (val and 'true' or 'false')
    else
        tmp = tmp .. '\"[inserializeable datatype:' .. type(val) .. ']\"'
    end

    return tmp
end
