" Prefix key
nnoremap [unite] <Nop>
nmap <C-j> [unite]

" Keymap

" Options
let g:unite_enable_start_insert=1
let g:unite_winheight = 20
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
let g:unite_split_rule = 'topleft'

" Prefix key
nnoremap [unite] <Nop>
nmap <Space>u [unite]

" Keymap

" Current direcotry files
nnoremap <silent> [unite]<C-p> :<C-u>Unite<Space>file_rec/async:!<CR>
" Buffer files
nnoremap <silent> [unite]<C-b> :<C-u>Unite buffer<CR>
" Grep files
nnoremap <silent> [unite]<C-g> :<C-u>Unite<Space>grep -buffer-name=search -auto-preview -no-quit -no-empty -resume<CR>
" Recent files
nnoremap <silent> [unite]<C-r> :<C-u>Unite file_mru buffer<CR>
" Yank history
nnoremap <silent> [unite]<C-y> :<C-u>Unite history/yank<CR>

