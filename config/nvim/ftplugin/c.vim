"lsp
lua << EOF
require'lsp'.ccpp.setup()


EOF

"set autoformat
set formatprg="clang-format -style=file"
