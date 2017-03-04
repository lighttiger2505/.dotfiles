
function! s:source_rc(path, ...) abort "{{{
  let use_global = get(a:000, 0, !has('vim_starting'))
  let abspath = resolve(expand('~/.vim/rc/' . a:path))
  if !use_global
    execute 'source' fnameescape(abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let content = map(readfile(abspath),
        \ 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')
  " create tempfile and source the tempfile
  let tempfile = tempname()
  try
    call writefile(content, tempfile)
    execute 'source' fnameescape(tempfile)
  finally
    if filereadable(tempfile)
      call delete(tempfile)
    endif
  endtry
endfunction"}}}

call s:source_rc('dein.rc.vim')

filetype plugin indent on

" Enable syntax color.
syntax enable

call s:source_rc('mappings.rc.vim')

call s:source_rc('options.rc.vim')

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

" Tab Settings {{{

" Anywhere SID.
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()
    let s = ''
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
        let no = i  " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
        let title = fnamemodify(bufname(bufnr), ':t')
        let title = '[' . title . ']'
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

" Plugin Settings:"{{{
"
call s:source_rc('plugins/unite.rc.vim')
"
call s:source_rc('plugins/vimfiler.rc.vim')

call s:source_rc('plugins/neosnippet.rc.vim')

call s:source_rc('plugins/vimquickrun.rc.vim')

call s:source_rc('plugins/vimlightline.rc.vim')

" open-browser"{{{
" This is my setting.
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Open URI under cursor.
nmap map-you-like <Plug>(openbrowser-open)
" Open selected URI.
vmap map-you-like <Plug>(openbrowser-open)

" Search word under cursor.
nmap map-you-like <Plug>(openbrowser-search)
" Search selected word. vmap map-you-like <Plug>(openbrowser-search)

" If it looks like URI, Open URI under cursor.
" Otherwise, Search word under cursor.
nmap map-you-like <Plug>(openbrowser-smart-search)
" If it looks like URI, Open selected URI.
" Otherwise, Search selected word.
vmap map-you-like <Plug>(openbrowser-smart-search)
"}}}

" syntastic"{{{
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
nmap <Leader>sc :<C-u>SyntasticCheck
"}}}

" caw"{{{
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)
"}}}


" vim:set foldmethod=marker:
