require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            'venv',
            '__pycache__',
            'luac',
            'undo',
            '.git'
        }
    }
})
