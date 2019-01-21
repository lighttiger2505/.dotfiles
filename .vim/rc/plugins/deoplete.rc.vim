" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "<C-p>" : "<C-h>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."<C-h>"
inoremap <expr><C-g> deoplete#undo_comcletion()

" <C-l>: redraw candidates
inoremap <expr><C-l> deoplete#refresh()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

inoremap <expr><CR>  pumvisible() ? deoplete#close_popup() : "<CR>"

inoremap <expr> '  pumvisible() ? deoplete#close_popup() : "'"

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
\ 'auto_complete_delay': 20,
\ 'auto_refresh_delay': 20,
\ 'refresh_always': v:true,
\ 'smart_case': v:true,
\ 'camel_case': v:true,
\ })

call deoplete#custom#option('keyword_patterns', {
\ '_': '[a-zA-Z_]\k*',
\ 'tex': '\\?[a-zA-Z_]\w*',
\ 'ruby': '[a-zA-Z_]\w*[!?]?',
\})


call deoplete#custom#source('omni', 'functions', {
\ 'ruby':  'rubycomplete#Complete',
\ 'javascript': ['tern#Complete', 'jspc#omni']
\})

" Hidden autocomplete preview
set completeopt-=preview

" Order deoplete source
call deoplete#custom#source('buffer', 'rank', 1)
call deoplete#custom#source('around', 'rank', 2)
" call deoplete#custom#source('tag', 'rank', 1)
" call deoplete#custom#source('file', 'rank', 1)
" call deoplete#custom#source('dictionary', 'rank', 1)

" Custom deoplete source for LanguageClient-neovim
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 1)

" Debugging deoplete
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
