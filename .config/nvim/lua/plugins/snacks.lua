return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        formatters = {
          -- solve the issue where path is truncated in the file list, making some files indistinguishable
          file = {
            filename_first = true,
            truncate = 60,
          },
        },
      },
    },
  },
}
