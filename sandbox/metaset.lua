#!/usr/bin/env luajit
local Set = require("set")

local s1 = Set.new({10, 20, 30, 50})
local s2 = Set.new({30, 1})

print(getmetatable(s1))
print(getmetatable(s2))

local s3 = s1 + s2
print(s3)
print(s1*s2)
