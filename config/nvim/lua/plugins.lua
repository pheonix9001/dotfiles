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
		config = "require'config/lualine'"
	}

	use {
	'tpope/vim-commentary',
	config = "vim.cmd[[au FileType cpp setlocal commentstring =//\\ %s]]"
	}
	use'takac/vim-hardtime'
	use {
		'kyazdani42/nvim-tree.lua',
		cmd = 'NvimTreeToggle'
	}

	-- cmp
	use {
		'hrsh7th/nvim-cmp',
		reqires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'saadparwaiz/cmp_lusnip'
		},
		config = "require'config/cmp'"
	}

	-- vim wiki
	use {
		'vimwiki/vimwiki',
		run = "vim.cmd[[let g:vimwiki_list = [{'path': '~/Documents/vimwiki/'}] ]]"
	}

	-- Tree sitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = "require'config/tree-sitter'"
	}
	use {
		'nvim-treesitter/playground',
		cmd = "TSPlaygroundToggle"
	}

	-- Misc
	vim.g.hardtime_default_on = 1
	vim.g.hardtime_maxcount = 4

	-- Looks
	use'mhinz/vim-startify'
	use'arcticicestudio/nord-vim'
	use {
		'hoob3rt/lualine.nvim',
		requires = {'ryanoasis/vim-devicons'}
	}

	--######################
	-- Configs
	--######################

	-------------------
	-- Functionality
	-------------------

	require'config/fzf'
	---------------------------
	-- Looks
	----------------------------
	-- Nord
	vim.opt.termguicolors = true
	vim.g.nord_uniform_diff_background = true
	vim.g.nord_bold = true
	vim.g.nord_italic_comments = true

	--vim.g.nord_italic = true
	--vim.g.nord_contrast = true
	vim.cmd[[colorscheme nord]]

	-- Startify
	vim.g.startify_custom_header = {
		'                         .__         ',
		'  ____   ____  _______  _|__| _____  ',
		' /    \\_/ __ \\/  _ \\  \\/ /  |/     \\ ',
		'|   |  \\  ___(  <_> )   /|  |  Y Y  \\',
		'|___|  /\\___  >____/ \\_/ |__|__|_|  /',
		'     \\/     \\/                    \\/ ',
	}
end)
