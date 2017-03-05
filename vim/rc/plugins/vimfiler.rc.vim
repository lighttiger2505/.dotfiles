
" Settings
let g:vimfiler_enable_clipboard = 0
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_as_default_explorer = 1

" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = ' '
let g:vimfiler_readonly_file_icon = 'X'
let g:vimfiler_marked_file_icon = '*'

" Keymap

" Open standerd filer
nnoremap <silent> <Space>ff :<C-u>VimFiler -find -quit<CR>
"" Open file explorer
nnoremap <silent> <Space>fe
            \ :<C-u>VimFilerExplorer -winwidth=35<CR>
"" Show opend file on the file explorer
nnoremap <silent> <Space>fo
            \ :<C-u>VimFilerExplorer -winwidth=35 -find<CR>
autocmd! FileType vimfiler call g:my_vimfiler_settings()

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
    wincmd p
    exec 'split '. a:candidates[0].action__path
endfunction

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
    wincmd p
    exec 'vsplit '. a:candidates[0].action__path
endfunction
