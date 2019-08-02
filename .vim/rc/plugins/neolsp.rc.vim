let g:LanguageClient_autoStart = 1
let g:LanguageClient_selectionUI = "fzf"
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_diagnosticsList = "Disabled"
let g:LanguageClient_useVirtualText = 0
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_settingsPath = $HOME . '/.vim/files/lssettings.json'

let s:pyls_path = fnamemodify(g:python3_host_prog, ':h') . '/'. 'pyls'
let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls', '-mode', 'stdio'],
    \ 'python': [s:pyls_path],
    \ }

augroup GoLspCommands
    autocmd!
    autocmd FileType go nnoremap <C-]> :<C-u>call LanguageClient#textDocument_definition()<CR>
    autocmd FileType go nnoremap K :<C-u>call LanguageClient#textDocument_hover()<CR>
    autocmd FileType go nnoremap <LocalLeader>R :<C-u>LanguageClient#textDocument_rename()<CR>
    autocmd FileType go nnoremap <LocalLeader>n :<C-u>LanguageClient#textDocument_references()<CR>
augroup END

augroup PythonLspCommands
    autocmd!
    autocmd FileType python nnoremap <C-]> :<C-u>call LanguageClient#textDocument_definition()<CR>
    autocmd FileType python nnoremap K :<C-u>call LanguageClient#textDocument_hover()<CR>
    autocmd FileType python nnoremap <LocalLeader>R :<C-u>LanguageClient#textDocument_rename()<CR>
    autocmd FileType python nnoremap <LocalLeader>n :<C-u>LanguageClient#textDocument_references()<CR>
augroup END
