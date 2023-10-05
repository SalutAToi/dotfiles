""""""""""""""""""""""""
"   CONFIGURATION      "
""""""""""""""""""""""""
" moving
set mouse=a " mouse usage
set showmatch " briefly go to matching brace when inserted
" display 
syntax on
set wrap " line wrapping (line fits in one line)
set cursorline " highlight current line
set showmode " display mode in the status bar
set cursorline " highlight cursor line
"" hybrid line number (enabling both)
set number
set relativenumber
set ruler " curser position
" input 
set smartcase " only ignore case when searching lowercase
"" indent length (space)
set softtabstop=4
set shiftwidth=4
set expandtab " tab is space
set shiftround " use mutltiples of shiftwidth when indenting
" search
set incsearch " search as you type
set hlsearch " highlight search
" performance
set ttyfast " faster display
" files
set autoread
set nobackup


""""""""""""""""""""""""
"    STATUS BAR        "
""""""""""""""""""""""""
set laststatus=2
set showtabline=2

""""""""""""""""""""""""
"    APPEARANCE        "
""""""""""""""""""""""""
colorscheme gruvbox
set rulerformat=%=%M\ %l,%c%V\ \ \ %p%%
" appearence options
" true color support (alacritty, other terms, ..)
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

""""""""""""""""""""""""
"     KEYBINDING       "
""""""""""""""""""""""""
" leader key
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"
" keep previous word in registry when pasting, visual mode
xnoremap <leader>p "_dP
" open netrw in dir of current file
nnoremap <leader>dd :Lexplore %:p:h<CR>
" open netrw in current work dir
nnoremap <Leader>da :Lexplore<CR>
" remap to move easily between panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
""""""""""""""""""""""""
"    FILE BROWSER      "
""""""""""""""""""""""""
let g:netrw_banner=0        " disable annoying banner
let g:netrw_keepdir = 0 " keep current dir and browsing dir synced
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_localcopydircmd = 'cp -r' " change copy command for recursive copies of dir
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

