-----------------
-- Set commands
-----------------
require'set-opts'

----------------------
-- Plugins
----------------------
require'plugins'

------------
-- Keymaps
------------
require'set-mappings'

----------------------
-- Auto commands
----------------------
vim.cmd[[
au BufNewFile,BufRead *.md set wrap
au BufRead,BufNewFile *.c lua require'lsp'.ccpp.setup()
]]
