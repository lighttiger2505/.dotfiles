let g:deoplete#enable_at_startup = 1

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
call deoplete#custom#option({
\ 'auto_complete': v:true,
\ 'min_pattern_length': 2,
\ 'auto_complete_delay': 0,
\ 'auto_refresh_delay': 20,
\ 'refresh_always': v:true,
\ 'smart_case': v:true,
\ 'camel_case': v:true,
\ })

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#manual_complete()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Hidden autocomplete preview
set completeopt-=preview

" Disable sources
" call deoplete#custom#option('ignore_sources', {'_': ['buffer', 'around']})

" Setting sources for using lsp per filetype
call deoplete#custom#source('LanguageClient', 'sorters', [])

" Change neosnippet sort order
call deoplete#custom#source('neosnippet', 'rank', 9999)

" Set lsp complete sources
let s:use_lsp_sources = ['neosnippet', 'lsp', 'LanguageClient', 'dictionary', 'file']
call deoplete#custom#option('sources', {
\ 'go': s:use_lsp_sources,
\ 'python': s:use_lsp_sources,
\ 'c': s:use_lsp_sources,
\ 'cpp': s:use_lsp_sources,
\ 'sql': s:use_lsp_sources,
\ 'vue': s:use_lsp_sources,
\ 'typescript': s:use_lsp_sources,
\ 'denite-filter': ['denite'],
\ 'vim': ['neosnippet', 'vim', 'buffer', 'dictionary', 'file'],
\ 'markdown': ['buffer', 'dictionary', 'file', 'look'],
\})
