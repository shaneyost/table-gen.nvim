#!/usr/bin/env luajit
local ffi = require("ffi")
local TableGen = {}

function TableGen.nelem_in_array(array, array_type)
    return ffi.sizeof(array) / ffi.sizeof(array_type)
end

function TableGen.new(def, type)
    ffi.cdef(def)
    return ffi.metatype(ffi.typeof(type), {
        __tostring = function(self)
            local str = "%s (%s, size=%dbytes)"
            return string.format(
                str,
                type,
                tostring(ffi.typeof(self)),
                ffi.sizeof(self)
            )
        end
    })
end
return TableGen
