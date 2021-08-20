require'luasnip/loaders/from_vscode'.lazy_load({
	paths = {'~/.local/share/nvim/site/pack/packer/start/friendly-snippets'},
	exclude = {'c', 'cpp'}
})
require'luasnip/loaders/from_vscode'.lazy_load({ paths = {'~/.config/nvim/snippets'} })

opts = { noremap = false, expr = true }
map_key('i', '<C-k>', 'luasnip#expand_or_jumpable() ?  "\\<Plug>luasnip-expand-or-jump" : "\\<C-k>"', opts)
map_key('s', '<C-k>', 'luasnip#expand_or_jumpable() ?  "\\<Plug>luasnip-expand-or-jump" : "\\<C-k>"', opts)

local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.config.setup {
	store_selection_keys = '<Leader><Leader>'
}

ls.snippets = {
}
