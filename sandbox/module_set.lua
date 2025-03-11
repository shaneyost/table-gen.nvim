#!/usr/bin/env luajit

local Set = {}

function Set.new(l)
    set = {}
    for _, v in ipairs(l) do
        -- print(string.format("set[%d] = true", v))
        set[v] = true
    end
    print("\n")
    return set
end

function Set.union(s1, s2)
    local set = Set.new({})
    for k in pairs(s1) do
        -- print(string.format("set[%d] = true", k))
        set[k] = true
    end
    for k in pairs(s2) do
        -- print(string.format("set[%d] = true", k))
        set[k] = true
    end
    return set
end

function Set.intersection(s1, s2)
    local set = Set.new({})
    for k in pairs(s1) do
        -- print(string.format("k: %d, s2[k]: %s", k, tostring(s2[k])))
        set[k] = s2[k]
    end
    return set
end

function Set.tostring(s)
    local l = {}
    for k in pairs(s) do
        -- The book says this but table.insert is more readable
        -- l[#l+1] = tostring(k)
        table.insert(l, tostring(k))
    end
    return "{" .. table.concat(l, ", ") .. "}"
end

-- Tomorrow we can learn how to implement metamethods for this module
-- usage
-- local myset1 = Set.new({1, 2, 2, 5, 6})
-- local myset2 = Set.new({1, 3, 6, 7, 7})
-- local myset3 = Set.union(myset1, myset2)
-- local common = Set.intersection(myset1, myset2)
-- print(Set.tostring(myset2))
return Set
