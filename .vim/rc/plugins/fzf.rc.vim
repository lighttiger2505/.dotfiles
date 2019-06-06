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
