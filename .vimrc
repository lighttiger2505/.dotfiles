" magic word before
filetype off
filetype plugin indent off

" other vimrc source util
function! s:source_rc(path) abort 
    let l:abspath = resolve(expand('~/.vim/rc/' . a:path))
    execute 'source' fnameescape(l:abspath)
endfunction

" Load python3
if isdirectory(expand($PYENV_PATH))
    let g:python_host_prog = $PYENV_PATH . '/versions/neovim2/bin/python'
    let g:python3_host_prog = $PYENV_PATH . '/versions/neovim3/bin/python'
endif
if isdirectory(expand($ANYENV_PATH))
    let g:python_host_prog = $ANYENV_PATH . '/envs/pyenv/versions/neovim2/bin/python'
    let g:python3_host_prog = $ANYENV_PATH . '/envs/pyenv/versions/neovim3/bin/python'
endif

let g:dot_deoplete = v:false
let g:dot_vim_lsp = v:false
let g:dot_coc = v:false
let g:dot_cmp = v:true
let g:dot_nvim_lsp = v:true
let g:dot_dcc = v:false

call s:source_rc('mappings.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('filetype.rc.vim')
call s:source_rc('autocmd.rc.vim')
call s:source_rc('dein.rc.vim')

function! s:dein_update() abort
    call map(dein#check_clean(), "delete(v:val, 'rf')")
    call dein#check_update(v:true)
endfunction
command! -nargs=0 DeinUpdate :call s:dein_update()

function! s:dein_clean_update() abort
    call dein#recache_runtimepath()
    call dein#update()
endfunction
command! -nargs=0 DeinCleanUpdate :call s:dein_clean_update()

" Colors
set t_Co=256
set background=dark
colorscheme nvcode

" magic word after
filetype plugin indent on
syntax enable
