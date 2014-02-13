
" Bundle Settings {{{
set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

" Basic plugin"{{{
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'syui/wauto.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'thinca/vim-template'
NeoBundle 'h1mesuke/vim-alignta.git'

NeoBundleLazy 'Shougo/vimshell', {
            \ 'autoload' : { 'filetypes' : ['vimshell'] }}

NeoBundleLazy 'Shougo/neosnippet.vim'

NeoBundleLazy 'Shougo/neosnippet-snippets'

NeoBundleLazy 'thinca/vim-quickrun', {
            \ 'commands' : 'QuickRun',
            \ 'mappings' : [
            \   ['nxo', '<Plug>(quickrun)']],
            \ }

NeoBundleLazy 'tyru/open-browser.vim', {
            \ 'mappings' : '<Plug>(open-browser-',}

NeoBundleLazy 'osyo-manga/vim-over', {
            \   'autoload' : {'commands' : ['OverCommandLine'] }}

NeoBundleLazy 'thinca/vim-ref', {
            \ 'autoload' : { 'commands' : ['Ref'] }}

NeoBundleLazy "sjl/gundo.vim", {
            \ "autoload": {
            \   "commands": ['GundoToggle'],
            \}}

NeoBundleLazy 'scrooloose/syntastic', {
            \ 'autoload' : {
            \ 'commands' : ['SyntasticCheck']}}

" NeoBundle config"{{{
call neobundle#config('neosnippet.vim', {
            \ 'lazy' : 1,
            \ 'depends' : 'Shougo/neosnippet-snippets',
            \ 'autoload' : {
            \   'insert' : 1,
            \   'filetypes' : 'snippet',
            \   'unite_sources' : [
            \      'neosnippet', 'neosnippet/user', 'neosnippet/runtime'],
            \ }})

call neobundle#config('unite.vim',{
            \ 'lazy' : 1,
            \ 'autoload' : {
            \   'commands' : [{ 'name' : 'Unite',
            \                   'complete' : 'customlist,unite#complete_source'},
            \                   'UniteWithCursorWord', 'UniteWithInput', 'UniteWithBufferDir']
            \ }})

call neobundle#config('vimfiler', {
            \ 'lazy' : 1,
            \ 'depends' : 'Shougo/unite.vim',
            \ 'autoload' : {
            \    'commands' : [
            \                  { 'name' : 'VimFiler',
            \                    'complete' : 'customlist,vimfiler#complete' },
            \                  { 'name' : 'VimFilerTab',
            \                    'complete' : 'customlist,vimfiler#complete' },
            \                  { 'name' : 'VimFilerExplorer',
            \                    'complete' : 'customlist,vimfiler#complete' },
            \                  { 'name' : 'Edit',
            \                    'complete' : 'customlist,vimfiler#complete' },
            \                  { 'name' : 'Write',
            \                    'complete' : 'customlist,vimfiler#complete' },
            \                  'Read', 'Source', 'VimFilerBufferDir'],
            \    'mappings' : '<Plug>(vimfiler_',
            \    'explorer' : 1,
            \ }
            \ })

call neobundle#config('vimproc', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ })

call neobundle#config('vimshell', {
            \ 'lazy' : 1,
            \ 'autoload' : {
            \   'commands' : [{ 'name' : 'VimShell',
            \                   'complete' : 'customlist,vimshell#complete'},
            \                 'VimShellExecute', 'VimShellInteractive',
            \                 'VimShellCreate',
            \                 'VimShellTerminal', 'VimShellPop'],
            \   'mappings' : '<Plug>(vimshell_'
            \ }})


call neobundle#config('neocomplete.vim', {
            \ 'lazy' : 1,
            \ 'autoload' : {
            \   'insert' : 1,
            \   'commands' : 'NeoCompleteBufferMakeCache',
            \ }})

call neobundle#config('unite-outline', {
            \ 'lazy' : 1,
            \ 'autoload' : {
            \   'unite_sources' : 'outline'},
            \ })
"}}}

"}}}

