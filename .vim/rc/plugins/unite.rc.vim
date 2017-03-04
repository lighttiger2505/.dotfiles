
" Settings
let g:unite_enable_start_insert=1
let g:unite_winheight = 20
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
let g:unite_split_rule = 'topleft'

" keymap
nnoremap [unite] <Nop>
nmap <Space>u [unite]

nnoremap <silent> [unite]b
            \ :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f
            \ :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]r
            \ :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]u
            \ :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> [unite]y
            \ :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]g
            \ :<C-u>Unite<Space>grep -buffer-name=search -auto-preview -no-quit -no-empty -resume<CR>
nnoremap <silent> [unite]m
            \ :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]p
            \ :<C-u>Unite<Space>file_rec/async:!<CR>

