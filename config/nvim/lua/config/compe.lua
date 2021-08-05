----------------------
-- My nvim-compe config
----------------------
require'global'

vim.opt.shortmess:append('c')
vim.opt.completeopt = 'menuone,noselect'
require'compe'.setup{
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	resolve_timeout = 800;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 60;
	documentation = {
		winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
		max_width = 60,
		min_width = 10,
		max_height = math.floor(vim.o.lines * 0.3),
		min_height = 1
	},

	source = {
		path = true;
		buffer = true;
		calc = true;
		nvim_lsp = true;
		nvim_lua = true;
		vsnip = true;
		ultisnips = false;
		luasnip = false;
		emoji = true;
	};
}
require'lspkind'.init{
	with_text = false,
	preset = 'codicons',

	symbol_map = {
		Text = '',
		Method = 'ƒ',
		Function = '',
		Constructor = '',
		Variable = '',
		Class = '',
		Interface = 'ﰮ',
		Module = '',
		Property = '',
		Unit = '',
		Value = '',
		Enum = '了',
		Keyword = '',
		Snippet = '﬌',
		Color = '',
		File = '',
		Folder = '',
		EnumMember = '',
		Constant = '',
		Struct = ''
	}
}

opts = { noremap = false, silent = true, expr = true }
map_key('i', '<C-space>', "compe#complete()", opts)
map_key('i', '<CR>', "compe#confirm('<CR>')", opts)
map_key('i', '<C-e>', "compe#close('<C-e>')", opts)
map_key('i', '<C-f>', "compe#scroll({ 'delta': +4 })", opts)
map_key('i', '<C-b>', "compe#scroll({ 'delta': -4 })", opts)

-- Conveniance
map_key('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', opts)
map_key('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', opts)
