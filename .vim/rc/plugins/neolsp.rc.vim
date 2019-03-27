g:LanguageClient_diagnosticsDisplay = {}

let s:pyls_path = fnamemodify(g:python_host_prog, ':h') . '/'. 'pyls'
let g:LanguageClient_serverCommands = {
    \ 'go': ['bingo', '-disable-func-snippet', '-mode', 'stdio'],
    \ 'python': [s:pyls_path],
    \ }

augroup GoLspCommands
    autocmd!
    autocmd FileType go nnoremap <C-]> :<C-u>call LanguageClient#textDocument_definition()<CR>
    autocmd FileType go nnoremap K :<C-u>call LanguageClient#textDocument_hover()<CR>
    autocmd FileType go nnoremap <LocalLeader>R :<C-u>LanguageClient#textDocument_rename()<CR>
    autocmd FileType go nnoremap <LocalLeader>n :<C-u>LanguageClient#textDocument_references()<CR>
    " autocmd FileType go nnoremap <LocalLeader>d :<C-u>LspDocumentDiagnostics<CR>
augroup END
