#!/usr/bin/env luajit
local struct = require("struct")
local data = require("data")

local Model, vals = struct.create_new_struct(data)
local m = Model(vals)

local file = assert(io.open("table.bin", "wb"))
file:write(m:to_bytes())
file:close()
print(m)
