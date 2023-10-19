require("telescope").setup({})

-- appearence options
lvim.builtin.telescope.defaults.layout_config = {
    -- prompt_position = "top",
    height = 0.9,
    width = 0.9,
    bottom_pane = {
        height = 25,
        preview_cutoff = 120,
    },
    center = {
        height = 0.4,
        preview_cutoff = 40,
        width = 0.5,
    },
    cursor = {
        preview_cutoff = 40,
    },
    horizontal = {
        preview_cutoff = 120,
        preview_width = 0.6,
    },
    vertical = {
        preview_cutoff = 40,
    },
    flex = {
        flip_columns = 150,
    },
}
lvim.builtin.telescope.pickers.find_files.previewer = nil
lvim.builtin.telescope.pickers.git_files.previewer = nil
lvim.builtin.telescope.defaults.layout_strategy = "flex"

-- excluding files form search
lvim.builtin.telescope.defaults.file_ignore_patterns = {
    'venv',
    '__pycache__',
    'luac',
    'undo',
    '.git'
}
