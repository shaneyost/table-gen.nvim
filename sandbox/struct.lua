#!/usr/bin/env luajit
local ffi = require("ffi")
local TableGen = {}

function TableGen.new(cdef, type)
    ffi.cdef(cdef)
    return ffi.metatype(ffi.typeof(type), {
        __index = {
            size = function (self)
                return ffi.sizeof(self)
            end
        },
        __tostring = function (self)
            local out = {}
            for i=0, self:size()-1 do
                local fmt = string.format("%02X", self.raw[1])
                table.insert(out, fmt)
            end
            return table.concat(out, " ")
        end
    })
end
-- local function create_struct_body(config)
--     assert(type(config) == "table", "Error: bad type for config")
--     local body = {}
--     local size = 0
--     local sdef = config[1].sdef
--     for _, member in ipairs(config) do
--         table.insert(body, string.format(
--             "        %s %s;", member.type, member.name
--         ))
--         size = size + ffi.sizeof(member.type)
--         assert(member.sdef == sdef, "Error: unmatched name")
--     end
--     return body, size, sdef
-- end
--
-- local function create_cdef_string(body, size, sdef)
--     assert(type(body) == "table", "Error: bad type for body")
--     assert(type(size) == "number", "Error: bad type for size")
--     assert(type(sdef) == "string", "Error: bad type for sdef")
--     return string.format([[
-- typedef union
-- {
--     struct
--     {
-- %s
--     };
--     uint8_t raw[%d];
-- } __attribute__((__packed__)) %s;
-- ]], table.concat(body, "\n"), size, sdef)
-- end
--
-- function TableGen.create_new_struct(config)
--     local body, size, sdef = create_struct_body(config)
--     local cdef = create_cdef_string(body, size, sdef)
--     print(cdef)
--     print("sdef: ", sdef)
--     ffi.cdef(cdef)
--     return ffi.metatype(ffi.typeof(sdef), {
--         __index = {
--             to_bytes = function(self)
--                 return ffi.string(self.raw, self:size())
--             end,
--             size = function(self)
--                 return ffi.sizeof(self)
--             end
--         },
--         __tostring = function(self)
--             local out = {}
--             for i=0, self:size()-1 do
--                 local fmt = string.format("%02x", self.raw[1])
--                 table.insert(out, fmt)
--                 -- if 0 == ((i + 1) % 8) then
--                 --     table.insert(out, "\n")
--                 -- else
--                 --     table.insert(out, " ")
--                 -- end
--             end
--             return table.concat(out, " ")
--         end
--     })
-- end

return TableGen
