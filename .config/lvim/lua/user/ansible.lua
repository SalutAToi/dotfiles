-- ensure treesitter python syntax is installed
lvim.builtin.treesitter.ensure_installed = {
    "yaml",
}
lvim.lsp.installer.setup.ensure_installed = { "ansiblels", "ansiblelint" }

local opts = {}
require("lvim.lsp.manager").setup("ansiblels", opts)
require("lvim.lsp.manager").setup("ansiblelint", opts)
-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "ansiblelint", filetypes = { "yaml.ansible" } } }

-- user command (alias) to make switching to the filetype easier
vim.api.nvim_create_user_command("Ans", "set filetype=yaml.ansible", {})
