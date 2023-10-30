-- general configuration
---- tab setting
vim.opt.shiftwidth = 4    -- the number of spaces inserted for each indentation
vim.opt.expandtab = true  -- turns tab to space
vim.opt.tabstop = 4       -- insert 4 spaces for a tab
vim.opt.shiftround = true -- indenting uses multiples of shiftwidth
---- search
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- appearence and helpers
---- font
vim.opt.guifont = "Hack Nerd Font"
---- window
lvim.transparent_window = true
vim.opt.cursorline = true
---- hybrid numbers (enabling both)
vim.opt.relativenumber = true -- relative line numbers
vim.opt.number = true         -- relative line numbers
vim.opt.wrap = true           -- wrap lines
vim.opt.showmatch = true      -- briefly jump to matching brace when inserted
vim.opt.showmode = true       -- show current vim mode in status bar
---- folding
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
---- statusline
lvim.builtin.lualine.sections.lualine_c = { { "filename", path = 1 } }

-- file settings
lvim.format_on_save = true
