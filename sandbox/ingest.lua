#!/usr/bin/env luajit
local ffi = require("ffi")
-- local struct = require("struct")
-- local config = require("struct_config")
local function new(cdef, type)
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
                local fmt = string.format("%02X", self.raw[i])
                table.insert(out, fmt)
            end
            return table.concat(out, " ")
        end
    })
end

local cdef = [[
typedef union
{
	struct
	{
		uint32_t x;
		uint32_t y;
		uint8_t  c;
	};
	uint8_t raw[2];
} __attribute__((__packed__)) Model_u;
]]

local Model = new(cdef, 'Model_u')
local m = Model({x=1})
print(m)
-- local Model = struct.create_new_struct(config)
-- local m = Model({x=1})
-- print(m)
