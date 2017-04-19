" Tab setting for file type
augroup MyAutocmd
    autocmd BufNewFile,BufRead *.rhtml set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html  set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.css   set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.scss  set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.scala set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb    set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.erb   set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.c     set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.cpp   set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.h     set tabstop=4 shiftwidth=4
    autocmd BufRead,BufNewFile *.scss set filetype=scss
augroup END

" Python error format
let &l:errorformat = '%A  File "%f"\, line %l\,%m'
