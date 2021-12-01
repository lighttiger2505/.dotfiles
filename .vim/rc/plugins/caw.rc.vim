lua << EOF
require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true,
  }
}
EOF

let g:caw_integrated_plugin = 'ts_context_commentstring'

nmap <silent> <expr> <Leader>c <SID>caw_hatpos_toggle()
xmap <silent> <expr> <Leader>c <SID>caw_hatpos_toggle()
nmap <silent> <expr> <Leader>, <SID>caw_wrap_toggle()
xmap <silent> <expr> <Leader>, <SID>caw_wrap_toggle()

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

  " jsx
  if index(['typescript','typescriptreact'], &filetype) >= 0 && &commentstring !=# '{/* %s */}'
    let b:caw_wrap_oneline_comment = ['/*', '*/']
  endif

  return "\<Plug>(caw:wrap:toggle)"
endfunction
