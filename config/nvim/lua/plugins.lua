local function map_key(...) vim.api.nvim_set_keymap(...) end

opts = { noremap = false, expr = true }

return require'packer'.startup(function() 
	use'wbthomason/packer.nvim'

	-- Functionality
	use'L3MON4D3/LuaSnip'
	use {
		'mattn/emmet-vim',
		ft = {'css', 'html'},
	}
	vim.g.user_emmet_leader_key='<C-k>'
	use {
		'kyazdani42/nvim-tree.lua',
		cmd = 'NvimTreeToggle'
	}

	-- Lsp
	use'hrsh7th/nvim-compe'
	use'ray-x/lsp_signature.nvim'

	-- Tree sitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ":TSUpdate"
	}
	use {
		'nvim-treesitter/playground',
		cmd = "TSPlaygroundToggle"
	}

	-- Looks
	use'mhinz/vim-startify'
	use'arcticicestudio/nord-vim'
	--use'shaunsingh/nord.nvim'
	use {
		'hoob3rt/lualine.nvim',
		requires = {'ryanoasis/vim-devicons'}
	}

	-------------------
	-- Functionality
	-------------------
	require'config/compe'
	require'config/luasnip'
	require'config/fzf'
	require'config/tree-sitter'

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

	-- Lualine
	require'config/lualine'

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
