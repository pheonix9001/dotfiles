require'global'

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
local opts = { noremap = true }
map_key('n', '<F6>', '<Cmd>so %<CR>', opts)
map_key('n', '<Leader>n', '<Cmd>nohls<CR>', opts)
map_key('n', '<C-p>', "<Cmd>call fzf#run(fzf#wrap({'source': 'fd -t f'}))<CR>", opts)
map_key('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>', opts)

-- luasnip
opts = { noremap = false, expr = true }

local function check_back_space()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

_G.si_tab = function()
	if vim.fn.pumvisible() == 1
	then
		return term'<C-n>'
	elseif check_back_space()
	then
		return term'<Tab>'
	else
		return require'cmp'.complete()
	end
end

_G.si_s_tab = function()
	if vim.fn.pumvisible() == 1
	then
		return term'<C-p>'
	else
		return term'<S-Tab>'
	end
end

map_key('s', '<C-k>', '<Plug>luasnip-expand-or-jump', {noremap = true})

-- Tab
map_key('i', '<Tab>', 'v:lua.si_tab()', opts)
map_key('s', '<Tab>', 'v:lua.si_tab()', opts)
map_key('i', '<S-Tab>', 'v:lua.si_s_tab()', opts)
map_key('s', '<S-Tab>', 'v:lua.si_s_tab()', opts)
