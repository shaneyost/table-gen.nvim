#!/usr/bin/env luajit
local ffi = require("ffi")
local TableGen = {}

local _template = [[
typedef union
{
    struct
    {
%s
    };
    uint8_t raw[%d];
} __attribute__((__packed__)) %s;
]]

--- Creates a formatted string that reflects a union of the passed in C struct
--- and dynamicallyl adds a raw byte array to facilitate easier i/o operations
---@param data table Describes all parts of a C structure including init vals
---@return string string table
local function create_struct_body(data)
    assert(type(data) == "table", "Error: bad type for data")
    local body = {}
    local vals = {}
    local size = 0
    local sdef = data[1].sdef
    local indent = "        "
    for _, member in ipairs(data) do
        table.insert(body, string.format(
            indent .. "%s %s;",
            member.type,
            member.name
        ))
        -- size always reflects __packed__ (no padding)
        size = size + ffi.sizeof(member.type)
        assert(member.sdef == sdef, "Error: unmatched name")
        table.insert(vals, member.init)
    end
    return string.format(
        _template,
        table.concat(body, "\n"), size, sdef
    ), sdef, vals
end

function TableGen.create_new_struct(data)
    local body, sdef, vals = create_struct_body(data)
    ffi.cdef(body)
    return ffi.metatype(ffi.typeof(sdef), {
        __index = {
            to_bytes = function(self)
                return ffi.string(self.raw, self:size())
            end,

            size = function(self)
                return ffi.sizeof(self)
            end,
        },
        __tostring = function(self)
            local out = {}
            local size = self:size()
            -- indexing C array must start at 0
            for i = 0, size - 1 do
                local fmt = string.format("%02x", self.raw[i])
                table.insert(out, fmt)
                -- define 8 columns for hexdump
                if 0 == ((i + 1) % 8) then
                    table.insert(out, "\n")
                else
                    table.insert(out, " ")
                end
            end
            return table.concat(out)
        end,
    }), vals
end

return TableGen
