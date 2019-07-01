nmap [gina] <Nop>
map <leader>g [gina]

nnoremap <silent> [gina]s :<C-u>Gina status --opener=vsplit<CR>
nnoremap <silent> [gina]d :<C-u>Gina compare<CR>
nnoremap <silent> [gina]b :<C-u>Gina blame<CR>

let g:gina#command#blame#use_default_mappings = 0
call gina#custom#mapping#nmap(
    \ 'blame', 'H',
    \ ':call gina#action#call(''blame:back'')<CR>',
    \ {'noremap': 1, 'silent': 1},
    \)
call gina#custom#mapping#nmap(
    \ 'blame', 'L',
    \ ':call gina#action#call(''blame:open'')<CR>',
    \ {'noremap': 1, 'silent': 1},
    \)
call gina#custom#mapping#nmap(
    \ 'blame', '<CR>',
    \ ':call gina#action#call(''show:commit:preview:bottom'')<CR>',
    \ {'noremap': 1, 'silent': 1},
    \)
call gina#custom#mapping#nmap(
    \ 'blame', 'd',
    \ ':call gina#action#call(''compare'')<CR>',
    \ {'noremap': 1, 'silent': 1},
    \)
