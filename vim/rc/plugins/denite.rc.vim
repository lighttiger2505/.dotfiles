" Prefix key
nnoremap [denite] <Nop>
nmap <C-j> [denite]

" Keymap

" Current direcotry files
nnoremap <silent> [denite]<C-p> :<C-u>Denite file_rec<CR>
" Buffer files
nnoremap <silent> [denite]<C-b> :<C-u>Denite buffer<CR>
" Grep files
nnoremap <silent> [denite]<C-g> :<C-u>Denite -auto_preview grep<CR>
" Grep cursor word
nnoremap <silent> [denite]<C-]> :<C-u>DeniteCursorWord grep<CR>
" Recent files
nnoremap <silent> [denite]<C-r> :<C-u>Denite file_mru<CR>
" Outline
nnoremap <silent> [denite]<C-o> :<C-u>Denite outline<CR>
" Command history
nnoremap <silent> [denite]<C-n> :<C-u>Denite command_history<CR>
" Seach dotfiles
nnoremap <silent> [denite]<C-v> :<C-u>call denite#start([{'name': 'file_rec', 'args': ['~/.dotfiles']}])<CR>

" Insert mode keymap in dein
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-j>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-k>', '<denite:assign_previous_text>')

call denite#custom#source(
\ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

" Matcher use cpsm
" if has('python3')
"     call denite#custom#source(
"     \ 'file_rec', 'matchers', ['matcher_cpsm'])
" endif

" pt command on grep source
if executable('pt')
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
            \ ['--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
else
    echo "Please install [pt]"
endif

