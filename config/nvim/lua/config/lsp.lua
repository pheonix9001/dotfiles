require'global'

-- Enable completion triggered by <c-x><c-o>
vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

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
	buf_map_key(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_map_key(bufnr, 'n', "gq", '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	buf_map_key(bufnr, 'n', "<Leader>a", '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

local servers = {}
local start_server = function(_client_obj, id)
	local client_obj = _client_obj
	client_obj['on_attach'] = client_obj['on_attach'] or on_attach
	client_obj['root_dir'] = vim.fn.getcwd()

	servers[id] = servers[id] or vim.lsp.start_client(client_obj)

	vim.lsp.buf_attach_client(0, servers[id])
end

--------------------
-- Lsp servers
--------------------
local lsp = {
	default = {
		setup = function()
		end
	},

	-- C/C++ lsp
	c = {
		setup = function()
			start_server({
				cmd = {'ccls'},

				init_options = {
					compilationDatabaseDirectory = 'build',
					diagnostic = {
						onChange = 0
					}
				}
			}, 'ccpp')
		end
	},

	javascript = {
		setup = function()
			start_server({
				cmd = {'typescript-language-server', '--stdio'}
			}, 'javascript')
		end
	},

	zig = {
		setup = function()
			start_server({
				cmd = {'zls'},
				root_dir = vim.fn.getcwd()
			}, '.', 'zig')
		end
	}
}
lsp.cpp = lsp.c;
lsp.typescript = lsp.javascript;

if(lsp[vim.o.ft])
then
	lsp[vim.o.ft].setup();
end
return lsp
