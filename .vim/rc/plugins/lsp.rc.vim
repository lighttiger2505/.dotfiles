let g:lsp_signs_enabled = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_highlight_references_enabled = 0
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

if executable('gopls')
    augroup LspGo
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
            \ 'whitelist': ['go'],
            \ })
    augroup END
endif

if executable('typescript-language-server')
    augroup LspTypeScript
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'whitelist': ['typescript', 'typescript.tsx'],
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
    autocmd FileType go nnoremap <LocalLeader>f :<C-u>LspDocumentDiagnostics<CR>
    autocmd FileType go setlocal omnifunc=lsp#complete
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
    autocmd FileType python nnoremap <LocalLeader>f :<C-u>LspDocumentDiagnostics<CR>
    autocmd FileType go setlocal omnifunc=lsp#complete
augroup END

augroup TypescriptLspCommands
    autocmd!
    " TODO 
    " start golsp when enter python file
    autocmd BufWinEnter *.ts :call lsp#enable()
    " auto formatting before save
    autocmd BufWritePre *.ts LspDocumentFormatSync
    " local key mapping
    autocmd FileType typescript nnoremap <C-]> :<C-u>LspDefinition<CR>
    autocmd FileType typescript nnoremap K :<C-u>LspHover<CR>
    autocmd FileType typescript nnoremap <LocalLeader>R :<C-u>LspRename<CR>
    autocmd FileType typescript nnoremap <LocalLeader>n :<C-u>LspReferences<CR>
    autocmd FileType typescript nnoremap <LocalLeader>f :<C-u>LspDocumentDiagnostics<CR>
    autocmd FileType typescript setlocal omnifunc=lsp#complete
augroup END
