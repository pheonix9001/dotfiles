require'lualine'.setup{
	options = {
		icons_enabled = true,
		theme = 'nord',
		component_separators = {'', ''},
		section_separators = {'', ''},
		disabled_filetypes = {'packer'}
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
