"lsp
lua << EOF
require'global'

require'config/lsp'.ccpp.setup()
EOF

set formatprg="clang-format -style file"
let vsnip_filetypes.c = ['ccpp']
