" key mappings
inoremap <expr><C-h> deoplete#smart_close_popup()."<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."<C-h>"

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

let b:deoplete_ignore_sources = ['around']

call deoplete#custom#option('sources', {
\ 'go': ['buffer', 'dictionary', 'file', 'lsp', 'neosnippet'],
\})
