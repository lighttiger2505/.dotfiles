" Disable at startup
let g:ale_enabled = 1

" Appearance
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0

" Event of lint enter
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

" Quickfix and Loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0

let g:ale_statusline_format = ['%d Error', '%d Warn', 'OK']

" Enable linter
let g:ale_linters = {
    \ 'javascript': ['jslint', 'eslint'],
    \ 'python': ['flake8'],
    \ 'markdown': ['mdl'],
    \ 'go': ['gometalinter'],
    \ 'make': ['checkmake'],
    \ 'vim': ['vint'],
    \ 'shell': ['shellcheck'],
    \ }

let g:ale_fixers = {
    \ 'python': ['autopep8', 'black', 'isort'],
    \ }

" gometalinter
let g:ale_go_gometalinter_options = '--fast --vendor --disable-all --enable=golint --enable=vet --enable=gofmt --enable=errcheck --enable=goconst --enable=goimports --enable=megacheck'

" flake8
let g:ale_python_flake8_executable = g:python3_host_prog
let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_autopep8_executable = g:python3_host_prog
let g:ale_python_autopep8_options = '-m autopep8'
let g:ale_python_isort_executable = g:python3_host_prog
let g:ale_python_isort_options = '-m isort'
let g:ale_python_black_executable = g:python3_host_prog
let g:ale_python_black_options = '-m black'

" mapping
nmap <silent> [a <Plug>(ale_previous)
nmap <silent> ]a <Plug>(ale_next)
nmap <silent> <Leader>x <Plug>(ale_fix)
