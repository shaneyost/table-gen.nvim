local TableGen = {}

function TableGen._is_valid_cfgkey(tbl, key)
    assert(type(tbl) == "table", "Error: bad type for tbl")
    assert(type(key) == "string", "Error: bad type for key")
    for k in key:gmatch("[^.]+") do
        tbl = tbl[k]
        if tbl == nil then
            error("Error, key '" .. k .. "' does not exist.")
        end
    end
    return tbl
end

return TableGen
