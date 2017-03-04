
" Basic setting
set visualbell

" Apperance setting "{{{
set lines=40
set columns=120
colorscheme badwolf
" }}}

" Font setting "{{{
if has('win16') || has('win32') || has('win64')
    " Windows
    " 使用していないので未実装
elseif has('mac')
    " Mac
    set guifont=Osaka－等幅:h14
    set guifont=Inconsolata-g:h14
else
    " linux
    set guifont=Osaka－等幅\ 14
    set guifont=Inconsolata-g\ 14
endif
" }}}

" vim: foldmethod=marker

