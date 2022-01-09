" Diagnostics
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_signature_help_enabled = 1

let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': '‼'}
let g:lsp_diagnostics_signs_hint = {'text': 'i'}
let g:lsp_document_code_action_signs_hint = {'text': ''}
let g:lsp_signs_hint = {'text': '?'}
let g:lsp_virtual_text_prefix = " ‣ "
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_echo_delay = 200
let g:lsp_format_sync_timeout = 1000

" Highlight
let g:lsp_highlights_enabled = 0
let g:lsp_highlight_references_enabled = 0
let g:lsp_document_highlight_enabled = 0
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0

" Floating window
let g:lsp_preview_float = 1

let s:completion_item_kinds_with_icons = {
\ '1':  ' text',
\ '2':  'ƒ method',
\ '3':  ' function',
\ '4':  ' constructor',
\ '6':  ' variable',
\ '7':  ' class',
\ '8':  'ﰮ interface',
\ '9':  ' module',
\ '10': ' property',
\ '11': ' unit',
\ '12': ' value',
\ '14': ' keyword',
\ '15': '﬌ snippet',
\ '16': ' color',
\ '17': ' file',
\ '19': ' folder',
\ '20': ' enum member',
\ '21': ' constant',
\ '22': ' struct',
\ }

let g:lsp_settings = {
\  'sqls': {
\    'config': {'completion_item_kinds': s:completion_item_kinds_with_icons},
\  },
\  'gopls': {
\    'config': {'completion_item_kinds': s:completion_item_kinds_with_icons},
\  },
\}

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'allowlist': ['typescript', 'typescript.tsx', 'typescriptreact'],
        \ })
endif

if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'allowlist': ['go'],
        \ })
endif

if executable('vls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'vls',
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

if executable('sqls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sqls',
        \ 'cmd': ['sqls', '-log', expand('~/sqls.log'), '-config', expand('~/.config/sqls/config.yml')],
        \ 'allowlist': ['sql'],
        \ 'workspace_config': {
        \   'sqls': {
        \     'connections': [
        \       {
        \         'driver': 'mysql',
        \         'dataSourceName': 'root:root@tcp(127.0.0.1:3306)/world',
        \       },
        \     ],
        \   },
        \ },
        \ })
endif

" if executable('efm-langserver')
"     au User lsp_setup call lsp#register_server({
"        \ 'name': 'efm-langserver',
"        \ 'cmd': {server_info->['efm-langserver', '-c', expand('~/.config/efm-langserver/config.yml')]},
"        \ 'allowlist': ['markdown'],
"        \ })
" endif

let g:lsp_settings_root_markers = [
\  '.git',
\  '.git/',
\  '.svn',
\  '.hg',
\  '.bzr'
\]

function! s:on_lsp_buffer_enabled() abort
    call lsp#enable()
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)

    nmap <buffer> [d <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]d <Plug>(lsp-next-diagnostic)

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

    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

augroup LspEnable
    autocmd!
    autocmd BufWinEnter *.go   :call lsp#enable()
    autocmd BufWinEnter *.py   :call lsp#enable()
    autocmd BufWinEnter *.ts   :call lsp#enable()
    autocmd BufWinEnter *.js   :call lsp#enable()
    autocmd BufWinEnter *.vue  :call lsp#enable()
    autocmd BufWinEnter *.c    :call lsp#enable()
    autocmd BufWinEnter *.h    :call lsp#enable()
    autocmd BufWinEnter *.cpp  :call lsp#enable()
    autocmd BufWinEnter *.tsx  :call lsp#enable()
    autocmd BufWinEnter *.sql  :call lsp#enable()
    autocmd BufWinEnter *.md   :call lsp#enable()
augroup END

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
