let g:caw_integrated_plugin = 'ts_context_commentstring'

nmap <silent> <expr> <Leader>cc <SID>caw_hatpos_toggle()
xmap <silent> <expr> <Leader>cc <SID>caw_hatpos_toggle()
nmap <silent> <expr> <Leader>cw <SID>caw_wrap_toggle()
xmap <silent> <expr> <Leader>cw <SID>caw_wrap_toggle()

function! s:caw_hatpos_toggle() abort
  if dein#tap('nvim-ts-context-commentstring')
    lua require('ts_context_commentstring.internal').update_commentstring()
    call caw#update_comments_from_commentstring(&commentstring)
  endif
  return "\<Plug>(caw:hatpos:toggle)"
endfunction

function! s:caw_wrap_toggle() abort
  if dein#tap('nvim-ts-context-commentstring')
    lua require('ts_context_commentstring.internal').update_commentstring()
    call caw#update_comments_from_commentstring(&commentstring)
  endif
  let b:caw_wrap_oneline_comment = ['/*', '*/']
  return "\<Plug>(caw:wrap:toggle)"
endfunction
