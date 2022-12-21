local opts = { noremap = true, silent = true, unique = true }

-- Telescope
map_key('n', '<Leader>C', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
map_key('n', '<Leader>ci', '<cmd>Telescope lsp_incoming_calls<CR>', opts)
map_key('n', '<Leader>co', '<cmd>Telescope lsp_outgoing_calls<CR>', opts)
map_key('n', '<Leader>s', '<cmd>Telescope lsp_document_symbols<CR>', opts)

map_key('n', '<Leader>f', '<Cmd>Telescope find_files<CR>', opts)
