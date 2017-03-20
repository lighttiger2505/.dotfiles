
" Settings

" keymap
nnoremap [denite] <Nop>
nmap <Space>d [denite]

nnoremap <silent> [denite]b
            \ :<C-u>DeniteBufferDir -buffer-name=files file<CR>
nnoremap <silent> [denite]u
            \ :<C-u>Denite file_rec buffer<CR>
nnoremap <silent> [denite]*
            \ :<C-u>DeniteCursorWord<CR>
nnoremap <silent> [denite]p
            \ :<C-u>DeniteProjectDir<CR>


