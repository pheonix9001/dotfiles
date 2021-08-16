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
]]
