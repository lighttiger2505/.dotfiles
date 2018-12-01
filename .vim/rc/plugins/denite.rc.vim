" Insert mode keymap in dein
call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-f>', '<denite:assign_next_text>', 'noremap')
call denite#custom#map('insert', '<C-b>', '<denite:assign_previous_text>', 'noremap')
call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', '<C-o>', '<denite:do_action:tabopen>', 'noremap')

" file/rec on git alias
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
" change file/old source scope
call denite#custom#source('file_old', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source('file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
