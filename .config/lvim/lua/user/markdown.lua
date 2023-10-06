-- ensure treesitter python syntax is installed
lvim.builtin.treesitter.ensure_installed = {
    "markdown",
}
lvim.lsp.installer.setup.ensure_installed = { "marksman", "markdownlint" }

local opts = {}
require("lvim.lsp.manager").setup("marksman", opts)
require("lvim.lsp.manager").setup("markdownlint", opts)
-- -- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "markdownlint" }, }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.md" }
-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "markdownlint", filetypes = { "markdown" } } }

-- user command (alias) to make switching to the filetype easier
vim.api.nvim_create_user_command("Md", "set filetype=markdown")
