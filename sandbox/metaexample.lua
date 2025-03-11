#!/usr/bin/env luajit
local ffi = require("ffi")

ffi.cdef[[
typedef struct {
    double x;
    double y;
} point_t;
]]

-- we have to declare the variable holding the point constructor first since it is used inside of
-- the metamethod
local point
local mt = {
    __add = function(a, b) return point(a.x+b.x, a.y+b.y) end,
    __len = function(a) return math.sqrt(a.x*a.x + a.y*a.y) end,
    -- when we want to define named methods (e.g. we run out of operators) we can use __index to 
    -- do this. Not sure what __newindex doe, need to learn more. Writing this note for now.
    __index = {
        area = function(a) return a.x*a.x + a.y*a.y end,
    },
}

point = ffi.metatype("point_t", mt)
local a = point(3, 4)
print(string.format("a.x: %f, a.y: %f", a.x, a.y))
print(#a)
print(a:area())
