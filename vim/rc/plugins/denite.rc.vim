" Insert mode keymap in dein
call denite#custom#map('insert', '<C-N>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-P>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-J>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-K>', '<denite:assign_previous_text>')
call denite#custom#map('insert', '<C-S>', '<denite:do_action:split>')
call denite#custom#map('insert', '<C-I>', '<denite:do_action:vsplit>')
call denite#custom#map('insert', '<C-O>', '<denite:do_action:tabopen>')

call denite#custom#source(
\ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

" Matcher use cpsm
" if has('python3')
"     call denite#custom#source(
"     \ 'file_rec', 'matchers', ['matcher_cpsm'])
" endif

" pt and ag command on grep source
if executable('pt')
    call denite#custom#var('grep', 'command', ['pt'])
elseif executable('ga')
    call denite#custom#var('grep', 'command', ['ga'])
else
    echo "Please install [ga] or [pt] "
endif

call denite#custom#var('grep', 'default_opts',
        \ ['--nogroup', '--nocolor', '--smart-case'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

