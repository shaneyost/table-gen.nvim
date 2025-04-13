#!/usr/bin/env luajit
local ffi = require("ffi")
local utl = require("utils")
local cfg = require("input")

local function create_struct(config_file)
    local body = {}
    local size = 0
    for _, member in ipairs(config_file) do
        table.insert(body, string.format(
            "        %s %s;", member.type, member.name
        ))
        size = size + ffi.sizeof(member.type)
    end
    return string.format([[
typedef union
{
    struct
    {
%s
    };
    uint8_t raw[%d];
} __attribute__((__packed__)) %s;
]], table.concat(body, "\n"), size, 'Model_u')
end

local cdef = create_struct(cfg)
print(cdef)
