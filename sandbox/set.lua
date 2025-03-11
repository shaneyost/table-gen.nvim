#!/usr/bin/env luajit

local Set = {}
local mt = {}
function mt.__add(s1, s2)
    if getmetatable(s1) ~= mt or getmetatable(s2) ~= mt then
        error("Attempting to 'add' a set with a non-set value", 2)
    end
    local set = Set.new({})
    for k in pairs(s1) do
        set[k] = true
    end
    for k in pairs(s2) do
        set[k] = true
    end
    return set
end
function mt.__tostring(s)
    local l = {}
    for k in pairs(s) do
        table.insert(l, tostring(k))
    end
    return "{" .. table.concat(l, ", ") .. "}"
end
function mt.__mul(s1, s2)
    if getmetatable(s1) ~= mt or getmetatable(s2) ~= mt then
        error("Attempting to 'mul' a set with a non-set value", 2)
    end
    local set = Set.new({})
    for k in pairs(s1) do
        set[k] = s2[k]
    end
    return set
end
function Set.new(l)
    local set = {}
    setmetatable(set, mt)
    for _, v in ipairs(l) do
        set[v] = true
    end
    return set
end
return Set
