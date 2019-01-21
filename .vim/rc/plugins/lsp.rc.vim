" vim-lsp=================================================================
" " registar pyls to vim-lsp
" if (executable('pyls'))
"     let s:pyls_path = fnamemodify(g:python_host_prog, ':h') . '/'. 'pyls'
"     augroup LspPython
"         autocmd!
"         autocmd User lsp_setup call lsp#register_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->[expand(s:pyls_path)]},
"        \ 'whitelist': ['python']
"        \ })
"     augroup END
"
"     augroup LspGo
"         autocmd!
"         autocmd User lsp_setup call lsp#register_server({
"       \ 'name': 'go-lang',
"       \ 'cmd': {server_info->['bingo', '-disable-func-snippet', '-mode', 'stdio']},
"       \ 'whitelist': ['go'],
"       \ })
"     augroup END
" endif
"
" augroup GoLspCommands
"     autocmd!
"     " TODO 
"     " start golsp when enter python file
"     autocmd BufWinEnter *.go :call lsp#enable()
"     " local key mapping
"     autocmd FileType go nnoremap <C-]> :<C-u>LspDefinition<CR>
"     autocmd FileType go nnoremap K :<C-u>LspHover<CR>
"     autocmd FileType go nnoremap <LocalLeader>R :<C-u>LspRename<CR>
"     autocmd FileType go nnoremap <LocalLeader>n :<C-u>LspReferences<CR>
" augroup END
"
" augroup PylsCommands
"     autocmd!
"     " TODO 
"     " start pyls when enter python file
"     autocmd BufWinEnter *.py :call lsp#enable()
"     " local key mapping
"     autocmd FileType python nnoremap <C-]> :<C-u>LspDefinition<CR>
"     autocmd FileType python nnoremap K :<C-u>LspHover<CR>
"     autocmd FileType python nnoremap <LocalLeader>R :<C-u>LspRename<CR>
"     autocmd FileType python nnoremap <LocalLeader>n :<C-u>LspReferences<CR>
" augroup END
"
" " vim-lsp debuging
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

" LanguageClient-neovim=================================================================

let s:pyls_path = fnamemodify(g:python_host_prog, ':h') . '/'. 'pyls'
let g:LanguageClient_serverCommands = {
    \ 'go': ['bingo', '-disable-func-snippet', '-mode', 'stdio'],
    \ 'python': [expand(s:pyls_path)],
    \ }

" Disable showing gutter icons
let g:LanguageClient_diagnosticsEnable = 0

augroup GoLspCommands
    autocmd!
    autocmd FileType go nnoremap K :<C-u>call LanguageClient#textDocument_hover()<CR> 
    autocmd FileType go nnoremap <C-]> :<C-u>call LanguageClient#textDocument_definition()<CR> 
    autocmd FileType go nnoremap <LocalLeader>R :<C-u>call LanguageClient#textDocument_rename()<CR>
    autocmd FileType go nnoremap <LocalLeader>n :<C-u>call LanguageClient#textDocument_references()<CR>
augroup END

augroup PythonLspCommands
    autocmd!
    autocmd FileType python nnoremap K :<C-u>call LanguageClient#textDocument_hover()<CR> 
    autocmd FileType python nnoremap <C-]> :<C-u>call LanguageClient#textDocument_definition()<CR> 
    autocmd FileType python nnoremap <LocalLeader>R :<C-u>call LanguageClient#textDocument_rename()<CR>
    autocmd FileType python nnoremap <LocalLeader>n :<C-u>call LanguageClient#textDocument_references()<CR>
augroup END
