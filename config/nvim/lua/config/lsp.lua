require'global'

-- Enable completion triggered by <c-x><c-o>
vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

--------------------
-- Setup lsp servers
--------------------
local lspconfig = require'lspconfig'

local on_attach = function(client, bufnr)
	----------------------
	-- icons
	----------------------
	local M = {}

	M.icons = {
		Class = " ",
		Color = " ",
		Constant = " ",
		Constructor = " ",
		Enum = "了 ",
		EnumMember = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = " ",
		Interface = "ﰮ ",
		Keyword = " ",
		Method = "ƒ ",
		Module = " ",
		Property = " ",
		Snippet = "﬌ ",
		Struct = " ",
		Text = " ",
		Unit = " ",
		Value = " ",
		Variable = " ",
	}

	local kinds = vim.lsp.protocol.CompletionItemKind
	for i, kind in ipairs(kinds) do
		kinds[i] = M.icons[kind]
	end

	-----------------
	-- Key Mappings
	-----------------
	local opts = { noremap=true, silent=true }

	-- Workspaces
	buf_map_key(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_map_key(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_map_key(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_map_key(bufnr, 'n', '<space>s', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

	-- definitions and referances
	buf_map_key(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_map_key(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_map_key(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_map_key(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

	-- Signature help
	buf_map_key(bufnr, 'i', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_map_key(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

	-- Diagnostics
	buf_map_key(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_map_key(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_map_key(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

	-- Misc
	buf_map_key(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_map_key(bufnr, 'n', "gq", '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	buf_map_key(bufnr, 'n', "<Leader>a", '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lsp = {
	-- C/C++ lsp
	ccpp = {
		setup = function()
			lspconfig.clangd.setup{
				on_attach = on_attach,
				capabilities = capabilities,
				-- could be useful in the future
				cmd = {
					'clangd',
					'--background-index'
				}
			}
		end
	}
}

return lsp
