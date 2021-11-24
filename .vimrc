" magic word before
filetype off
filetype plugin indent off

" other vimrc source util
function! s:source_rc(path) abort 
    let l:abspath = resolve(expand('~/.vim/rc/' . a:path))
    execute 'source' fnameescape(l:abspath)
endfunction

" echo message vim start up time
if has('vim_starting') && has('reltime')
    augroup VimStart
        autocmd!
        let g:startuptime = reltime()
        autocmd VimEnter * let g:startuptime = reltime(g:startuptime) | redraw | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
endif

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
let g:dot_cmp = v:false
let g:dot_nvim_lsp = v:true
let g:dot_dcc = v:true

call s:source_rc('mappings.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('filetype.rc.vim')
call s:source_rc('autocmd.rc.vim')
call s:source_rc('dein.rc.vim')

function! s:dein_clean_update() abort
    call map(dein#check_clean(), "delete(v:val, 'rf')")
    call dein#check_update(v:true)
endfunction
command! -nargs=0 DeinCleanUpdate :call s:dein_clean_update()

" Colors
set t_Co=256
set background=dark
let g:nvcode_termcolors=256
colorscheme nvcode

" magic word after
filetype plugin indent on
syntax enable
