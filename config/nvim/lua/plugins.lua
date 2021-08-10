local function map_key(...) vim.api.nvim_set_keymap(...) end

opts = { noremap = false, expr = true }

return require'packer'.startup(function() 
	use'wbthomason/packer.nvim'

	-------------------
	-- Functionality
	-------------------
	-- Nvim-compe
	use {
		'neovim/nvim-lspconfig',
		requires = {
			{
				'hrsh7th/nvim-compe',
				requires = {
					{'onsails/lspkind-nvim'}
				}
			}
		}
	}
	require'config/compe'

	-- Vsnip
	use'hrsh7th/vim-vsnip'
	opts = { noremap = false, expr = true }
	vim.g.vsnip_snippet_dir = vim.env.XDG_CONFIG_HOME.."/nvim/snippets"
	map_key('i', '<C-k>', 'vsnip#available() ?  "\\<Plug>(vsnip-expand-or-jump)" : "\\<C-k>"', opts)
	map_key('s', '<C-k>', 'vsnip#available() ?  "\\<Plug>(vsnip-expand-or-jump)" : "\\<C-k>"', opts)

	-- Misc
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {{'ryanoasis/vim-devicons'}}
	}

	---------------------------
	-- Looks
	----------------------------
	-- Nord
	use'arcticicestudio/nord-vim'

	vim.opt.termguicolors = true
	vim.g.nord_uniform_diff_background = true
	vim.g.nord_bold = true
	vim.g.nord_italic = true
	vim.g.nord_italic_comments = true
	vim.cmd'colorscheme nord'

	-- Lualine
	use'hoob3rt/lualine.nvim'
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
	use {
		'mhinz/vim-startify',
	}
	require'config/startify'

	-- Misc
	-- use'kyazdani42/nvim-web-devicons'
	use'ryanoasis/vim-devicons'
end)
