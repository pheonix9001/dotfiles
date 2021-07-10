"lsp
luafile ~/.config/nvim/lua/lsp.lua
lua require'lspconfig'.ccls.setup{ on_attach = on_attach }

"set autoformat
set formatprg="clang-format -style=file"

"if snippets
ab if if() {<CR><++><CR>}<CR><++><Esc>kkki
ab ifelse if() {<CR><++><CR>} <++> else {<CR><++><CR>}<CR><++><Esc>kkkkki
ab elseif else if() {<CR><++><CR>} <++> <Esc>kkf(a

"common functions
ab main int main(int argc, char** argv) {<CR>return 0;<CR>}<Esc>kO
ab func (<++>) {<CR><++><CR>}<Esc>kki

"switch statements
ab switch switch() {<CR>case <++>:<CR><++><CR>break;<CR>default:<CR><++><CR>break;<CR>}<CR><++><Esc>kkkkkkkkf(a
ab case case:<CR><++><CR>break;<Esc>kki

"preprocessors
ab incq #include ""<Left>
ab inc #include <><Left>

imap <C-k> <C-]>
