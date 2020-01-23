" Save last cursor position
augroup LastPosition
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

" Show quickfix after grepcmd
augroup GrepCmd
    autocmd!
    autocmd QuickFixCmdPost vim,grep,make if len(getqflist()) != 0 | cwindow | endif
augroup END

" Save undo history
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  augroup vimrc-undofile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

" Reload files modified by other processes
augroup vimrc-checktime
    autocmd!
    autocmd InsertEnter,WinEnter * checktime
augroup END

" IME control for fcitx
if has('unix') && executable('fcitx-remote')
    let g:input_toggle = 0

    function! Fcitx2en()
        let s:input_status = system("fcitx-remote")
        if s:input_status == 2
            let g:input_toggle = 1
            let l:a = system("fcitx-remote -c")
        endif
    endfunction

    function! Fcitx2zh()
        let s:input_status = system("fcitx-remote")
        if s:input_status != 2 && g:input_toggle == 1
            let l:a = system("fcitx-remote -o")
            let g:input_toggle = 0
        endif
    endfunction

    augroup FixtxIMEControl
        autocmd!
        "Leave Insert mode
        autocmd InsertLeave * call Fcitx2en()
        "Enter Insert mode
        autocmd InsertEnter * call Fcitx2zh()
    augroup END
endif

" https://vi.stackexchange.com/questions/10292/how-to-close-and-and-delete-terminal-buffer-if-programs-exited
if has('nvim')
    " Get the exit status from a terminal buffer by looking for a line near the end
    " of the buffer with the format, '[Process exited ?]'.
    func! s:getExitStatus() abort
    let ln = line('$')
    " The terminal buffer includes several empty lines after the 'Process exited'
    " line that need to be skipped over.
    while ln >= 1
        let l = getline(ln)
        let ln -= 1
        let exitCode = substitute(l, '^\[Process exited \([0-9]\+\)\]$', '\1', '')
        if l != '' && l == exitCode
        " The pattern did not match, and the line was not empty. It looks like
        " there is no process exit message in this buffer.
        break
        elseif exitCode != ''
        return str2nr(exitCode)
        endif
    endwhile
    throw 'Could not determine exit status for buffer, ' . expand('%')
    endfunc

    func! s:afterTermClose() abort
    if s:getExitStatus() == 0
        bdelete!
    endif
    endfunc

    augroup NeoVimTerminal
        autocmd!
        autocmd TermOpen * setlocal norelativenumber
        autocmd TermOpen * setlocal nonumber
        " autocmd TermClose * call timer_start(20, { -> s:afterTermClose() })
    augroup END
endif

augroup TransparentBG
    autocmd!
    autocmd Colorscheme * highlight Normal ctermbg=none
    autocmd Colorscheme * highlight NonText ctermbg=none
    autocmd Colorscheme * highlight LineNr ctermbg=none
    autocmd Colorscheme * highlight Folded ctermbg=none
    autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
augroup END
