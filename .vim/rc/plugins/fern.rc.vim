nnoremap <silent> <Leader>tt :<C-u>Fern . -drawer -toggle<CR>
nnoremap <silent> <Leader>tf :<C-u>FernDo :<CR>
nnoremap <silent> <Leader>ft :<C-u>Fern .<CR>
nnoremap <silent> <Leader>ff :<C-u>Fern %:p:h<CR>

let g:fern#renderer = "nerdfont"
let g:fern#drawer_width = 40
let g:fern#drawer_keep = v:true
let g:fern#default_hidden = 1

function! s:fern_settings() abort
    nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
    nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
    nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
    nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
    autocmd!
    autocmd FileType fern call s:fern_settings()
augroup END
