#!/usr/bin/env luajit
local ffi = require("ffi")
local cfg = require("struct_config")

local function create_struct_body(config_file)
    local body = {}
    local size = 0
    local sdef = config_file[1].sdef
    for _, member in ipairs(config_file) do
        table.insert(body, string.format(
            "        %s %s;", member.type, member.name
        ))
        size = size + ffi.sizeof(member.type)
        assert(member.sdef == sdef, "Error: unmatched name")
    end
    return body, size, sdef
end

local function create_cdef_string(body, size, sdef)
    assert(type(body) == "table", "Error: invalid type to body")
    assert(type(size) == "number", "Error: invalid type to size")
    assert(type(sdef) == "string", "Error: invalid type to sdef")
    return string.format([[
typedef union
{
    struct
    {
%s
    };
    uint8_t raw[%d];
} __attribute__((__packed__)) %s;
]], table.concat(body, "\n"), size, sdef)
end

local body, size, sdef = create_struct_body(cfg)
print(create_cdef_string(body, size, sdef))
