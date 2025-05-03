if not package.loaded["mini.doc"] then
    require("mini.doc").setup()
end
require("mini.doc").generate({
    "lua/nvim-skel/init.lua",
    "lua/nvim-skel/config.lua",
})
