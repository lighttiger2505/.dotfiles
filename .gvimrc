set lines=999 lines=999

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

set guiheadroom=100

let s:font = 'Hack'
let s:fnt_size = 13

if has('win16') || has('win32') || has('win64')
    " Windows
elseif has('mac')
    " Mac
    exe ':set guifont=' . s:font . '\ h' . string(s:fnt_size)
else
    " linux
    exe ':set guifont=' . s:font . '\ ' . string(s:fnt_size)
endif

function! ResetFont ()
    exe ':set guifont=' . s:font . '\ ' . string(s:fnt_size)
endfunction

function! FontSizePlus ()
    let s:fnt_size = s:fnt_size + 1
    call ResetFont()
endfunction

function! FontSizeMinus ()
    let s:fnt_size = s:fnt_size - 1
    call ResetFont()
endfunction

nnoremap <Space>+ :call FontSizePlus()<CR>
nnoremap <Space>= :call FontSizePlus()<CR>
nnoremap <Space>- :call FontSizeMinus()<CR>
