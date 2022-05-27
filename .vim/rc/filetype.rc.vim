" Tab setting for file type
augroup FileTabStop
    autocmd!
    autocmd FileType html setlocal tabstop=2 shiftwidth=2
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
    autocmd FileType typescript setlocal tabstop=2 shiftwidth=2
    autocmd FileType typescriptreact setlocal tabstop=2 shiftwidth=2
    autocmd FileType css setlocal tabstop=2 shiftwidth=2
    autocmd FileType scss setlocal tabstop=2 shiftwidth=2
    autocmd FileType markdown setlocal tabstop=4 shiftwidth=4
    autocmd FileType scala setlocal tabstop=4 shiftwidth=4
    autocmd FileType vim setlocal tabstop=4 shiftwidth=4
    autocmd FileType make setlocal noexpandtab
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
    autocmd FileType json setlocal tabstop=2 shiftwidth=2
    autocmd FileType toml setlocal tabstop=4 shiftwidth=4
    autocmd FileType template setlocal tabstop=4 shiftwidth=4
    autocmd FileType terraform setlocal tabstop=2 shiftwidth=2
augroup END

augroup TransFileType
    autocmd BufRead,BufNewFile .envrc setlocal filetype=sh
augroup END

augroup DisableMarkdownConceal
    autocmd!
    autocmd FileType markdown setlocal conceallevel=0
augroup END

augroup MyGitSpellCheck
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType NeogitCommitMessage setlocal spell
augroup END

augroup MarkdownErrSyntax
  autocmd!
  autocmd FileType markdown syntax match markdownError '\w\@<=\w\@='
augroup END
