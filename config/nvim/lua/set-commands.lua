-- Function aliases
local function set_var(...) vim.api.nvim_set_var(...) end
local function set_opt(...) vim.api.nvim_set_option(...) end

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
set_opt('linebreak', true)
set_opt('wrap', false)

-- UI
set_opt('nu', false)
set_opt('rnu', false)
set_opt('showcmd', true)
set_opt('lazyredraw', true)
set_opt('confirm', true)
set_opt('cursorline', true)
set_opt('laststatus', 2)

-- Indentation
vim.cmd'set shiftwidth=2'
vim.cmd'set tabstop=2'
set_opt('expandtab', false)

-- Swapfiles and undo
set_opt('swapfile', true)
set_opt('dir', vim.env.HOME..'/.cache/nvim/swapfiles')
vim.cmd'set undofile'
set_opt('undodir', vim.env.HOME..'/.cache/nvim/undos')

-- Code folding
vim.cmd[[
set foldmethod=indent
set foldnestmax=3
]]

-- Misc
set_opt('splitright', true)
set_var('mapleader', ' ')
set_opt('cp', false)
set_opt('clipboard', 'unnamedplus')
set_opt('shell', 'zsh')
set_opt('backspace', '2')
set_opt('mouse', 'n') -- enables mouse in normal mode only
set_opt('makeprg', 'ninja')
set_opt('hidden', false)
