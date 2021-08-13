-- Functions
function map_key(...) vim.api.nvim_set_keymap(...) end
function buf_set_option(...) vim.api.nvim_set_option(...) end
function set_var(...) vim.api.nvim_set_var(...) end
function map_key(...) vim.api.nvim_set_keymap(...) end

function buf_map_key(bufnr, ...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
