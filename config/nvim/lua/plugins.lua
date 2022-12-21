local function map_key(...) vim.api.nvim_set_keymap(...) end

opts = { noremap = false, expr = true }

return require'packer'.startup(function() 
	--######################
	-- Use definitions
	--######################
	use'wbthomason/packer.nvim'

	-- LuaSnip
	use {
		'L3MON4D3/LuaSnip',
		requires = {'rafamadriz/friendly-snippets'},
		config = [[require'config/luasnip']]
	}

	-- Cmp
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'saadparwaiz1/cmp_luasnip',
		},
		config = [[require'config/cmp']]
	}

	-- vim wiki
	use {
		'vimwiki/vimwiki',
		config = function()
			vim.cmd[[let g:vimwiki_list = [{'path': '~/Documents/vimwiki/'}] ]]
		end
	}

	-- Tree sitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = [[require'config/tree-sitter']]
	}
	use {
		'nvim-treesitter/playground',
		cmd = 'TSPlaygroundToggle'
	}

	-- Look
	use {
		'arcticicestudio/nord-vim',
		config = function()
			vim.opt.termguicolors = true
			vim.g.nord_uniform_diff_background = true
			vim.g.nord_bold = true
			vim.g.nord_italic_comments = true

			vim.cmd[[colorscheme nord]]
		end
	}
	use'ryanoasis/vim-devicons'
		use {
		'hoob3rt/lualine.nvim',
		requires = {'ryanoasis/vim-devicons'},
		config = [[require'config/lualine']]
	}

	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		requires = { 'nvim-lua/plenary.nvim' },
		config = [[require'config/telescope']]
	}
end)
