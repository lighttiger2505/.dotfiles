" Prefix key
nnoremap [denite] <Nop>
nmap <Space>d [denite]

" Keymap

" Current direcotry files
nnoremap <silent> <Space>p
            \ :<C-u>Denite file_rec<CR>
" Grep files
nnoremap <silent> [denite]g
            \ :<C-u>Denite -auto_preview grep<CR>
" Grep cursor word
nnoremap <silent> [denite]*
            \ :<C-u>DeniteCursorWord grep<CR>
" Recent files
nnoremap <silent> [denite]h
            \ :<C-u>Denite file_mru<CR>
" Yank History
nnoremap <silent> [denite]y
            \ :<C-u>Denite neoyank<CR>

" Insert mode keymap in dein
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-j>', '<denite:assign_next_text>')
call denite#custom#map('insert', '<C-k>', '<denite:assign_previous_text>')

