local CStructs = {}

--- Sets/Configures c-structs.nvim
---@param user_cfg table|nil Module config table.
---
---@usage >lua
---
---   require('c-structs').setup() -- use default config
---   -- OR
---   require('c-structs').setup({}) -- replace {} with your config table
--- <
function CStructs.setup(user_cfg)
    vim.notify("CStructs initialized", vim.log.levels.INFO)
end

return CStructs
