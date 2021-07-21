-- Function aliases
local function set_opt(...) vim.api.nvim_set_option(...) end
local function get_opt(...) return vim.api.nvim_get_option(...) end

local function set_var(...) vim.api.nvim_set_var(...) end
local function map_key(...) vim.api.nvim_set_keymap(...) end
-----------------
-- Set commands
-------------------
require'set-commands'

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
