return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  opts = function(_, opts)
    opts.sections.lualine_c[4] = {
      LazyVim.lualine.pretty_path({
        length = 0, -- 0 parts means nothing is abbreviated, see https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/lualine.lua#L124
      }),
    }
  end,
}
