-- Function aliases
local function set_opt(...) vim.api.nvim_set_option(...) end
local function get_opt(...) return vim.api.nvim_get_option(...) end

local function set_var(...) vim.api.nvim_set_var(...) end
local function map_key(...) vim.api.nvim_set_keymap(...) end

-- Set command
require'set-commands'

----------------------
-- Plugins
----------------------
packman = require'packman'

-- snippets
packman.get'Shougo/neosnippet.vim'

-- lsp
packman.get'neovim/nvim-lspconfig'
packman.get'nvim-lua/completion-nvim'

-- tree sitter
packman.get'nvim-treesitter/nvim-treesitter'
packman.get'nvim-treesitter/playground'

-- theme
packman.get'arcticicestudio/nord-vim'

opts = { noremap = false, expr = true }

-- Neosnippet
set_var('neosnippet#snippets_directory', vim.env.XDG_CONFIG_HOME.."/nvim/snippets")
set_var('neosnippet#enable_snipmate_compatibility', 1)
map_key('i', '<C-k>', "neosnippet#expandable_or_jumpable() ?  '<Plug>(neosnippet_expand_or_jump)' : '<C-k>'", opts)
map_key('s', '<C-k>', "neosnippet#expandable_or_jumpable() ?  '<Plug>(neosnippet_expand_or_jump)' : '<C-k>'", opts)

-- Completion
set_opt('shortmess', get_opt('shortmess')..'c')
map_key('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', opts)
map_key('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', opts)

set_opt('completeopt', 'menuone,noinsert,noselect')
set_var('completion_sorting', 'length')
set_var('completion_matching_strategy_list', {'exact', 'substring', 'fuzzy'})
set_var('completion_matching_smart_case', 1)
set_var('completion_trigger_on_delete', 1)
set_var('completion_enable_snippet', 'Neosnippet')

-- Tree sitter

-- Nord
set_opt('termguicolors', true)
set_var('nord_cursor_line_number_background', 1)
set_var('nord_bold', 1)
set_var('nord_italic', 1)
set_var('nord_italic_comments', 1)
vim.cmd'colorscheme nord'

-- Netrw
set_var('netrw_liststyle', 3)
set_var('netrw_banner', 0)

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
