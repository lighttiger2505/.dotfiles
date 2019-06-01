" Insert mode keymap in dein
"
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
call denite#custom#option('default', {
    \ 'start-filter': 'true',
    \ })
