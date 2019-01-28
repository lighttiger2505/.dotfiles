let g:lightline = {
    \ 'colorscheme': 'iceberg',
    \ 'active': {
    \   'left':  [ ['mode', 'paste'], ['readonly', 'myfilename', 'modified'], ],
    \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'ale_ok', 'ale_warning', 'ale_error', 'char_code', 'fileformat', 'fileencoding', 'filetype' ], ],
    \ },
    \ 'component_function': {
    \   'myfilename': 'LightlineFilename',
    \ },
    \ 'component_expand': {
    \   'ale_error':   'LightlineAleError',
    \   'ale_warning': 'LightlineAleWarning',
    \   'ale_ok':      'LightlineAleOk',
    \ },
    \ 'component_type': {
    \   'ale_error':   'error',
    \   'ale_warning': 'warning',
    \   'ale_ok':      'ok',
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \ }

function! LightlineFilename()
    return ('' != expand('%') ? expand('%') : '[No Name]')
endfunction

function! LightlineAleError() abort
  return s:ale_string(0)
endfunction

function! LightlineAleWarning() abort
  return s:ale_string(1)
endfunction

function! LightlineAleOk() abort
  return s:ale_string(2)
endfunction

function! s:ale_string(mode)
  if !exists('g:ale_buffer_info')
    return ''
  endif

  let l:buffer = bufnr('%')
  let l:counts = ale#statusline#Count(l:buffer)
  let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format

  if a:mode == 0 " Error
    let l:errors = l:counts.error + l:counts.style_error
    return l:errors ? printf(l:error_format, l:errors) : ''
  elseif a:mode == 1 " Warning
    let l:warnings = l:counts.warning + l:counts.style_warning
    return l:warnings ? printf(l:warning_format, l:warnings) : ''
  endif

  return l:counts.total ? '' : l:no_errors
endfunction

augroup LightLineOnALE
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END

" tabline settings
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#unnamed      = '[No Name]'

" tabline keymapping
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
