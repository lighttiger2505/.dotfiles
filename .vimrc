
"" Keybind move cursor
:noremap k gk
:noremap j gj
:noremap gk k
:noremap gj j
:noremap <Down> gj
:noremap <Up> gk
:noremap <Space>h ^
:noremap <Space>l $

"" Keyvind edit
:noremap <Space>/ *
:noremap <Space>m %

"" Keybind mode change
:noremap ; :
:noremap : ;


"" Keybind window
:noremap <Space>wh <C-w>wh
:noremap <Space>wl <C-w>wl
:noremap <Space>wj <C-w>wj
:noremap <Space>wk <C-w>wk

"" Keyvind edit .vimrc
:nnoremap <Space>ev :tabnew $HOME/.vimrc<CR>
:nnoremap <Space>rv :source $HOME/.vimrc<CR>
"" Keybind call help
nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

"" File format
:set number
:set cursorline
:set list
:set listchars=eol:<,tab:▸\ 
:set tabstop=2
:set shiftwidth=2
:set scrolloff=20

" NeoBundle Setup
set nocompatible
filetype off

if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
   call neobundle#rc(expand('~/.vim/bundle/'))
 endif

" Install Plugin For NeoBUndle
NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'

" unite{{{
NeoBundle 'Shougo/unite.vim'
" Unite Settings
let g:unite_enable_start_insert=0
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
let g:unite_split_rule = 'topleft'
" Unite keybind
nnoremap <silent> <Space>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Space>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Space>uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> <Space>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"}}}

" unite-outline{{{
NeoBundle 'Shougo/unite-outline'
" unite-outline keybind
let g:unite_split_rule = 'botright'
nnoremap <silent> <Space>uo :Unite -vertical -no-quit -winwidth=40 outline<Return>
" }}}

" vimfiler{{{
NeoBundle 'Shougo/vimfiler'
" Settings
let g:vimfiler_as_default_explorer = 0
let g:vimfiler_safe_mode_by_default = 0
" Keybind
nnoremap <silent> <Space>fe :<C-u>VimFilerBufferDir -quit<CR>
nnoremap <silent> <Space>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
" }}}

" NeoComplcashe{{{
NeoBundle 'Shougo/neocomplcache'

" Settings
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Key-mappings
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" }}}

" neosnippet{{{
NeoBundle 'Shougo/neosnippet'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" }}}

NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-markdown'

" vim-quickrun{{{
NeoBundle 'thinca/vim-quickrun'

" Key-mappings
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
	\ 'outputter':'browser'
	\ }
" }}}

NeoBundle 'tyru/open-browser.vim'

" vim-instant-markdown{{{
NeoBundle 'suan/vim-instant-markdown'
let g:instant_markdown_autostart = 0
" }}}

NeoBundle 'derekwyatt/vim-scala'

NeoBundle 'osyo-manga/vim-over'

NeoBundle 'LeafCage/yankround.vim'

" wauto{{{
NeoBundle 'syui/wauto.vim'
" Settings
let g:auto_write = 0
" Key-mappings
nmap <Leader>s  <Plug>(AutoWriteStart)
nmap <Leader>ss <Plug>(AutoWriteStop)
" }}}

" Colorschemes{{{
NeoBundle 'fugalh/desert.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
" }}}

filetype plugin on
filetype indent on

:colorscheme desert

