local function map_key(...) vim.api.nvim_set_keymap(...) end

opts = { noremap = false, expr = true }

return require'packer'.startup(function() 
	--######################
	-- Use definitions
	--######################
	use'wbthomason/packer.nvim'

	-- Functionality
	use {
		'L3MON4D3/LuaSnip',
		ft = {'cpp', 'c'},
		config = [[require'config/luasnip']]
	}

	use {
		'mattn/emmet-vim',
		ft = {'html'}
	}

	-- Vim plugins
	use {
		'tpope/vim-commentary',
		config = function()
			vim.cmd[[au FileType cpp setlocal commentstring =//\ %s]]
		end
	}
	--[[
	use {
		'takac/vim-hardtime',
		config = function()
			vim.g.hardtime_default_on = 1
			vim.g.hardtime_maxcount = 4
		end
	}
	]]--
	use'wellle/targets.vim'

	use {
		'kyazdani42/nvim-tree.lua',
		cmd = 'NvimTreeToggle'
	}

	-- Cmp
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'saadparwaiz1/cmp_luasnip'
		},
		config = [[require'config/cmp']]
	}

	-- lsp

	-- vim wiki
	use {
		'vimwiki/vimwiki',
		config = function()
			vim.cmd[[let g:vimwiki_list = [{'path': '~/Documents/vimwiki/'}] ]]
		end
	}

	-- nvim dap
	use {
		'mfussenegger/nvim-dap',
		config = [[require'config/dap']],
		ft = {'c', 'cpp'},
		requires = {
			'rcarriga/nvim-dap-ui'
		}
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

	-- Looks
	use {
		'arcticicestudio/nord-vim',
		config = function()
			-- Nord
			vim.opt.termguicolors = true
			vim.g.nord_uniform_diff_background = true
			vim.g.nord_bold = true
			vim.g.nord_italic_comments = true

			vim.cmd[[colorscheme nord]]
		end
	}
	use {
		'hoob3rt/lualine.nvim',
		requires = {'ryanoasis/vim-devicons'},
		config = [[require'config/lualine']]
	}

	require'config/fzf'
end)
