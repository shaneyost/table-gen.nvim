#!/usr/bin/env luajit
local struct = require("struct")
local data = require("data")

local Model, vals = struct.create_new_struct(data)
local m = Model(vals)
print(m)
