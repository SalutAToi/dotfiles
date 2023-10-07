lvim.lsp.installer.setup.ensure_installed = { "terraformls", "tflint" }

local opts = {}
require("lvim.lsp.manager").setup("terraformls", opts)
require("lvim.lsp.manager").setup("tflint", opts)

-- -- setup linting
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup { { command = "tflint", filetypes = { "terraform" } } }
