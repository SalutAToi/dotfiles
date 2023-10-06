lvim.lsp.installer.setup.ensure_installed = { "terraform-ls", "tflint" }

local opts = {}
require("lvim.lsp.manager").setup("terraform-ls", opts)
require("lvim.lsp.manager").setup("tflint", opts)

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "tflint", filetypes = { "terraform" } } }
