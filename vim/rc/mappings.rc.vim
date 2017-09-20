" Editing .vimrc
nnoremap <Space>e :tabnew $HOME/.vimrc<CR>

" Reload .vimrc
nnoremap <Space>s :source $HOME/.vimrc<CR>

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

" Insert mode move
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

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
nnoremap <silent> [tab]t :<C-u>tablast <bar> tabnew<CR>
" Move tab
nnoremap <silent> [tab]h :<C-u>tabprevious<CR>
nnoremap <silent> [tab]l :<C-u>tabnext<CR>
nnoremap <silent> [tab]H :<C-u>tabfirst<CR>
nnoremap <silent> [tab]L :<C-u>tablast<CR>
nnoremap <silent> [tab]m :<C-u>tabmove<Space>
nnoremap <silent> [tab]c :<C-u>tabclose<CR>

" The prefix key of window.
nnoremap [window] <Nop>
nnoremap s <Nop>
nmap s [window]

" Split window
nnoremap <silent> [window]s :split<CR>
nnoremap <silent> [window]i :vsplit<CR>
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
" Resize window
noremap [window]> 10<C-w>>
noremap [window]< 10<C-w><
noremap [window]+ 10<C-w>+
noremap [window]- 10<C-w>-
noremap [window]= <C-w>=

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
nnoremap * *N
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Auto Escape
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" Indent keybind for shutcut
nnoremap <silent>> >>
nnoremap <silent>< <<

" Not yank is delete operation
nnoremap <Space>p "0p
vnoremap <Space>p "0p

" Move quickfix
nnoremap <C-p> :cp<CR>
nnoremap <C-n> :cn<CR>

" Toggle quickfix
if exists("g:__QUICKFIX_TOGGLE_jfklds__")
    finish
endif
let g:__QUICKFIX_TOGGLE_jfklds__ = 1

function! ToggleQuickfix()
    let nr = winnr("$")
    cwindow
    let nr2 = winnr("$")
    if nr == nr2
        cclose
    endif
endfunction
nmap <script> <silent> <Space>r :call ToggleQuickfix()<CR>

" Clear search hi
nnoremap <Space>n :noh<CR>
