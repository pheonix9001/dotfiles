require'global'

-- Enable completion triggered by <c-x><c-o>
vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

--------------------
-- Setup lsp servers
--------------------
local on_attach = function(client, bufnr)
	-----------------
	-- Diagnostics
	-----------------
	local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

	for type, icon in pairs(signs) do
		local hl = "LspDiagnosticsSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-----------------
	-- Key Mappings
	-----------------
	local opts = { noremap=true, silent=true, unique=true }

	-- Workspaces
	buf_map_key(bufnr, 'n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_map_key(bufnr, 'n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_map_key(bufnr, 'n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_map_key(bufnr, 'n', '<Leader>s', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

	-- definitions and referances
	buf_map_key(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_map_key(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_map_key(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_map_key(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

	-- Signature help
	buf_map_key(bufnr, 'i', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_map_key(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

	-- Diagnostics
	buf_map_key(bufnr, 'n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_map_key(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_map_key(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

	-- Misc
	buf_map_key(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_map_key(bufnr, 'n', "gq", '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	buf_map_key(bufnr, 'n', "<Leader>a", '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

	-------------
	-- Plugins
	-------------
	require'lsp_signature'.on_attach{
		floating_window = false,
		hint_enable = true,
		hint_prefix = '>',
		hint_scheme = 'String',
		bind = true,
		handler_opts = {
			border = 'none'
		},
		padding = '',
		trigger_on_newline = true
	}
end

local servers = {}
local start_server = function(_cmd, _root_dir, id)
	if servers[id] == nil then
		local client_id = vim.lsp.start_client{
			cmd = _cmd,
			root_dir = _root_dir,
			on_attach = on_attach
		}
		servers[id] = client_id
	end

	vim.lsp.buf_attach_client(0, servers[id])
end

local lsp = {
	-- C/C++ lsp
	ccpp = {
		setup = function()
			start_server({'clangd', '--background-index'}, '.', 'ccpp')
		end
	},
	ts = {
		setup = function()
			start_server({'typescript-language-server', '--stdio'}, '.', 'ts')
		end
	}
}

return lsp
