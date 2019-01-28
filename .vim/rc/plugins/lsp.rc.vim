if (executable('pyls'))
    let s:pyls_path = fnamemodify(g:python_host_prog, ':h') . '/'. 'pyls'
    augroup LspPython
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->[expand(s:pyls_path)]},
        \ 'whitelist': ['python']
        \ })
    augroup END
endif

if (executable('bingo'))
    augroup LspGo
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-lang',
        \ 'cmd': {server_info->['bingo', '-disable-func-snippet', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    augroup END
endif

augroup GoLspCommands
    autocmd!
    " TODO 
    " start golsp when enter python file
    autocmd BufWinEnter *.go :call lsp#enable()
    " local key mapping
    autocmd FileType go nnoremap <C-]> :<C-u>LspDefinition<CR>
    autocmd FileType go nnoremap K :<C-u>LspHover<CR>
    autocmd FileType go nnoremap <LocalLeader>R :<C-u>LspRename<CR>
    autocmd FileType go nnoremap <LocalLeader>n :<C-u>LspReferences<CR>
augroup END

augroup PylsCommands
    autocmd!
    " TODO 
    " start pyls when enter python file
    autocmd BufWinEnter *.py :call lsp#enable()
    " local key mapping
    autocmd FileType python nnoremap <C-]> :<C-u>LspDefinition<CR>
    autocmd FileType python nnoremap K :<C-u>LspHover<CR>
    autocmd FileType python nnoremap <LocalLeader>R :<C-u>LspRename<CR>
    autocmd FileType python nnoremap <LocalLeader>n :<C-u>LspReferences<CR>
augroup END

" vim-lsp debuging
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
