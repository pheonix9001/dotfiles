"lsp
lua << EOF
require'global'

require'config/lsp'.ccpp.setup()
EOF

set formatprg="clang-format -style file"

"debugger
nnoremap <F7> <Cmd>Step<CR>
nnoremap <F8> <Cmd>Over<CR>
nnoremap <F5> <Cmd>Run<CR>
nnoremap <F4> <Cmd>Continue<CR>
nnoremap <F3> <Cmd>Break<CR>

command Debug :Termdebug<CR>
