
" Basic setting
set visualbell

" Apperance setting "{{{
set lines=40
set columns=120
colorscheme hybrid
" }}}

" Font setting "{{{
if has('win16') || has('win32') || has('win64')
    " Windows
    " 使用していないので未実装
elseif has('mac')
    " Mac
    set guifont=Osaka－等幅:h14
    set guifont=Ricty:h14
else
    " linux
    set guifont=Osaka－等幅\ 12
    set guifont=Ricty\ 12
endif
" }}}

" vim: foldmethod=marker

