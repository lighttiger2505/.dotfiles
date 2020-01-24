let g:lightline = {
    \ 'colorscheme': 'iceberg',
    \ 'active': {
    \   'left':  [ ['mode', 'paste'], ['readonly', 'myfilename', 'method', 'modified'], ],
    \   'right': [ [ 'lineinfo' ], [ 'percent' ], ['char_code', 'fileformat', 'fileencoding', 'filetype' ], ],
    \ },
    \ 'component_function': {
    \   'myfilename': 'LightlineFilename',
    \   'method': 'NearestMethodOrFunction',
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \ }

function! LightlineFilename()
    return ('' != expand('%') ? expand('%') : '[No Name]')
endfunction

function! NearestMethodOrFunction() abort
    let l:func_name = get(b:, 'vista_nearest_method_or_function', '')
    if l:func_name != ''
        return ' ' . l:func_name
    endif
    return ''
endfunction

augroup LightLineOnVista
    autocmd!
    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
augroup END
