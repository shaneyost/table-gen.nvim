local TableGen = {}
local utils = require("table-gen.utils")

--- The default configuration table
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
TableGen._cfg = {
    -- format specifier for hexdump
    outfmt = "%02X"
}
--minidoc_afterlines_end

function TableGen._get(key)
    return utils._is_valid_cfgkey(TableGen._cfg, key)
end

function TableGen._mrg(cfg)
    TableGen._cfg = vim.tbl_deep_extend("force", TableGen._cfg, cfg or {})
    return TableGen._cfg
end

function TableGen._setup(user_config)
    TableGen._mrg(user_config)
end

return TableGen
