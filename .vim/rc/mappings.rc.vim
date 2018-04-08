" Change leader mapping
let g:mapleader = ','
let g:maplocalleader = '\'

" Editing .vimrc
nnoremap <Space>e :tabnew $HOME/.vimrc<CR>

" Reload .vimrc
nnoremap <Space>s :source $HOME/.vimrc<CR>

" Switch colon and semicolon
noremap ; :
noremap : ;

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
inoremap <C-d> <Del>

" Change tab width
nnoremap <silent> ts2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> ts4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> ts8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>

" The prefix key of tab.
nnoremap [tab] <Nop>
nmap t [tab]

" Disable close window
nnoremap <C-w>c <Nop>

" Resize window
noremap <C-w>> 10<C-w>>
noremap <C-w>< 10<C-w><
noremap <C-w>+ 10<C-w>+
noremap <C-w>- 10<C-w>-

" Search yank string
nnoremap <Space>sy /<C-r>"<CR>
" Search of under cousor
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" Replace cousor word"
nnoremap <expr> c* ':%s ;\<' . expand('<cword>') . '\>;'
vnoremap <expr> c* ':s ;\<' . expand('<cword>') . '\>;'

" Auto Escape
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" Indent keybind for shutcut
nnoremap <silent>> >>
nnoremap <silent>< <<

" Paste explicitly yanked text
nnoremap <Space>p "0p
vnoremap <Space>p "0p

" Paste explicitly yanked text
nnoremap <Space>p "0p
vnoremap <Space>p "0p

" Paste clipboard text
nnoremap <Space>e "*p
vnoremap <Space>e "*p

" Not yank is delete operation
nnoremap x "_x

" Jump quickfix
nnoremap [f :<C-u>cprevious<CR>
nnoremap ]f :<C-u>cnext<CR>
nnoremap [R :<C-u>cprevious<CR>
nnoremap ]R :<C-u>cnext<CR>

" Toggle quickfix
if exists('g:__QUICKFIX_TOGGLE_jfklds__')
    finish
endif
let g:__QUICKFIX_TOGGLE_jfklds__ = 1

function! ToggleQuickfix()
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction
nmap <script> <silent> <Space>f :call ToggleQuickfix()<CR>

" Jump locationlist
nnoremap [t :<C-u>lprevious<CR>
nnoremap ]t :<C-u>lnext<CR>
nnoremap [T :<C-u>lprevious<CR>
nnoremap ]T :<C-u>lnext<CR>

" Toggle locationlist
if exists('g:__LOCATIONLIST_TOGGLE_jfklds__')
    finish
endif
let g:__LOCATIONLIST_TOGGLE_jfklds__ = 1

function! ToggleLocationlist()
    let l:nr = winnr('$')
    lwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        lclose
    endif
endfunction
nmap <script> <silent> <Space>t :call ToggleLocationlist()<CR>

" Clear search hi
nnoremap <silent> <Space>h :noh<CR>

" Grep astarisk text
nnoremap <Space>gg :<C-u>grep '<C-r>=<SID>convert_pattern(@/)<CR>'<CR>
nnoremap <Space>gl :<C-u>grep '<C-r>=<SID>convert_pattern(@/)<CR>' %<CR>
function! s:convert_pattern(pat)
    let chars = split(a:pat, '\zs')
    let len = len(chars)
    let pat = ''
    let i = 0
    while i < len
        let ch = chars[i]
        if ch ==# '\'
            let nch = chars[i + 1]
            if nch =~# '[vVmM<>%]'
                let i += 1
            elseif nch ==# 'z'
                let i += 2
            elseif nch ==# '%'
                let i += 2
                let pat .= chars[i]
            else
                let pat .= ch
            endif
        else
            let pat .= ch
        endif
        let i += 1
    endwhile
    return escape(pat, '\')
endfunction

" Command line mode mapping emacs like
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
" cnoremap <C-n> <Down>
" cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" Switch to last file
nnoremap <Space><Space> <c-^>

" Rename current file
function! RenameFile() abort
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name !=# '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
noremap <Space>R :call RenameFile()<cr>

" Toggle relativenumber or norelativenumber
function! ToggleRelativenumber() abort
  if &relativenumber == 1
     setlocal norelativenumber
  else
     setlocal relativenumber
  endif
endfunction
nnoremap <silent> <Space>n :call ToggleRelativenumber()<cr>

" Move buffer
nnoremap <silent> <C-n> :<C-u>bnext<CR>
nnoremap <silent> <C-p> :<C-u>bprevious<CR>
