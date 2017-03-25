
" Release keymappings for plug-in.
nnoremap ; :
xnoremap : <Nop>
nnoremap m <Nop>
xnoremap m <Nop>
nnoremap , <Nop>
xnoremap , <Nop>
nnoremap q <Nop>

" Editing .vimrc
nnoremap <Space>ev :tabnew $HOME/.vimrc<CR>

" Reload .vimrc
nnoremap <Space>rv :source $HOME/.vimrc<CR>

" Foldclose marker
nnoremap <Space>fc :<C-u>%foldclose<CR>

" Multi line move
noremap k gk
noremap j gj
noremap gk k
noremap gj j
noremap <Down> gj
noremap <Up> gk

" Skip move
noremap H <Nop>
noremap L <Nop>
noremap H ^
noremap L $

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>cd %:h<CR>

" Format keybind
nnoremap <Space>fm gg=G

" Browser reload(firefox)
nnoremap <silent> <C-e> :w<Bar>VimProcBang /usr/local/bin/autoreload.sh<CR>

" Change tab width
nnoremap <silent> ts2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> ts4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> ts8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>

" The prefix key of tab.
nnoremap [tab] <Nop>
nmap t [tab]

" Jump tab '1~9'
for n in range(1, 9)
    execute 'nnoremap <silent> [tab]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" Add new tab 
nnoremap <silent> [tab]n :<C-u>tablast <bar> tabnew<CR>
" Move tab
nnoremap <silent> [tab]l :<C-u>tabnext<CR>
nnoremap <silent> [tab]h :<C-u>tabprevious<CR>

" The prefix key of window.
nnoremap [window] <Nop>
nmap <Space> [window]

" Split window
nnoremap <silent> [window]s :split<CR>
nnoremap <silent> [window]v :vsplit<CR>
" Move window
noremap [window]h <C-w>h 
noremap [window]l <C-w>l
noremap [window]j <C-w>j
noremap [window]k <C-w>k
" Switch window
noremap [window]H <C-w>H
noremap [window]L <C-w>L
noremap [window]J <C-w>J
noremap [window]K <C-w>K

" Search yank string
nnoremap <Space>sy /<C-r>"<CR>
" Search of under cousor
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" Replace cousor word"
nnoremap <expr> c* ':%s ;\<' . expand('<cword>') . '\>;'
vnoremap <expr> c* ':s ;\<' . expand('<cword>') . '\>;'

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


