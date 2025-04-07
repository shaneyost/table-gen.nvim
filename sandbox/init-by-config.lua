#!/usr/bin/env luajit
local config = require("input")
for _, t in ipairs(config) do
    print("name: ", t.name)
    print("type: ", t.type)
    print("init: ", t.init)
end
