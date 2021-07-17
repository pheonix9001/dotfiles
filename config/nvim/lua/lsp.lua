-- Functions
local function map_key(...) vim.api.nvim_set_keymap(...) end
local function buf_set_option(...) vim.api.nvim_set_option(...) end
local function set_var(...) vim.api.nvim_set_var(...) end
local function map_key(...) vim.api.nvim_set_keymap(...) end

-- Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-----------------
-- Key Mappings
-----------------
local opts = { noremap=true, silent=true }

-- Workspaces
map_key('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
map_key('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
map_key('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)

-- definitions and referances
map_key('n', '<C-]>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map_key('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map_key('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
map_key('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

-- Signature help
map_key('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map_key('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

-- Diagnostics
map_key('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
map_key('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map_key('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

-- Misc
map_key('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map_key('n', "gq", '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

--------------------
-- Setup lsp servers
--------------------
local lspconfig = require'lspconfig'

local on_attach = function(client, bufnr)
	require'completion'.on_attach()
end

local lsp = {

	-- C/C++ lsp
	ccpp = {
		setup = function()
			lspconfig.clangd.setup{
				on_attach = require'completion'.on_attach()
			}
		end
	}
}

return lsp
