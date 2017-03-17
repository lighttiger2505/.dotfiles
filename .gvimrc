
" Basic setting
set visualbell

set lines=40
set columns=120
colorscheme badwolf

if has('win16') || has('win32') || has('win64')
    " Windows
elseif has('mac')
    " Mac
    set guifont=Inconsolata-g_for_Powerline:h14
else
    " linux
    set guifont="Inconsolata-g_for_Powerline\ 14"
endif

