-----------------
-- Set commands
-----------------
require'opts'

----------------------
-- Plugins
----------------------
require'plugins'

------------
-- Keymaps
------------
require'mappings'

----------------------
-- Auto commands
----------------------
vim.cmd[[
au BufNewFile,BufRead *.md set wrap
au FileType * lua require'config/lsp'
]]
