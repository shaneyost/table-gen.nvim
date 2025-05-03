local NvimSkel = {}
local config = require("nvim-skel.config")

--- Sets/Configures nvim-skel.nvim
---@param user_cfg table|nil Module config table.
---
---@usage >lua
---
---   require('nvim-skel').setup() -- use default config
---   -- OR
---   require('nvim-skel').setup({}) -- replace {} with your config table
--- <
function NvimSkel.setup(user_cfg)
    config._setup(user_cfg)
    vim.notify("NvimSkel initialized", vim.log.levels.INFO)
end

return NvimSkel
