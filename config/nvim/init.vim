" syntax stuff
filetype indent plugin on
syntax enable

"search stuff
set incsearch
set nohls

"text rendering
set encoding=utf-8
set linebreak
set nowrap
set nonu
set nornu

"UI rendering
set noruler
set showcmd
set lazyredraw
set confirm
set cursorline
set laststatus=0

"indent options
set shiftwidth=2
set tabstop=2
set smarttab
set noexpandtab

"swapfile and undo stuff
set swapfile
set dir=$HOME/.cache/nvim/swapfiles
set undodir=$HOME/.cache/nvim/undos/
set undofile

"code folding options
set foldmethod=indent
set foldnestmax=3

"spliting windows and tabs
set splitright

"misc
let g:mapleader=" "
set nocp
set clipboard=unnamedplus
set shell=zsh
set noerrorbells
set mouse=nv "enable mouse in normal mode only
set makeprg=ninja
set backspace=2

call plug#begin()
"nord theme
Plug 'arcticicestudio/nord-vim'

"lsp stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

"snippets

call plug#end()

" autocomplete
set shortmess+=c
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" fix c autocomplete
au BufEnter *.c lua require('lspconfig').clangd.setup{ on_attach = on_attach }

set completeopt=menuone,noinsert,noselect
let g:completion_sorting = "length"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1

"lua
luafile ~/.config/nvim/lua/lsp.lua

"color stuff
set termguicolors
let g:nord_cursor_line_number_background = 1
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
colorscheme nord

"netrw config
let g:netrw_liststyle=3
let g:netrw_banner=0

"window maps
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

"window moving maps
nnoremap <Leader>H <C-w>H
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>L <C-w>L

"general maps
nnoremap <F6> :so %<CR>
nnoremap <Leader><C-e> :15Lexplore<CR>
nnoremap <Leader>n :nohls<CR>
nnoremap <Leader><Leader> /<++><CR>ca<
nnoremap <Leader>f :SK<CR>
inoremap <C-space> <Esc>/<++><CR>ca<

"filetype based commands
au BufNewFile,BufRead *.md set wrap
