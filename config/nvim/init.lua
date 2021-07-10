-- Function aliases
local function set_opt(...) vim.api.nvim_set_option(...) end
local function get_opt(...) return vim.api.nvim_get_option(...) end

local function set_var(...) vim.api.nvim_set_var(...) end

---------------------
-- Options
---------------------

-- search stuff
set_opt('incsearch', true)
set_opt('hls', false)

-- syntax stuff
vim.cmd([[
filetype indent plugin on
syntax enable
]])

-- Text
set_opt('encoding', 'utf-8')
set_opt('linebreak', true)
set_opt('wrap', false)

-- UI
set_opt('nu', false)
set_opt('rnu', false)
set_opt('ruler', true)
set_opt('showcmd', true)
set_opt('lazyredraw', true)
set_opt('confirm', true)
set_opt('cursorline', true)
set_opt('laststatus', 0)

-- Indentation
vim.cmd('set shiftwidth=2')
vim.cmd('set tabstop=2')
set_opt('expandtab', false)

-- Swapfiles and undo
set_opt('swapfile', true)
set_opt('dir', vim.env.HOME..'/.cache/nvim/swapfiles')
set_opt('undofile', true)
set_opt('undodir', vim.env.HOME..'/.cache/nvim/undos')

vim.cmd([[
"code folding options
set foldmethod=indent
set foldnestmax=3
]])

-- Code folding
set_opt('foldmethod', 'indent')
set_opt('foldnestmax', 3)

-- Misc
set_opt('splitright', true)
set_var('mapleader', ' ')
set_opt('cp', false)
set_opt('clipboard', 'unnamedplus')
set_opt('shell', 'zsh')
set_opt('backspace', '2')
set_opt('mouse', 'n') -- enables mouse in normal mode only
set_opt('makeprg', 'ninja')

----------------------
-- Plugins
----------------------
vim.cmd([[
call plug#begin()
"nord theme
Plug 'arcticicestudio/nord-vim'

"lsp stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

"snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

call plug#end()
]])

-- Completion
set_opt('shortmess', get_opt('shortmess')..'c')
vim.cmd([[
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]])
set_opt('completeopt', 'menuone,noinsert,noselect')
set_var('completion_sorting', 'length')
set_var('completion_matching_strategy_list', {'exact', 'substring', 'fuzzy'})
set_var('completion_matching_smart_case', 1)
set_var('completion_trigger_on_delete', 1)

-- Nord
set_opt('termguicolors', true)
set_var('nord_cursor_line_number_background', 1)
set_var('nord_bold', 1)
set_var('nord_italic', 1)
set_var('nord_italic_comments', 1)
vim.cmd('colorscheme nord')

-- Netrw
set_var('netrw_liststyle=3', 3)
set_var('netrw_banner', 0)

----------------------
-- Keymaps
----------------------
local function set_map(...) vim.api.nvim_set_keymap(...) end
local opts = { noremap = true }

-- Window maps
set_map('n', '<Leader>h', '<C-w>h', opts)
set_map('n', '<Leader>j', '<C-w>j', opts)
set_map('n', '<Leader>k', '<C-w>k', opts)
set_map('n', '<Leader>l', '<C-w>l', opts)

-- Window maps
set_map('n', '<Leader>H', '<C-w>H', opts)
set_map('n', '<Leader>J', '<C-w>J', opts)
set_map('n', '<Leader>K', '<C-w>K', opts)
set_map('n', '<Leader>L', '<C-w>L', opts)

-- Misc
set_map('n', '<F6>', ':so %<CR>', opts)
set_map('n', '<Leader>n', ':nohls<CR>', opts)
set_map('n', '<C-p>', ':SK<CR>', opts)
set_map('n', '<Leader><Leader>', '/<++><CR>ca<', opts)
set_map('i', '<C-space>', '<Esc>/<++><CR>ca<', opts)

----------------------
-- Auto commands
----------------------
vim.cmd([[
au BufNewFile,BufRead *.md set wrap
]])
