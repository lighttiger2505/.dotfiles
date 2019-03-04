let g:lsp_signs_enabled = 0
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_signs_error = {'text': '!!'}
let g:lsp_signs_warning = {'text': '=='}
let g:lsp_signs_hint = {'text': '??'}

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
    " " auto formatting before save
    " autocmd BufWritePre *.go LspDocumentFormatSync
    " local key mapping
    autocmd FileType go nnoremap <C-]> :<C-u>LspDefinition<CR>
    autocmd FileType go nnoremap K :<C-u>LspHover<CR>
    autocmd FileType go nnoremap <LocalLeader>R :<C-u>LspRename<CR>
    autocmd FileType go nnoremap <LocalLeader>n :<C-u>LspReferences<CR>
    autocmd FileType go nnoremap <LocalLeader>d :<C-u>LspDocumentDiagnostics<CR>
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
    autocmd FileType python nnoremap <LocalLeader>d :<C-u>LspDocumentDiagnostics<CR>
augroup END
