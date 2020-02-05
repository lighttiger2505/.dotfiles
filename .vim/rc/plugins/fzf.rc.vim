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
    \ 'window': 'call FloatingFZF()',
    \ }

function! FloatingFZF() abort
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')

    let fzf_win_width_percent = 0.85
    let fzf_win_height_percent = 0.7

    let width = float2nr(&columns * fzf_win_width_percent)
    let x = float2nr((&columns - (&columns * fzf_win_width_percent)) / 2)
    let height = float2nr(&lines * fzf_win_height_percent)
    let y = float2nr((&lines - (&lines * fzf_win_height_percent)) / 2)

    let opts = {
        \ 'relative': 'editor',
        \ 'row': y,
        \ 'col': x,
        \ 'width': width,
        \ 'height': height
        \ }

    call nvim_open_win(buf, v:true, opts)
endfunction

" For fzf-mru.vim options
let g:fzf_mru_relative = 1
let g:fzf_mru_no_sort = 1
