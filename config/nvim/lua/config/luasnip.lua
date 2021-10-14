require'luasnip-global'
require'global'

ls.config.set_config {
	store_selection_keys = '<Leader><Leader>',
	silent = true,
	enable_autosnippets = true,
	history = false
}

ls.snippets = {
}

require'luasnip.loaders.from_vscode'.lazy_load()

opts = { noremap = false, expr = true }
map_key('i', '<C-k>', 'luasnip#expand_or_jumpable() ?  "\\<Plug>luasnip-expand-or-jump" : "\\<C-k>"', opts)
map_key('s', '<C-k>', 'luasnip#expand_or_jumpable() ?  "\\<Plug>luasnip-expand-or-jump" : "\\<C-k>"', opts)