" For each filetype plugin"{{{
" markdown
NeoBundleLazy 'tpope/vim-markdown', {
            \ 'autoload' : { 'filetypes' : ['md'] }}

" Scala
NeoBundleLazy 'derekwyatt/vim-scala', {
            \ 'autoload' : { 'filetypes' : ['scala'] }}
NeoBundleLazy 'ktvoelker/sbt-vim', {
            \ 'autoload' : { 'filetypes' : ['scala'] }}
NeoBundleLazy 'gre/play2vim', {
            \ 'depends' : 'derekwyatt/vim-scala',
            \ 'autoload' : { 'filetypes' : ['html'] },}

" haskell
NeoBundleLazy 'dag/vim2hs', {
            \ 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'eagletmt/ghcmod-vim', {
            \ 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'pbrisbin/html-template-syntax', {
            \ 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'eagletmt/neco-ghc', {
            \ 'autoload' : { 'filetypes' : ['haskell'] }}
NeoBundleLazy 'eagletmt/unite-haddock', {
            \ 'autoload' : { 'filetypes' : ['haskell'] }}

" HTML 
NeoBundleLazy 'othree/html5.vim', {
            \ 'autoload' : { 'filetypes' : ['html'] }}
NeoBundleLazy 'hail2u/vim-css3-syntax', {
            \ 'autoload' : { 'filetypes' : ['css'] }}
NeoBundleLazy 'mattn/emmet-vim', {
            \ 'autoload' : { 'filetypes' : ['html', 'css'] }}

" Ruby
NeoBundleLazy 'vim-ruby/vim-ruby', {
            \ 'mappings' : '<Plug>(ref-',
            \ 'filetypes' : 'ruby'
            \ }

NeoBundleLazy 'tpope/vim-rails', {
            \ 'autoload' : { 'filetypes' : ['ruby'] }}

NeoBundleLazy 'bbatsov/rubocop', {
            \ 'autoload' : { 'filetypes' : ['ruby'] }}

NeoBundleLazy 'basyura/unite-rails', {
            \ 'autoload' : { 'filetypes' : ['ruby'] }}

NeoBundleLazy 'vim-scripts/ruby-matchit', {
            \ 'autoload' : { 'filetypes' : ['ruby'] }}

"}}}

" Colorschemes"{{{
NeoBundle 'fugalh/desert.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'w0ng/vim-hybrid'
"}}}

filetype plugin indent on

" Enable syntax color.
syntax enable

" Installation check.
NeoBundleCheck

" }}}

" Basic Settings {{{

"" Release keymappings for plug-in.
nnoremap ; <Nop>
xnoremap ; <Nop>
nnoremap m <Nop>
xnoremap m <Nop>
nnoremap , <Nop>
xnoremap , <Nop>

"" Editing .vimrc
nnoremap <Space>ev :tabnew $HOME/.dotfiles/.vimrc<CR>

"" Reload .vimrc
nnoremap <Space>rv :source $HOME/.vimrc<CR>

"" Call help
nnoremap ,h :<C-u>help<Space>
nnoremap ,hh :<C-u>help<Space><C-r><C-w><CR>

"" Don't create swp file
set nowritebackup
set nobackup
set noswapfile

"" Share clipboard for other application
set clipboard=unnamed,autoselect

"" Foldclose marker
nnoremap <Space>fc :<C-u>%foldclose<CR>

" }}}

" Move Settings {{{
:noremap k gk
:noremap j gj
:noremap gk k
:noremap gj j
:noremap <Down> gj
:noremap <Up> gk
:noremap <Space>h ^
:noremap <Space>l $
:noremap <Space>/ *
:noremap <Space>m %
:noremap ; :
:noremap : ;
" }}}

" Apperance Settings {{{
"" Show column number
set number
"" Show cousor line
set cursorline
"" Long text
set wrap
set textwidth=0
set colorcolumn=120
"" Invisible stirng
set list
set listchars=tab:»-,extends:»,precedes:«,nbsp:%,eol:$

"" Colors
set t_Co=256
set background=dark
colorscheme hybrid
" }}}

" Edit Settings"{{{

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

" Auto change current directory to file open
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Round indent to multipul of shiftwidth
set shiftround

" Don't unload buffer when it is abandones
set hidden

" New load buffer is use open
set switchbuf=useopen

" Smart insert tab setting.
set smarttab

" Excahnge tab to space.
set expandtab

" Auto insert indent.
set autoindent

" Round indent by shiftwidth.
set shiftwidth=4
set shiftround

" Space insert by autoindent
set tabstop=4
set scrolloff=20

" Format keybind
nnoremap <Space>fm gg=G

" Browser reload(firefox)
nnoremap <silent> <C-e> :w<Bar>VimProcBang /usr/local/bin/autoreload.sh<CR>

" Change tab width
nnoremap <silent> [Space]t2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> [Space]t4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> [Space]t8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>
"}}}

" Encode Settings {{{
"" File encoding
set encoding=utf-8

"" Tab setting for file type
augroup MyAutocmd
    autocmd BufNewFile,BufRead *.rhtml set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.scala set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb    set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.erb    set tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.c    set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.cpp  set tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.h    set tabstop=4 shiftwidth=4
augroup END
" }}}

" Window Settings {{{
"" Splitting a window will put the new window below the current one.
set splitbelow
"" Splitting a window will put the new window right the current one.
set splitright
"" Set minimal width for current window.
set winwidth=30
"" Set minimal height for current window.
set winheight=1
"" Set maximam maximam command line window.
set cmdwinheight=5
"" No equal window size.
set noequalalways
"" Adjust window size of preview and help.
set previewheight=8
set helpheight=12

" Move window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Change window size
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>
" }}}

" Search Settings {{{
" Ignore case is search patterns
set ignorecase

" No ignore case when pattern has uppercase
set smartcase

" Search is incremental search
set incsearch

" Show search result highlight
set hlsearch

" Search yank string
nnoremap <Space>sy /<C-r>"<CR>
"" Search of under cousor
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" Move cousor for search work of center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Auto Escape
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" }}}

" Plugin Settings:"{{{

" unite"{{{
" Settings
let g:unite_enable_start_insert=1
let g:unite_winheight = 20
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
let g:unite_split_rule = 'topleft'

" keymap
" Prefix key.
nnoremap [unite] <Nop>
nmap <Space>u [unite]

nnoremap <silent> [unite]b 
            \ :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f 
            \ :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]r 
            \ :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]u 
            \ :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> [unite]a 
            \ :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]y 
            \ :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]g
            \ :<C-u>Unite grep -buffer-name=search -auto-preview -no-quit -no-empty -resume<CR>
nnoremap <silent> [unite]m 
            \ :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]a 
            \ :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file
            \  <CR>u FileType unite nnoremap <silent> <buffer> <expr> 
            \  <C-j> unite#do_action('split')

augroup MyAutocmd
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> q 
    autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
augroup END
"}}}

" unite-outline"{{{
" setting
let g:unite_split_rule = 'botright'
" keymap
nnoremap <silent> [unite]o :Unite -vertical -no-quit -winwidth=35 outline<Return>
"}}}

" vimfiler"{{{
" Settings
let g:vimfiler_enable_clipboard = 0
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_as_default_explorer = 1

" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = ' '
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'

" Keymap
nnoremap <silent> <Space>ff :<C-u>VimFiler -find -quit<CR>
" nnoremap <silent> <Space>fe
"            \ :<C-u>VimFilerExplorer -split -winwidth=35 -simple -no-quit<CR>
nnoremap <silent> <Space>fe
            \ :<C-u>VimFilerExplorer -winwidth=35<CR>
autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
    nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
    nnoremap <buffer>s :call vimfiler#mappings#do_action('my_split')<Cr>
    nnoremap <buffer>v :call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
    wincmd p
    exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', s:my_action)

let s:my_action = { 'is_selectable' : 1 }                     
function! s:my_action.func(candidates)
    wincmd p
    exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', s:my_action)
" }}}

" neocomplate"{{{
" setting
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

" Keymap
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR>  pumvisible() ? neocomplete#close_popup() : "<CR>"
inoremap <expr><C-e> neocomplete#close_popup()
"}}}

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

" vim:set foldmethod=marker:
