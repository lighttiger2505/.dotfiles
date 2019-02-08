" key mappings
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <expr><S-TAB>  pumvisible() ? "<C-p>" : "<C-h>"
inoremap <expr><C-h> deoplete#smart_close_popup()."<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."<C-h>"
inoremap <expr><C-g> deoplete#undo_comcletion()
inoremap <expr><CR>  pumvisible() ? deoplete#close_popup() : "<CR>"
inoremap <expr> '  pumvisible() ? deoplete#close_popup() : "'"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

call deoplete#custom#source('ghc', 'sorters', ['sorter_word'])

" Use auto delimiter
call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

" Prams of deoplete
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
\ 'auto_complete_delay': 0,
\ 'auto_refresh_delay': 20,
\ 'refresh_always': v:true,
\ 'smart_case': v:true,
\ 'camel_case': v:true,
\ })

" Hidden autocomplete preview
set completeopt-=preview
