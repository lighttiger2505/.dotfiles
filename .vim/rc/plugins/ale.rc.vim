" Appearance
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 1

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
\   'javascript': ['jslint', 'eslint'],
\   'python': ['flake8'],
\   'markdown': ['mdl'],
\   'go': ['gometalinter '],
\}

" Prefix key
nmap [ale] <Nop>
map <C-k> [ale]

" Keymap
nmap <silent> [ale]<C-P> <Plug>(ale_previous)
nmap <silent> [ale]<C-N> <Plug>(ale_next)
