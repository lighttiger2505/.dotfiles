
" mapping
let g:quickrun_config = {
            \   "_" : {
            \       "runner" : "vimproc",
            \       "runner/vimproc/updatetime" : 60,
            \       "outputter/buffer/split" : ":botright",
            \       "outputter/buffer/close_on_empty" : 1
            \   },
            \}

" target file
let g:quickrun_config['html'] = { 'command' : 'open', 'exec' : '%c %s', 'outputter': 'browser' }
