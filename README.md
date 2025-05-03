<div align="center">
<h1>Table Generator for C</h1>
<p align="center">
<a href="https://github.com/shaneyost/nvim-skel.nvim/actions/workflows/ci.yaml">
<img src="https://github.com/shaneyost/nvim-skel.nvim/actions/workflows/ci.yaml/badge.svg" alt="CI Status">
</a>
<a href="https://github.com/shaneyost/nvim-skel.nvim/blob/main/LICENSE">
<img src="https://img.shields.io/github/license/shaneyost/nvim-skel.nvim" alt="License">
</a>
<a href="https://github.com/shaneyost/nvim-skel.nvim/issues">
<img src="https://img.shields.io/github/issues/shaneyost/nvim-skel.nvim" alt="GitHub Issues">
</a>
</p>
</div>

## About
Coming soon, in development ...

## Configuration

```lua
return {
    "shaneyost/nvim-skel.nvim",
    -- dir = "~/repos/nvim-skel.nvim",
    -- dev = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local tablegen = require("nvim-skel")
        tablegen.setup({
        })
    end,
}
```
