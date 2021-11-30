let g:lightline = {
    \ 'colorscheme': 'iceberg',
    \ 'active': {
    \   'left':  [
    \      ['mode', 'paste'],
    \      ['readonly', 'myfilename', 'method', 'modified'],
    \      ['lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok'],
    \      ['lsp_status'],
    \   ],
    \   'right': [
    \      ['lineinfo'],
    \      ['percent'],
    \      ['char_code', 'fileformat', 'fileencoding', 'filetype' ],
    \   ],
    \ },
    \ 'tabline': {
    \   'left':  [ ['cwd'], ['tabs'] ],
    \   'right': [ ['close'] ],
    \ },
    \ 'component_function': {
    \   'myfilename': 'LightlineFilename',
    \   'cwd': 'getcwd',
    \   'method': 'NearestMethodOrFunction',
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \ }

function! LightlineFilename()
    return ('' != expand('%') ? expand('%') : '[No Name]')
endfunction
