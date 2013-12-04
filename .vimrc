
" キーバインド
:noremap k gk
:noremap j gj
:noremap gk k
:noremap gj j
:noremap <Down> gj
:noremap <Up> gk

" 設定ファイル操作ショートカット
:nnoremap ,ev :tabnew $HOME/.vimrc<CR>
:nnoremap ,rv :source $HOME/.vimrc<CR>

" 書式設定
:set number
:set cursorline
:set list
:set listchars=eol:¬,tab:▸\ 
:set tabstop=2
:set shiftwidth=2
:set scrolloff=20

" NeoBundle
set nocompatible
filetype off

if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
   call neobundle#rc(expand('~/.vim/bundle/'))
 endif

 " インストール対象のプラグインを指定
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'nanotech/jellybeans.vim'

 filetype plugin on
 filetype indent on

" カラースキーム適用
:colorscheme jellybeans

