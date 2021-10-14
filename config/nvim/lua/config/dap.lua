-- Dap
local dap = require'dap'
require'global'

dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-vscode',
	name = 'lldb'
}

dap.configurations.cpp = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
		runInTerminal = false
	},
}

dap.configurations.c = dap.configurations.cpp

-- mappings
local opts = { noremap = true }

map_key('n', '<Leader>dd', ":lua require'dap'.continue()<CR>", opts)
map_key('n', '<Leader>db', ":lua require'dap'.toggle_breakpoint()<CR>", opts)
map_key('n', '<Leader>do', ":lua require'dapui'.toggle()<CR>", opts)
map_key('n', '<F3>', ":lua require'dap'.toggle_breakpoint()<CR>", opts)
map_key('n', '<F7>', ":lua require'dap'.step_over()<CR>", opts)
map_key('n', '<F8>', ":lua require'dap'.step_into()<CR>", opts)

-- dapui
require'dapui'.setup {
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
	},
	sidebar = {
		open_on_start = true,
		-- You can change the order of elements in the sidebar
		elements = {
			-- Provide as ID strings or tables with "id" and "size" keys
			{
				id = "scopes",
				size = 0.25, -- Can be float or integer > 1
			},
			{ id = "breakpoints", size = 0.25 },
			{ id = "stacks", size = 0.25 },
			{ id = "watches", size = 00.25 },
		},
		size = 40,
		position = "left", -- Can be "left", "right", "top", "bottom"
	},
	tray = {
		open_on_start = true,
		elements = { "repl" },
		size = 10,
		position = "bottom", -- Can be "left", "right", "top", "bottom"
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
}
