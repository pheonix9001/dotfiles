lua << EOF
require'luasnip-global'

local emmet = function(args)
	return t('<'..args[1][1]..'>')
end

ls.snippets.html = {
	s('!', {
		i(1),
		d(1, emmet, {1})
		})
}
EOF
