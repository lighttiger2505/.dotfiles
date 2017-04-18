
autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
" autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
" autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.django

" Running vimproc
" Showing success is buffer and error is quickfix
let g:quickrun_config = {
    \ '_' : {
        \ 'runner' : 'vimproc',
        \ 'runner/vimproc/updatetime' : 40,
        \ 'runner/vimproc/read_timeout' : 5000,
        \ 'outputter' : 'error',
        \ 'outputter/error/success' : 'buffer',
        \ 'outputter/error/error'   : 'quickfix',
        \ 'outputter/buffer/split' : ':botright 8sp',
    \ }
\}
let g:quickrun_config['python.unit']   = { 'command': 'python',  'cmdopt': '-v -s'   }
let g:quickrun_config['python.pytest'] = { 'command': 'py.test', 'cmdopt': '-v'      }
let g:quickrun_config['python.django'] = { 'command': 'python',  'cmdopt': 'test --pararell --keepdb'}

" Close quickfix is [q]
au FileType qf nnoremap <silent><buffer>q :quit<CR>

" Keymap
let g:quickrun_no_default_key_mappings = 1
" Running with close quickfix and save file
nnoremap \r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap \r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>

" Stop quickrun is [C-c]
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
