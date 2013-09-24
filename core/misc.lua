function Color(r, g, b)
    return string.char(169) .. string.format("%03d%03d%03d", r, g, b)
end
