if not package.loaded["mini.doc"] then
    require("mini.doc").setup()
end
require("mini.doc").generate({
    "lua/table-gen/init.lua",
    "lua/table-gen/struct.lua",
    "lua/table-gen/config.lua"
})
