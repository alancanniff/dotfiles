autocmd BufRead,BufNewFile * if expand('%:t') == 'SConscript' | set filetype=python | endif
