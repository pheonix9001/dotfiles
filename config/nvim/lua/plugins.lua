local function map_key(...) vim.api.nvim_set_keymap(...) end

opts = { noremap = false, expr = true }

return require'packer'.startup(function() 
	use'wbthomason/packer.nvim'

	-- Functionality
	use'hrsh7th/nvim-compe'
	use'hrsh7th/vim-vsnip'

	-- Misc
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {{'ryanoasis/vim-devicons'}}
	}

	-- Looks
	use'mhinz/vim-startify'
	use'arcticicestudio/nord-vim'
	use'hoob3rt/lualine.nvim'

	-------------------
	-- Functionality
	-------------------
	-- Nvim-compe
	require'config/compe'

	-- Vsnip
	opts = { noremap = false, expr = true }
	vim.g.vsnip_snippet_dir = vim.env.XDG_CONFIG_HOME.."/nvim/snippets"
	map_key('i', '<C-k>', 'vsnip#available() ?  "\\<Plug>(vsnip-expand-or-jump)" : "\\<C-k>"', opts)
	map_key('s', '<C-k>', 'vsnip#available() ?  "\\<Plug>(vsnip-expand-or-jump)" : "\\<C-k>"', opts)

	-- Fzf
	require'config/fzf'

	---------------------------
	-- Looks
	----------------------------
	-- Nord
	vim.opt.termguicolors = true
	vim.g.nord_uniform_diff_background = true
	vim.g.nord_bold = true
	vim.g.nord_italic = true
	vim.g.nord_italic_comments = true
	vim.cmd'colorscheme nord'

	-- Lualine
	require'lualine'.setup{
		options = {
			icons_enabled = true,
			theme = 'nord',
			component_separators = {'', ''},
			section_separators = {'', ''},
			disabled_filetypes = {'NvimTree', 'packer'}
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch'},
			lualine_c = {'filename'},
			lualine_x = {'encoding', 'fileformat', {'filetype', colored=true}},
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

	-- Startify
	require'config/startify'
end)
