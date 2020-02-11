" Change leader mapping
let g:mapleader = ','
let g:maplocalleader = '\'

" Ctrl + c = ESC for rectangle selection
inoremap <C-c> <ESC>

" Switch colon and semicolon
noremap ; :
noremap : ;

" Multi line move
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> gk k
noremap <silent> gj j

" Skip move
noremap H <Nop>
noremap L <Nop>
noremap H ^
noremap L $

" Insert mode move
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>

" Change tab width
nnoremap <silent> ts2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> ts4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> ts8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>

" " The prefix key of tab.
" nnoremap [tab] <Nop>
" nmap t [tab]

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
inoremap <C-r><C-r> <C-r>0
cnoremap <C-r><C-r> <C-r>0

" Paste clipboard text
nnoremap <Space>b "*p
vnoremap <Space>b "*p

" Shortcut of write
nnoremap <silent> <Space>w :<C-u>w<CR>

" Jump quickfix
nnoremap <silent> <C-p> :<C-u>cp<CR>
nnoremap <silent> <C-n> :<C-u>cn<CR>
nnoremap <silent> [f :<C-u>cp<CR>
nnoremap <silent> ]f :<C-u>cn<CR>
nnoremap <silent> [F :<C-u>cfirst<CR>
nnoremap <silent> ]F :<C-u>clast<CR>

function! ToggleQuickfix()
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction
nnoremap <script> <silent> <Space>i :call ToggleQuickfix()<CR>

" Jump locationlist
nnoremap [[ :<C-u>lp<CR>
nnoremap ]] :<C-u>lne<CR>
nnoremap [T :<C-u>lfirst<CR>
nnoremap ]T :<C-u>llast<CR>

" Toggle locationlist
function! ToggleLocationlist()
    let l:nr = winnr('$')
    lwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        lclose
    endif
endfunction
nnoremap <script> <silent> <Space>l :call ToggleLocationlist()<CR>

" Clear search hi
nnoremap <silent> <Space>h :noh<CR>

" Grep astarisk text
nnoremap <Space>gg :<C-u>silent grep '<C-r>=<SID>convert_pattern(@/)<CR>'<CR>
nnoremap <Space>gl :<C-u>silent grep '<C-r>=<SID>convert_pattern(@/)<CR>' %<CR>
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
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Switch to last file
nnoremap <Space><Space> <c-^>

" Toggle relativenumber or norelativenumber
function! ToggleRelativenumber() abort
  if &relativenumber == 1
     setlocal norelativenumber
  else
     setlocal relativenumber
  endif
endfunction
nnoremap <silent> <Space>n :call ToggleRelativenumber()<cr>

" Toggle wrap or nowrap
function! ToggleWrap() abort
  if &wrap == 1
     setlocal nowrap
  else
     setlocal wrap
  endif
endfunction
nnoremap <silent> <Space>r :call ToggleWrap()<cr>

let s:toggle_window_fullscreen = 0
function! ToggleWindowFullSize()
  if s:toggle_window_fullscreen == 1
    exec "normal \<C-w>="
    let s:toggle_window_fullscreen = 0
  else
    exec ':resize'
    exec ':vertical resize'
    let s:toggle_window_fullscreen = 1
  endif
endfunction
nnoremap <silent> <Space>f :<C-u>call ToggleWindowFullSize()<CR>

" Trailing whitespace
nnoremap <silent> <Space>w :<C-u>%s/\s\+$//e<CR>

" Escape normal mode on terminal
tnoremap <silent> <ESC> <C-\><C-n>

" Current file tab open
nnoremap <C-w>t <C-w>T

" Move tab
nnoremap t <nop>
nnoremap tn gt
nnoremap tp gT

" Copy current file path to clipboard
function! CopyPathToClip() abort
    if executable('xclip')
        let l:cmd = "echo '" . expand('%') . "' | xclip -selection c"
        execute system(l:cmd)
    elseif executable('pbcopy')
        let l:cmd = "echo '" . expand('%') . "' | xclip -selection c"
        execute system(l:cmd)
    else
        echo 'Please install `xclip`'
    endif
endfunction
nnoremap <silent> <Space>p :<C-u>call CopyPathToClip()<CR>
