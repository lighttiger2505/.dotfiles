function! s:source_rc(path) abort 
  let l:abspath = resolve(expand('~/.vim/rc/' . a:path))
  execute 'source' fnameescape(l:abspath)
endfunction

call s:source_rc('mappings.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('filetype.rc.vim')
call s:source_rc('autocmd.rc.vim')

call plug#begin('~/.local/share/nvim/coc')

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Load python
if isdirectory(expand($PYENV_PATH))
    let g:python_host_prog = $PYENV_PATH . '/versions/neovim2/bin/python'
    let g:python3_host_prog = $PYENV_PATH . '/versions/neovim3/bin/python'
endif
if isdirectory(expand($ANYENV_PATH))
    let g:python_host_prog = $ANYENV_PATH . '/envs/pyenv/versions/neovim2/bin/python'
    let g:python3_host_prog = $ANYENV_PATH . '/envs/pyenv/versions/neovim3/bin/python'
endif

call s:source_rc('plugins/coc.rc.vim')

" magic word after
filetype plugin indent on
syntax enable
