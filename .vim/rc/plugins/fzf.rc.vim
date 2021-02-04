let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-o': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
    \ }

let g:fzf_layout = {
    \ 'up':'~90%',
    \ 'window': {
    \     'width': 0.85,
    \     'height': 0.7,
    \     'yoffset':0.5,
    \     'xoffset': 0.5,
    \     'border': 'sharp',
    \     'highlight': 'Comment',
    \     }
    \ }

" For fzf-mru.vim options
let g:fzf_mru_relative = 1
let g:fzf_mru_no_sort = 1

" For fzf-preview.vim
let g:fzf_preview_floating_window_rate = 0.85
let g:fzf_preview_use_dev_icons = 1

nmap [fuzzyf] <Nop>
map <C-j> [fuzzyf]
nnoremap <silent> [fuzzyf]<C-p> :<C-u>FzfPreviewFromResourcesRpc project_mru git<CR>
nnoremap <silent> [fuzzyf]<C-s> :<C-u>FzfPreviewGitStatusRpc<CR>
nnoremap <silent> [fuzzyf]<C-b> :<C-u>FzfPreviewBuffersRpc<CR>
nnoremap <silent> [fuzzyf]<C-l> :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fuzzyf]<C-]> :<C-u>FzfPreviewCtagsRpc<CR>
nnoremap <silent> [fuzzyf]<C-o> :<C-u>FzfPreviewBufferTagsRpc<CR>
nnoremap <silent> [fuzzyf]<C-r> :<C-u>FzfPreviewFromResourcesRpc buffer project_mru<CR>
