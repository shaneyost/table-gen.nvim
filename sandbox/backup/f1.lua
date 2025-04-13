#!/usr/bin/env luajit
local struct = require("struct")
local ffi = require("ffi")

local def = [[
typedef struct {
    uint32_t x;
    uint32_t y;
} Foo_t;
]]

-- LuaJIT's FFI metatype constructors implicitly call ffi.new for allocation,
-- thus allowing initialization in multiple convenient ways:
--   1. Positional initialization (e.g., Foo(1, 2))
--   2. Table-based positional initialization (e.g., Foo({1, 2}))
--   3. Named-field initialization (e.g., Foo({x=1, y=2}))
--   4. Partial named-field initialization (e.g., Foo({x=1}), where unspecified fields default to
--      zero)

-- Advantages of ffi.metatype over using setmetatable on Lua-wrapped cdata:
--   - Performance: ffi.metatype definitions are optimized directly by LuaJIT’s JIT compiler,
--     providing significantly faster access.
--   - Automatic implicit allocation via ffi.new (no manual calls needed).
--   - Cleaner and more idiomatic integration with C data types.

-- Create the constructor
local mystruct_t = struct.new(def, 'Foo_t')
-- Create the instance
local mystruct = mystruct_t({x=1})
assert(1 == mystruct.x)
assert(0 == mystruct.y)

-- Modify y
mystruct.y = 2
assert(1 == mystruct.x)
assert(2 == mystruct.y)

-- Test our built in meta method work
print(mystruct)

-- Test some queries of sorts w/ ffi directly
print(ffi.sizeof(mystruct))
assert(ffi.istype(mystruct, ffi.typeof('Foo_t')))
print(ffi.offsetof('Foo_t', 'y'))

if ffi.abi('le') then
    print("Little-endian detected")
elseif ffi.abi('be') then
    print("Big-endian detected")
end

local another_def = [[
typedef struct {
    uint32_t x;
    uint32_t y[3];
} Bar_t;
]]

local Bar_t = struct.new(another_def, 'Bar_t')
local bar = Bar_t({})
print(bar)
print(struct.nelem_in_array(bar.y, 'uint32_t'))

-- For my notes
local myvariable = ffi.new("int8_t", 42)
print(ffi.istype("int8_t", myvariable))
