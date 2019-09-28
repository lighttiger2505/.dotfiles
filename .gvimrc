" Basic setting
set visualbell

" Enable clipboard
set guioptions+=a
" Disable menubar
set guioptions-=m
" Disable toolbar
set guioptions-=T
" Disable scroll bars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

if has('win16') || has('win32') || has('win64')
    " Windows
elseif has('mac')
    " Mac
    set guifont=Cica:h16
else
    " linux
    set guifont="Cica\ 16"
endif
