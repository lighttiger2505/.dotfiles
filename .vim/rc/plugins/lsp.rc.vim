" Diagnostics
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_information = {'text': 'i'}
let g:lsp_signs_hint = {'text': '?'}
let g:lsp_virtual_text_prefix = " ‣ "
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_echo_delay = 200
let g:lsp_format_sync_timeout = 1000

" Highlight
let g:lsp_highlights_enabled = 0
let g:lsp_highlight_references_enabled = 0
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0

" Floating window
let g:lsp_preview_float = 1

if executable('pyls')
    let s:pyls_path = fnamemodify(g:python3_host_prog, ':h') . '/'. 'pyls'
    let s:pyls_config = {'pyls': {'plugins': {
    \   'pycodestyle': {'enabled': v:true},
    \   'pydocstyle': {'enabled': v:false},
    \   'pylint': {'enabled': v:false},
    \   'flake8': {'enabled': v:true},
    \   'jedi_definition': {
    \     'follow_imports': v:true,
    \     'follow_builtin_imports': v:true,
    \   },
    \ }}}
    au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': { server_info -> [s:pyls_path] },
    \ 'allowlist': ['python'],
    \ 'workspace_config': s:pyls_config
    \})
endif

" see also: https://github.com/golang/tools/blob/master/internal/lsp/source/options.go
if executable('gopls')
    au User lsp_setup call lsp#register_server({
    \ 'name': 'gopls',
    \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
    \ 'allowlist': ['go'],
    \ 'workspace_config': {'gopls': {
    \     'completionDocumentation': v:true,
    \     'usePlaceholders': v:true,
    \     'deepCompletion': v:true,
    \     'fuzzyMatching': v:true,
    \     'caseSensitiveCompletion': v:false,
    \     'completeUnimported': v:true,
    \     'staticcheck': v:true,
    \     'watchFileChanges': v:true,
    \     'hoverKind': 'FullDocumentation',
    \   }},
    \ })
endif

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
    \ 'name': 'typescript-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
    \ 'allowlist': ['javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact'],
    \ 'blocklist': ['vue'],
    \ })
endif

if executable('clangd')
    au User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': {server_info->['clangd', '-background-index']},
    \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
    \ })
endif

if executable('sqls')
    au User lsp_setup call lsp#register_server({
    \   'name': 'sqls',
    \   'cmd': {server_info->['sqls', '-log', expand('~/sqls.log'), '-config', expand('~/.config/sqls/config.yml')]},
    \   'allowlist': ['sql'],
    \   'workspace_config': {
    \     'sqls': {
    \       'connections': [
    \         {
    \           'driver': 'mysql',
    \           'dataSourceName': 'root:root@tcp(127.0.0.1:3306)/world',
    \         },
    \       ],
    \     },
    \   },
    \ })
endif

if executable('vls')
    au User lsp_setup call lsp#register_server({
    \ 'name': 'vue-language-server',
    \ 'cmd': {server_info->['vls']},
    \ 'allowlist': ['vue'],
    \ 'blocklist': ['javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx'],
    \ 'initialization_options': {
    \     'config': {
    \         'html': {},
    \          'vetur': {
    \              'validation': {}
    \          }
    \     }
    \ },
    \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)

    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)

    nmap <buffer> K <plug>(lsp-hover)

    noremap <buffer> <C-]>      :<C-u>LspDefinition<CR>
    noremap <buffer> <C-w><C-]> :<C-u>vertical LspDefinition<CR>
    noremap <buffer> t<C-]>     :<C-u>tab LspDefinition<CR>

    nmap <buffer> <LocalLeader>R <plug>(lsp-rename)
    nmap <buffer> <LocalLeader>n <plug>(lsp-references)
    nmap <buffer> <LocalLeader>f <plug>(lsp-document-diagnostics)
    nmap <buffer> <LocalLeader>s <plug>(lsp-document-format)
    vmap <buffer> <LocalLeader>s <plug>(lsp-document-format)
    nmap <buffer> <LocalLeader>i <plug>(lsp-implementation)

    " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
