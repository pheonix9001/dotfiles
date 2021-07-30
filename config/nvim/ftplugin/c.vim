"lsp
lua << EOF
require'global'

require'lsp'.ccpp.setup()
EOF

set formatprg="clang-format -style file"
let vsnip_filetypes.c = ['ccpp']
