-- Function aliases
local function map_key(...) vim.api.nvim_set_keymap(...) end

local opts = { noremap = true }

-- Window maps
map_key('n', '<Leader>h', '<C-w>h', opts)
map_key('n', '<Leader>j', '<C-w>j', opts)
map_key('n', '<Leader>k', '<C-w>k', opts)
map_key('n', '<Leader>l', '<C-w>l', opts)

-- Window maps
map_key('n', '<Leader>H', '<C-w>H', opts)
map_key('n', '<Leader>J', '<C-w>J', opts)
map_key('n', '<Leader>K', '<C-w>K', opts)
map_key('n', '<Leader>L', '<C-w>L', opts)

-- Misc
map_key('n', '<F6>', ':so %<CR>', opts)
map_key('n', '<Leader>n', ':nohls<CR>', opts)
map_key('n', '<C-p>', ':SK<CR>', opts)
map_key('n', '<C-n>', ':NERDTreeToggle<CR>', opts)
