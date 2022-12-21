require'global'

local default_on_attach = function(client, bufnr)
	-----------------
	-- Diagnostics
	-----------------
		local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
end

local servers = {}
local start_server = function(_client_obj)
	local client_obj = _client_obj
	client_obj.on_attach = _client_obj.on_attach or default_on_attach
	client_obj.root_dir = _client_obj.root_dir or vim.fn.getcwd()
	client_obj.name = client_obj.id

	local id = client_obj.id
	servers[id] = servers[id] or vim.lsp.start_client(client_obj)

	vim.lsp.buf_attach_client(0, servers[id])
end

--------------------
-- Mappings
--------------------
local opts = { noremap = true, silent = true, unique = true }

-- definitions and referances
map_key('n', '<C-]>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map_key('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map_key('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
map_key('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

-- Signature help
map_key('i', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map_key('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

	-- Diagnostics
map_key('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
map_key('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map_key('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

-- Misc
map_key('n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
map_key('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

-- luasnip
opts = { noremap = false, expr = true }
map_key('i', '<C-k>', 'luasnip#expand_or_jumpable() ?  "\\<Plug>luasnip-expand-or-jump" : "\\<C-k>"', opts)
map_key('s', '<C-k>', 'luasnip#expand_or_jumpable() ?  "\\<Plug>luasnip-expand-or-jump" : "\\<C-k>"', opts)


--------------------
-- Lsp servers
--------------------
local lsp = {
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
		cmd = {'typescript-language-server', '--stdio'},
		id = 'js_like',
	},
	rust = {
		cmd = {'rust-analyzer'},
		id = 'rust',
	},
}
lsp.cpp = lsp.ccpp;
lsp.c = lsp.ccpp;
lsp.typescript = lsp.js_like;
lsp.javascript = lsp.js_like;
lsp.javascriptreact = lsp.js_like;
lsp.typescriptreact = lsp.js_like;

if(lsp[vim.o.ft])
then
	start_server(lsp[vim.o.ft])
end
