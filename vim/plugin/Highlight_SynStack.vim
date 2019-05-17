function s:Highlight_SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
endfunc

nnoremap <Plug>Highlight_SynStack :call <SID>Highlight_SynStack()<CR>

