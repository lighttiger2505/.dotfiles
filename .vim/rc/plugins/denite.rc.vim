" Insert mode keymap in dein
call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-f>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-b>', '<denite:assign_previous_text>')
call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
call denite#custom#map('insert', '<C-o>', '<denite:do_action:tabopen>')

call denite#custom#source(
    \ 'file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', 'vendor/', 'node_modules/'])

" Matcher use cpsm
" if has('python3')
"     call denite#custom#source(
"     \ 'file_rec', 'matchers', ['matcher_cpsm'])
" endif

" pt and ag command on grep source
if executable('pt')
    call denite#custom#var('file_rec', 'command',
        \ ['pt', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
    call denite#custom#var('grep', 'command',
        \ ['pt', '--nogroup', '--nocolor', '--smart-case', '--hidden'])
    call denite#custom#var('grep', 'default_opts', [])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'separator', ['--'])
elseif executable('ag')
    call denite#custom#var('file_rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
    call denite#custom#var('grep', 'command',
        \ ['ag', '--nogroup', '--nocolor', '--smart-case', '--hidden'])
    call denite#custom#var('grep', 'default_opts', [])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'separator', ['--'])
endif

" outline source variable
" call denite#custom#var('outline', 'ignore_types', ['v'])
