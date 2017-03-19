
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" python syntastick check
let g:syntastic_python_checkers = ['python', 'flake8', 'mypy']

" key mapps
nmap <Leader>sc :<C-u>SyntasticCheck

