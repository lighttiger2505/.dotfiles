if &compatible
  set nocompatible
endif

let s:token_file = expand("$HOME/.vim/secrets/dein_token.vim")
if filereadable(s:token_file)
    execute 'source ' . s:token_file
endif

let $CACHE = expand('~/.cache')
if !isdirectory(expand($CACHE))
    call mkdir(expand($CACHE), 'p')
endif

let s:dein_runtime_dir = finddir('dein.vim', '.;')
if s:dein_runtime_dir !=# '' || &runtimepath !~# '/dein.vim'
  if s:dein_runtime_dir ==# '' && &runtimepath !~# '/dein.vim'
    let s:dein_runtime_dir = expand('$CACHE/dein')
          \. '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_runtime_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_runtime_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_runtime_dir, ':p') , '/$', '', '')
endif

let s:dein_plugin_dir = expand("$CACHE/dein")
if !dein#load_state(s:dein_plugin_dir)
  finish
endif

call dein#begin(s:dein_plugin_dir)

call dein#load_toml('~/.vim/rc/dein.toml',          {'lazy': 0})
call dein#load_toml('~/.vim/rc/dein_lazy.toml',     {'lazy': 1})
call dein#load_toml('~/.vim/rc/dein_syntax.toml',   {'lazy': 1})
call dein#load_toml('~/.vim/rc/dein_python.toml',   {'lazy': 1})
call dein#load_toml('~/.vim/rc/dein_go.toml',       {'lazy': 1})

if g:dot_vim_lsp
    call dein#load_toml('~/.vim/rc/dein_vim_lsp.toml', {'lazy': 1})
endif
if g:dot_deoplete
    call dein#load_toml('~/.vim/rc/dein_deoplete.toml', {'lazy': 0})
endif
if g:dot_coc
    call dein#load_toml('~/.vim/rc/dein_coc.toml', {'lazy': 0})
endif
if g:dot_compe
    call dein#load_toml('~/.vim/rc/dein_compe.toml', {'lazy': 0})
endif

call dein#end()
call dein#save_state()
