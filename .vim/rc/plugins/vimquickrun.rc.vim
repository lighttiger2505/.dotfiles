" Running vimproc
" Showing success is buffer and error is quickfix
let g:quickrun_config = {
    \ '_' : {
        \ 'runner' : 'vimproc',
        \ 'runner/vimproc/updatetime' : 40,
        \ 'outputter' : 'error',
        \ 'outputter/error/success' : 'buffer',
        \ 'outputter/error/error'   : 'quickfix',
        \ 'outputter/buffer/split' : ':botright 8sp',
    \ }
\}

" Close quickfix is [q]

augroup MyQuickFixClose
    au FileType qf nnoremap <silent><buffer>q :quit<CR>
augroup END

" Keymap
let g:quickrun_no_default_key_mappings = 1
" Running with close quickfix and save file
nnoremap <Leader>r :<C-U>QuickRun<CR>
xnoremap <Leader>r gv:<C-U>QuickRun<CR>

" Stop quickrun is [C-c]
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
