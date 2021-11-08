#
# Lsp
#

eval %sh{kak-lsp --kakoune -s $kak_session}
lsp-enable

# Keybindings
map global user K ":lsp-hover<ret>"
