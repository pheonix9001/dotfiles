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

	local map = function(mode, key, command) buf_map_key(bufnr, key, command, opts) end

	-- Workspaces
	map('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
	map('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
	map('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
	map('n', '<Leader>s', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

	-- definitions and referances
	map('n', '<C-]>', '<cmd>lua vim.lsp.buf.implementation()<CR>')
	map('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
	map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
	map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

	-- Signature help
	map('i', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
	map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')

	-- Diagnostics
	map('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
	map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
	map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

	-- Misc
	map('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>')
	map('n', "gq", '<cmd>lua vim.lsp.buf.formatting()<CR>')
	map('n', "<Leader>a", '<cmd>lua vim.lsp.buf.code_action()<CR>')
end

local servers = {}
local start_server = function(_client_obj)
	local client_obj = _client_obj
	client_obj.on_attach = function()
		on_attach()
		client_obj.on_attach()
	end
	client_obj.root_dir = root_dir or vim.fn.getcwd()

	local id = client_obj.id
	servers[id] = servers[id] or vim.lsp.start_client(client_obj)

	vim.lsp.buf_attach_client(0, servers[id])
end

--------------------
-- Lsp servers
--------------------
local lsp = {
	default = {
		setup = function() end
	},

	-- C/C++ lsp
	ccpp = {
				cmd = {'ccls'},

				init_options = {
					compilationDatabaseDirectory = 'build',
					diagnostic = {
						onChange = 0
					}
				},
				
				id = 'ccpp'
	},

	js_like = {
		setup = function()
			start_server({
				cmd = {'typescript-language-server', '--stdio'}
			}, 'javascript')
		end
	},
	rust = {
		cmd = {'rust-analyzer'},
		id = 'rust'
	},

	zig = {
				cmd = {'zls'},
				root_dir = vim.fn.getcwd()
	}
}
lsp.cpp = lsp.ccpp;
lsp.c = lsp.ccpp;
lsp.typescript = lsp.js_like;
lsp.javascript = lsp.js_like;

if(lsp[vim.o.ft])
then
	start_server(lsp[vim.o.ft])
end
return lsp
