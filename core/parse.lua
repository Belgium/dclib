local parse = parse

function Parse(cmd, ...)
    local str = cmd
    
    for k,v in pairs(arg) do
    
        if k == 'n' then
            break
        end

        if type(v) == 'string' then
            str = str .. ' "' .. v .. '"'
        
        else
            str = str .. ' ' .. v
        end
    end
    
    print(str)
    parse(str)
end
