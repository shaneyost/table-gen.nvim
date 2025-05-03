local NvimSkel = {}

--- The default configuration table
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
NvimSkel._cfg = {}
--minidoc_afterlines_end

local function _mrg(cfg)
    NvimSkel._cfg = vim.tbl_deep_extend("force", NvimSkel._cfg, cfg or {})
    return NvimSkel._cfg
end

function NvimSkel._setup(user_config)
    _mrg(user_config)
end

return NvimSkel
