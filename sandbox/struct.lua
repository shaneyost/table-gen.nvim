#!/usr/bin/env luajit
local ffi = require("ffi")
local TableGen = {}

local function st_create_cdef_body(config)
end

function TableGen.st_create_new_instance(config)
    assert(type(config) == "table", "Error: invalid type for config")
    -- ffi.cdef(st_create_cdef_body(config)
    -- return ffi.metatype(ffi.typeof())
end

return TableGen
