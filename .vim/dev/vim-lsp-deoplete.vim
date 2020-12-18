function! s:source_rc(path) abort 
  let l:abspath = resolve(expand('~/.vim/rc/' . a:path))
  execute 'source' fnameescape(l:abspath)
endfunction

if isdirectory(expand($PYENV_PATH))
    let g:python_host_prog = $PYENV_PATH . '/versions/neovim2/bin/python'
    let g:python3_host_prog = $PYENV_PATH . '/versions/neovim3/bin/python'
endif
if isdirectory(expand($ANYENV_PATH))
    let g:python_host_prog = $ANYENV_PATH . '/envs/pyenv/versions/neovim2/bin/python'
    let g:python3_host_prog = $ANYENV_PATH . '/envs/pyenv/versions/neovim3/bin/python'
endif

call s:source_rc('mappings.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('filetype.rc.vim')
call s:source_rc('autocmd.rc.vim')

call plug#begin('~/.local/share/nvim/vim-lsp-deoplete')

Plug 'prabirshrestha/vim-lsp'
" Plug 'Shougo/deoplete.nvim'
" Plug 'lighttiger2505/deoplete-vim-lsp'

call plug#end()

set runtimepath^=$HOME/dev/src/github.com/Shougo/deoplete.nvim
set runtimepath^=$HOME/dev/src/github.com/lighttiger2505/deoplete-vim-lsp
set runtimepath^=$HOME/dev/src/github.com/lighttiger2505/sqls.vim

call s:source_rc('plugins/deoplete.rc.vim')
call deoplete#enable_logging('DEBUG', expand('~/deoplete.log'))
let g:deoplete#sources#vim_lsp#log = expand('~/deoplete-vim-lsp.log')

call s:source_rc('plugins/lsp.rc.vim')
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

filetype plugin indent on
syntax enable
