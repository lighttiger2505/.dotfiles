
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

" Release keymappings for plug-in.
nnoremap ; <Nop>
xnoremap ; <Nop>
nnoremap m <Nop>
xnoremap m <Nop>
nnoremap , <Nop>
xnoremap , <Nop>

" Editing .vimrc
nnoremap <Space>ev :tabnew $HOME/.dotfiles/.vimrc<CR>

" Reload .vimrc
nnoremap <Space>rv :source $HOME/.vimrc<CR>

" Call help
nnoremap ,h :<C-u>help<Space>
nnoremap ,hh :<C-u>help<Space><C-r><C-w><CR>

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
nnoremap <silent> <Space>cd :<C-u>CD<CR>

" Format keybind
nnoremap <Space>fm gg=G

" Browser reload(firefox)
nnoremap <silent> <C-e> :w<Bar>VimProcBang /usr/local/bin/autoreload.sh<CR>

" Change tab width
nnoremap <silent> ts2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> ts4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> ts8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>

" Move window
nnoremap <Space>h <C-w>h
nnoremap <Space>j <C-w>j
nnoremap <Space>k <C-w>k
nnoremap <Space>l <C-w>l

" Change window size
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

