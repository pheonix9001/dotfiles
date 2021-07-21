treesitter = require'nvim-treesitter.configs'

treesitter.setup{
	higlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	},
	incremental_selection = {
		enable = true
	},
	indent = {
		enable = true
	}
}
