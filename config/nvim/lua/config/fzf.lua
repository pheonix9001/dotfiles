vim.g.fzf_action = {
	['ctrl-t'] = 'tab split',
	['ctrl-x'] = 'split',
	['ctrl-v'] = 'vsplit'
}

vim.g.fzf_colors = {
	['fg'] = {'fg', 'Normal'},
	['bg'] = {'bg', 'Normal'},
	['hl'] = {'fg', 'Comment'},
	['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
	['bg+'] = {'bg', 'CursorLine', 'CursorColumn'},
	['info'] = {'fg', 'PreProc'},
	['border'] = {'fg', 'Ignore'},
	['prompt'] = {'fg', 'Conditional'},
	['pointer'] = {'fg', 'Exception'},
	['marker'] = {'fg', 'Keyword'},
	['spinner'] = {'fg', 'Label'},
	['header'] = {'fg', 'Comment'},
}
