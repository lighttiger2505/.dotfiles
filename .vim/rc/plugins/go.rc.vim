" Specifies the type of list to use for command outputs
let g:go_list_type = "locationlist"
let g:go_list_type_commands = {"GoInstall": "quickfix", "GoBuild": "quickfix", "GoTest": "quickfix"}
let g:go_list_autoclose = 1
let g:go_list_height = 10

" disable vim-go default mapping for use vim-lsp
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_textobj_enabled = 0

" disable it will jump to the first error automatically
let g:go_jump_to_error = 0

" disable running build and test command in terminal
let g:go_term_enabled = 0
let g:go_term_mode = "split"
let g:go_term_height = 10
" let g:go_term_width = 30

" Disable gopls
let g:go_gopls_enabled = 0

" highlight all uses of the identifier under the cursor. |:GoSameIds| automatically
let g:go_auto_sameids = 0

" description of the identifer under the cursor.
let g:go_auto_type_info = 0

" disable auto go fmt
let g:go_fmt_autosave = 0
let g:go_mod_fmt_autosave = 0

" Use sonictempate
let g:go_template_autocreate = 0
let g:sonictemplate_enable_pattern = 1

augroup GoCommands
    autocmd!
    autocmd FileType go nmap <silent><LocalLeader>r  <Plug>(go-run)
    autocmd FileType go nmap <silent><LocalLeader>b  <Plug>(go-build)
    autocmd FileType go nmap <silent><LocalLeader>tt <Plug>(go-test)
    autocmd FileType go nmap <silent><LocalLeader>tf <Plug>(go-test-func)
    autocmd FileType go nmap <silent><LocalLeader>m  <Plug>(go-imports)
    autocmd FileType go nmap <silent><LocalLeader>ts :<C-u>GoTests
    autocmd FileType go nmap <silent><LocalLeader>ta :<C-u>GoTestsAll
    autocmd FileType go nmap <silent><LocalLeader>i  <Plug>(go-install)
    autocmd FileType go nmap <silent><LocalLeader>k  <Plug>(go-doc-browser)
    autocmd FileType go nmap <silent><LocalLeader>c  <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <silent><LocalLeader>a  <Plug>(go-alternate-edit)
    autocmd FileType go nmap <silent><LocalLeader>e  <Plug>(go-iferr)
augroup END
