local function get_opt(...) return vim.api.nvim_get_option(...) end

local function set_var(...) vim.api.nvim_set_var(...) end
local function map_key(...) vim.api.nvim_set_keymap(...) end

opts = { noremap = false, expr = true }

return require'packer'.startup(function() 
	use 'wbthomason/packer.nvim'

	-------------------
	-- Functionality
	-------------------
	-- Native lsp
	use'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'

	vim.opt.shortmess = get_opt('shortmess')..'c'
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
		max_menu_width = 100;
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
		};
	}

	opts = { noremap = false, silent = true, expr = true }
	map_key('i', '<C-space>', "compe#complete()", opts)
	map_key('i', '<CR>', "compe#confirm('<CR>')", opts)
	map_key('i', '<C-e>', "compe#close('<C-e>')", opts)
	map_key('i', '<C-f>', "compe#scroll({ 'delta': +4 })", opts)
	map_key('i', '<C-b>', "compe#scroll({ 'delta': -4 })", opts)

	-- Convineance
	map_key('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', opts)
	map_key('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', opts)

	-- Vsnip
	use'hrsh7th/vim-vsnip'
	opts = { noremap = false, expr = true }
	vim.g.vsnip_snippet_dir = vim.env.XDG_CONFIG_HOME.."/nvim/snippets"
	map_key('i', '<C-k>', 'vsnip#available() ?  "\\<Plug>(vsnip-expand-or-jump)" : "\\<C-k>"', opts)
	map_key('s', '<C-k>', 'vsnip#available() ?  "\\<Plug>(vsnip-expand-or-jump)" : "\\<C-k>"', opts)

	-- NERDTree
	use'preservim/nerdtree'

	---------------------------
	-- Looks
	----------------------------
	-- Nord
	use'shaunsingh/nord.nvim'

	vim.opt.termguicolors = true
	vim.g.nord_contrast = true
	vim.g.nord_borders = true
	require'nord'.set()

	-- Lualine
	use'hoob3rt/lualine.nvim'
	require'lualine'.setup{
		options = {
			icons_enabled = true,
			theme = 'nord',
			component_separators = {'', ''},
			section_separators = {'', ''},
			disabled_filetypes = {}
		},
		sections = {
			lualine_a = {'mode'},
			lualine_c = {'filename'},
			lualine_x = {'encoding', 'fileformat', 'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
		inactive_sections = {
			lualine_a = {'filename'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
		tabline = {},
		extensions = {}
	}

	-- Vim devicons
	use'ryanoasis/vim-devicons'
end)
