" Specifies the type of list to use for command outputs
let g:go_list_type = "locationlist"
let g:go_list_type_commands = {"GoInstall": "quickfix", "GoBuild": "quickfix", "GoTest": "quickfix"}
let g:go_list_autoclose = 1
let g:go_list_height = 10

    " disable it will jump to the first error automatically
let g:go_jump_to_error = 0

" disable running build and test command in terminal
let g:go_term_enabled = 0
let g:go_term_mode = "split"
let g:go_term_height = 10
" let g:go_term_width = 30

" go highlights
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" highlight all uses of the identifier under the cursor. |:GoSameIds| automatically
let g:go_auto_sameids = 0

" description of the identifer under the cursor.
let g:go_auto_type_info = 0

augroup GoCommands
    autocmd!
    " autocmd FileType go nmap <silent><Leader>r  <Plug>(go-run)
    autocmd FileType go nmap <silent><Leader>b  <Plug>(go-build)
    autocmd FileType go nmap <silent><Leader>tt <Plug>(go-test)
    autocmd FileType go nmap <silent><Leader>tf <Plug>(go-test-func)
    autocmd FileType go nmap <silent><Leader>m  <Plug>(go-imports)
    autocmd FileType go nmap <silent><Leader>i  <Plug>(go-install)
    autocmd FileType go nmap <silent>K          <Plug>(go-doc)
    autocmd FileType go nmap <silent><Leader>w  <Plug>(go-doc-browser)
    autocmd FileType go nmap <silent><Leader>R  <Plug>(go-rename)
    autocmd FileType go nmap <silent><Leader>v  :GoCoverageToggle -short<CR>
    autocmd FileType go nmap <silent><Leader>n  <Plug>(go-callees)
    autocmd FileType go nmap <silent><Leader>aa <Plug>(go-alternate-edit)
    autocmd FileType go nmap <silent><Leader>as <Plug>(go-alternate-split)
    autocmd FileType go nmap <silent><Leader>av <Plug>(go-alternate-vertical)
augroup END
