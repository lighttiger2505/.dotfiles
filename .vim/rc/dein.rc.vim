if &compatible
  set nocompatible
endif

let s:token_file = expand("$HOME/.vim/secrets/dein_token.vim")
if filereadable(s:token_file)
    execute 'source ' . s:token_file
endif

let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
    call mkdir($CACHE, 'p')
endif

let s:dein_runtime_dir = finddir('dein.vim', '.;')
let s:cache_dein_dir = expand('$CACHE/dein')

if s:dein_runtime_dir !=# '' || &runtimepath !~# '/dein.vim'
  if s:dein_runtime_dir ==# '' && &runtimepath !~# '/dein.vim'
    let s:dein_runtime_dir = s:cache_dein_dir . '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_runtime_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_runtime_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_runtime_dir, ':p') , '/$', '', '')
endif

if !dein#load_state(s:cache_dein_dir)
  finish
endif

call dein#begin(s:cache_dein_dir)

call dein#load_toml('~/.vim/rc/dein.toml',          {'lazy': 0})
call dein#load_toml('~/.vim/rc/dein_lazy.toml',     {'lazy': 1})
call dein#load_toml('~/.vim/rc/dein_syntax.toml',   {'lazy': 1})
call dein#load_toml('~/.vim/rc/dein_go.toml',       {'lazy': 1})
call dein#load_toml('~/.vim/rc/dein_cmp.toml',      {'lazy': 1})
call dein#load_toml('~/.vim/rc/dein_nvim_lsp.toml', {'lazy': 0})

call dein#end()
call dein#save_state()
