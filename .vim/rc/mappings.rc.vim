
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
