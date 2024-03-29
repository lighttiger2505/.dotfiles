let g:deoplete#enable_at_startup = 1

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
\ 'min_pattern_length': 1,
\ 'auto_complete_delay': 0,
\ 'auto_refresh_delay': 20,
\ 'refresh_always': v:true,
\ 'smart_case': v:true,
\ 'camel_case': v:true,
\ })

" Hidden autocomplete preview
set completeopt-=preview

" Disable sources
call deoplete#custom#option('ignore_sources', {'_': ['around', 'look']})

" Change snippet sort order
call deoplete#custom#source('ultisnips', 'rank', 9999)

call deoplete#custom#option('keyword_patterns', {
\ 'sql': '[a-zA-Z_`]\k*',
\})

" Set lsp complete sources
let s:use_lsp_sources = ['ultisnips', 'lsp', 'dictionary', 'file']
let s:use_lsp_sources_without_snip = ['lsp', 'buffer']
call deoplete#custom#option('sources', {
\ 'go': s:use_lsp_sources,
\ 'python': s:use_lsp_sources,
\ 'c': s:use_lsp_sources,
\ 'cpp': s:use_lsp_sources,
\ 'vue': s:use_lsp_sources,
\ 'typescript': s:use_lsp_sources,
\ 'sql': s:use_lsp_sources_without_snip,
\ 'denite-filter': ['denite'],
\ 'vim': ['ultisnips', 'vim', 'buffer', 'dictionary', 'file'],
\ 'markdown': ['buffer', 'dictionary', 'file', 'look'],
\})

" call deoplete#enable_logging('DEBUG', expand('~/deoplete.log'))
" let g:deoplete#sources#vim_lsp#log = expand('~/deoplete-vim-lsp.log')
