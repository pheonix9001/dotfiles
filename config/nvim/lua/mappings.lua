require'global'
local luasnip = require'luasnip'
local cmp = require'cmp'

--[[
local function check_back_space()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

_G.si_tab = function()
	if check_back_space()
	then
		return term'<Tab>'
	elseif luasnip.expand_or_jumpable()
	then
		luasnip.expand_or_jump()
		return term''
	elseif cmp.visible()
	then
		return term'<C-n>'
	else
		cmp.complete()
		return term''
	end
end

-- Tab
map_key('i', '<Tab>', 'v:lua.si_tab()', opts)
map_key('s', '<Tab>', 'v:lua.si_tab()', opts)
map_key('i', '<S-Tab>', 'v:lua.si_s_tab()', opts)
map_key('s', '<S-Tab>', 'v:lua.si_s_tab()', opts)
]]--
