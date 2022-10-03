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
au FileType * lua require'config/lsp'
]]
