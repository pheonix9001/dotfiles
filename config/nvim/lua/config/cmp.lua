local cmp = require'cmp'

cmp.setup {
	snippet = {
		expand = function()
			require'luasnip'.expand()
		end
	},
	mapping = {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({select = true})
	},
	sources = {
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = ({
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "ﰠ",
				Variable = "",
				Class = "ﴯ",
				Interface = "",
				Module = "",
				Property = "ﰠ",
				Unit = "塞",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "פּ",
				Event = "",
				Operator = "",
			})[vim_item.kind]

			vim_item.menu = ({})[entry.source.name]
			return vim_item
		end
	}
}
