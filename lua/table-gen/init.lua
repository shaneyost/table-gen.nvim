local TableGen = {}
local struct = require("table-gen.struct")
local config = require("table-gen.config")

--- Sets/Configures table-gen.nvim
---@param user_cfg table|nil Module config table.
---
---@usage >lua
---
---   require('table-gen').setup() -- use default config
---   -- OR
---   require('table-gen').setup({}) -- replace {} with your config table
--- <
function TableGen.setup(user_cfg)
    config._setup(user_cfg)
    vim.notify("TableGen initialized", vim.log.levels.INFO)
end

return TableGen
