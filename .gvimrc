
" Basic setting
set visualbell

" Apperance setting "{{{
set lines=40
set columns=120
colorscheme desert
" }}}

" Font setting "{{{
if has('win16') || has('win32') || has('win64')
    " Windows
    " 使用していないので未実装
elseif has('mac')
    " Mac
    set guifont=Osaka－等幅:h11
    set guifont=Ricty:h11
else
    " linux
    set guifont=Osaka－等幅\ 11
    set guifont=Ricty\ 11
endif
" }}}

" vim: foldmethod=marker

