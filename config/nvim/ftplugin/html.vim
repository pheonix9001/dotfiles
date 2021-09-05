lua << EOF
require'luasnip-global'

ls.snippets.html = {
	s('.', {t('hello')})
}
EOF
