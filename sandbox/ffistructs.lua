#!/usr/bin/env luajit
local ffi = require("ffi")

local function NELEM(array, type)
    return ffi.sizeof(array) / ffi.sizeof(type)
end

local function ARRAY(strfmt, array, type)
    for i = 0, NELEM(array, type) do
        io.write(string.format(strfmt, array[i]), " ")
    end
    io.write("\n")
end

ffi.cdef[[
typedef struct
{
    double x;
    double y;
    double z[4];
} MyStruct_t;
]]

local mystruct = ffi.new("MyStruct_t", {})
print(mystruct.x)
print(mystruct.y)
ARRAY("%f", mystruct.z, "double")
print(string.format("mystruct is %d-bytes in size", ffi.sizeof(mystruct)))
print(string.format("mystruct.z is an array of %d items", NELEM(mystruct.z, "double")))

-- Struct types have an id assigned to them so must write it out the long way
print(ffi.istype(mystruct, ffi.typeof("MyStruct_t")))
-- It doesn't appear that LuaJIT doesn't provide a way to inspect field types dynamically.

-- For a standalone variable type I could do this
local myvariable = ffi.new("int", 42)
print(ffi.istype("int", myvariable))
-- Need to learn how we can create a metatable now for our struct, do that tomorrow
