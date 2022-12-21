---------------------
-- Options
---------------------
-- search stuff
vim.opt.hlsearch = false

-- syntax stuff
vim.cmd[[
filetype indent plugin on
syntax enable
]]

-- Text
vim.opt.list = true
vim.opt.listchars = {
	tab = '..'
}

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.lazyredraw = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Swapfiles and undo
vim.opt.swapfile = false
vim.opt.undofile = true

-- Code folding
vim.opt.foldmethod = 'indent'
vim.opt.foldnestmax = 3
vim.opt.foldenable = false

-- Misc
vim.opt.splitright = true
vim.g.mapleader = ' '
-- vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'n' -- enables mouse in normal mode only
vim.opt.hidden = true
vim.opt.shell = 'bash'
