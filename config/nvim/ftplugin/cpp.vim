"this also sets up lsp
source $XDG_CONFIG_HOME/nvim/ftplugin/c.vim

"lsp
lua << EOF
require'global'
EOF

imap <C-s> std::

set makeprg=samu
let vsnip_filetypes.cpp = ['c', 'ccpp']
