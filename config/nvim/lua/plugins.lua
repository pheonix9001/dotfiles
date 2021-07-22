local function set_opt(...) vim.api.nvim_set_option(...) end
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
	use'nvim-lua/completion-nvim'

	set_opt('shortmess', get_opt('shortmess')..'c')
	map_key('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', opts)
	map_key('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', opts)

	set_opt('completeopt', 'menuone,noinsert,noselect')
	vim.g.completion_sorting = 'length'
	vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
	vim.g.completion_matching_smart_case = 1
	vim.g.completion_trigger_on_delete = 1
	vim.g.completion_enable_snippet = 'Neosnippet'

	-- Neosnippet
	use'Shougo/neosnippet.vim'

	set_var('neosnippet#snippets_directory', vim.env.XDG_CONFIG_HOME.."/nvim/snippets")
	set_var('neosnippet#enable_snipmate_compatibility', 1)
	map_key('i', '<C-k>', "neosnippet#expandable_or_jumpable() ?  '<Plug>(neosnippet_expand_or_jump)' : '<C-k>'", opts)
	map_key('s', '<C-k>', "neosnippet#expandable_or_jumpable() ?  '<Plug>(neosnippet_expand_or_jump)' : '<C-k>'", opts)

	-- NERDTree
	use'preservim/nerdtree'

	---------------------------
	-- Looks
	----------------------------
	-- Nord
	use'shaunsingh/nord.nvim'

	set_opt('termguicolors', true)
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
