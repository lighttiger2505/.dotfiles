" Define mappings
augroup DeniteSettings
    autocmd!
    autocmd FileType denite call s:denite_my_settings()
augroup END

function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
endfunction

" Change file/rec command.
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" file/rec on git alias
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])

" " change file/old source scope
call denite#custom#source('file/old', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
call denite#custom#source('file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])

" Change denite default options
call denite#custom#option('_', {
    \ 'prompt': '$ ',
    \ 'cached_filter': v:true,
    \ 'cursor_shape': v:true,
    \ 'cursor_wrap': v:true,
    \ 'start_filter': v:true,
    \ 'statusline': v:false,
    \ 'highlight_filter_background': 'DeniteFilter',
    \ 'highlight_matched_char': 'Underlined',
    \ 'split': 'floating',
    \ })

let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7

function! s:denite_detect_size() abort
    call denite#custom#option('_', {
        \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
        \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
        \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
        \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
        \ })
endfunction
call s:denite_detect_size()

augroup denite-detect-size
    autocmd!
    autocmd VimResized * call <SID>denite_detect_size()
augroup END
