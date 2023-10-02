set smartcase " only ignore case when searching lowercase
set incsearch " search as you type
set hlsearch " highlight search
set number
set ruler " curser position
set mouse=a " mouse usage
set expandtab " tab is space
" indent length (space)
set softtabstop=4
set shiftwidth=4
set cursorline " highlight current line
set showmode
set ttyfast " faster display
set wrap " line wrapping (line fits in one line)
syntax on
" status bar
set laststatus=2
set showtabline=2

call plug#begin("$XDG_DATA_HOME/nvim/plugins")
    Plug 'preservim/nerdcommenter'
    " file tree explorer
    Plug 'preservim/nerdtree'
    Plug 'lukas-reineke/indent-blankline.nvim'
    " theme
    Plug 'rakr/vim-one'
    Plug 'vim-airline/vim-airline'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'
    " use relativenumber AND number for current line
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'easymotion/vim-easymotion'
    " language server client and completion framework
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " syntax tree
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " git wrapper
    Plug 'tpope/vim-fugitive'
    " insert, delete brackets/parents/quotes in pairs
    Plug 'jiangmiao/auto-pairs'
call plug#end()

" Syntax parser (Treesitter) configuration
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" appearence options
" true color support (alacritty, other terms, ..)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme one
" configuration for plugins
"" theme plugin
let g:airline_theme='one'
"" fzf window placement
let g:fzf_layout = { 'down': '~40%' }

"" leader key
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

" general remaps
"" keep previous word in registry when pasting, visual mode
xnoremap <leader>p "_dP

" shortcuts
"" fzf shortcut
nnoremap <silent> <C-f> :Files<CR>
" remap tab for coc-vim instead of tab, uses completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
nnoremap <C-n> :NERDTreeToggle<CR>
