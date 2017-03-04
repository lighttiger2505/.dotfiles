
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

" neosnippet"{{{
" <TAB>: completion.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
"}}}

" vim-quickrun{{{
let g:quickrun_config = {
            \   "_" : {
            \       "runner" : "vimproc",
            \       "runner/vimproc/updatetime" : 60,
            \       "outputter/buffer/split" : ":botright",
            \       "outputter/buffer/close_on_empty" : 1
            \   },
            \}
let g:quickrun_config['html'] = { 'command' : 'open', 'exec' : '%c %s', 'outputter': 'browser' }
" }}}

" vim-instant-markdown{{{
let g:instant_markdown_autostart = 0
" }}}

" wauto{{{
" Settings
let g:auto_write = 0
" Key-mappings
nmap <Leader>as  <Plug>(AutoWriteStart)
nmap <Leader>ass <Plug>(AutoWriteStop)
" }}}

" lightline{{{
set laststatus=2
" Settings
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'mode_map': {'c': 'NORMAL'},
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
            \ },
            \ 'component_function': {
            \   'modified': 'MyModified',
            \   'readonly': 'MyReadonly',
            \   'fugitive': 'MyFugitive',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'fileencoding': 'MyFileencoding',
            \   'mode': 'MyMode'
            \ }
            \ }

function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            return fugitive#head()
        endif
    catch
    endtry
    return ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}

" vim-over{{{
" vim-over command line launch. Enterd command [%s/].
cnoreabb <silent><expr>s getcmdtype()==':' && getcmdline()=~'^s' ? 'OverCommandLine<CR><C-u>%s/<C-r>=get([], getchar(0), '')<CR>' : 's'
" }}}

" emmet-vim {{{
let g:user_emmet_mode = 'iv'
let g:user_emmet_leader_key = '<C-y>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
            \ 'lang' : 'ja',
            \ 'html' : {
            \ 'filters' : 'html',
            \ },
            \ 'css' : {
            \ 'filters' : 'fc',
            \ },
            \ 'php' : {
            \ 'extends' : 'html',
            \ 'filters' : 'html',
            \ },
            \}
augroup EmmitVim
    autocmd!
    autocmd FileType * let g:user_emmet_settings.indentation = ' '[:&tabstop]
augroup END
" }}}

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

" vim-fugitive"{{{
nnoremap <Space>gs :<C-u>Gstatus<CR>
nnoremap <Space>ga :<C-u>Gwrite<CR>
nnoremap <Space>gr :<C-u>Gread<CR>
nnoremap <Space>gm :<C-u>Gmove<CR>
nnoremap <Space>gv :<C-u>Gremove<CR>
nnoremap <Space>gb :<C-u>Gblame<CR>
nnoremap <Space>gd :<C-u>Gdiff<CR>
nnoremap <Space>gc :<C-u>Gcommit<CR>
"}}}

" vim-indent-guides {{{
let g:indent_guides_indent_levels = 30
let g:indent_guides_auto_colors = 1
" }}}

" gundo"{{{
nmap <Leader>g :<C-u>GundoToggle
" }}}

" syntastic"{{{
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
nmap <Leader>sc :<C-u>SyntasticCheck
"}}}

" vim-quickhl"{{{
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
"}}}

" alpaca_tags"{{{

" Find of useful language is `ctags --list-maps=all`
let g:alpaca_update_tags_config = {
            \ '_' : '-R --sort=yes --languages=-js,html,css',
            \ 'ruby': '--languages=+Ruby',
            \ }

augroup AlpacaTags
    autocmd!
    if exists(':Tags')
        autocmd BufWritePost * TagsUpdate ruby
        autocmd BufWritePost Gemfile TagsBundle
        autocmd BufEnter * TagsSet
    endif
augroup END

nnoremap <expr>tt  ':Unite tags -horizontal -buffer-name=tags -input='.expand("<cword>").'<CR>'
"}}}

" vim-rails"{{{
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0

function! SetUpRailsSetting()
    nnoremap <buffer>,r :R<CR>
    nnoremap <buffer>,a :A<CR>
    nnoremap <buffer>,m :Rmodel<CR>
    nnoremap <buffer>,c :Rcontroller<CR>
    nnoremap <buffer>,v :Rview<CR>
    nnoremap <buffer>,p :Rpreview<CR>
endfunction

aug MyAutoCmd
    au User Rails call SetUpRailsSetting()
aug END

aug RailsDictSetting
    au!
aug END
"}}}

" caw"{{{
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)
"}}}


" vim:set foldmethod=marker:
