if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/rc/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if !has('vim_starting') && dein#check_install()
  " Installation check.
  call dein#install()
endif

filetype plugin indent on
syntax enable
