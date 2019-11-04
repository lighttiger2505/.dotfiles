" Running vimproc
" Showing success is buffer and error is quickfix
let g:quickrun_config = {
    \ '_' : {
        \ 'outputter' : 'error',
        \ 'outputter/error/success' : 'buffer',
        \ 'outputter/error/error'   : 'quickfix',
        \ 'outputter/buffer/split' : ':botright 8sp',
    \ }
\}

" Set runner
if has('nvim')
  " Use 'neovim_job' in Neovim
  let g:quickrun_config._.runner = 'neovim_job'
elseif exists('*ch_close_in')
  " Use 'job' in Vim which support job feature
  let g:quickrun_config._.runner = 'job'
endif

" Close quickfix is [q]

augroup MyQuickFixClose
    au FileType qf nnoremap <silent><buffer>q :quit<CR>
augroup END

" Keymap
let g:quickrun_no_default_key_mappings = 1

" Stop quickrun is [C-c]
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
