" Prefix key
nnoremap [denite] <Nop>
nmap <C-j> [denite]

" Keymap

" Current direcotry files
nnoremap <silent> [denite]p :<C-u>Denite file_rec<CR>
" Buffer files
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
" Grep files
nnoremap <silent> [denite]g :<C-u>Denite -auto_preview grep<CR>
" Grep cursor word
nnoremap <silent> [denite]] :<C-u>DeniteCursorWord grep<CR>
" Recent files
nnoremap <silent> [denite]r :<C-u>Denite file_mru<CR>

" Insert mode keymap in dein
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-j>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-k>', '<denite:assign_previous_text>')

call denite#custom#source(
\ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

" Matcher use cpsm
if has('python3')
    call denite#custom#source(
    \ 'file_rec', 'matchers', ['matcher_cpsm'])
endif

if executable('pt')
    call denite#custom#var('file_rec', 'command',
    \ ['pt', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
    call denite#custom#var('grep', 'command',
    \ ['pt', '--nogroup', '--nocolor', '--smart-case', '--hidden'])
endif

call denite#custom#var('grep', 'default_opts', [])
call denite#custom#var('grep', 'recursive_opts', [])
