nmap [gina] <Nop>
map <leader>g [gina]

nnoremap <silent> [gina]s :<C-u>Gina status --opener=vsplit<CR>
nnoremap <silent> [gina]d :<C-u>Gina compare<CR>
nnoremap <silent> [gina]l :<C-u>Gina blame<CR>

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
    \ ':call gina#action#call(''show:commit'')<CR>',
    \ {'noremap': 1, 'silent': 1},
    \)
call gina#custom#mapping#nmap(
    \ 'blame', 'c',
    \ ':call gina#action#call(''compare'')<CR>',
    \ {'noremap': 1, 'silent': 1},
    \)
