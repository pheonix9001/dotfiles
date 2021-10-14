-- Function aliases
local function set_var(...) vim.api.nvim_set_var(...) end

---------------------
-- Options
---------------------
-- search stuff
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- syntax stuff
vim.cmd[[
filetype indent plugin on
syntax enable
]]

-- Text
vim.opt.linebreak = true
vim.opt.wrap = false
vim.opt.hls = true
vim.opt.list = true
vim.opt.listchars = {
	tab = '..'
}

-- UI
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.showcmd = true
vim.opt.lazyredraw = true
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.laststatus = 2

-- Indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = false

-- Swapfiles and undo
vim.opt.swapfile = false
vim.opt.dir = vim.env.HOME..'/.cache/nvim/swapfiles'
vim.opt.undofile = true
vim.opt.undodir = vim.env.HOME..'/.cache/nvim/undos'

-- Code folding
vim.opt.foldmethod = 'indent'
vim.opt.foldnestmax = 3

-- Misc
vim.opt.splitright = true
vim.g.mapleader = ' '
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'n' -- enables mouse in normal mode only
vim.opt.makeprg = 'ninja'
vim.opt.hidden = true
vim.opt.shell = 'bash'
