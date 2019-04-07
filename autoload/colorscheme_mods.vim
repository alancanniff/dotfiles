function! colorscheme_mods#MyMonotone() abort
    if exists("g:colors_name")
        if g:colors_name =~? 'monotone'
            highlight Todo ctermfg=58
            highlight Todo guifg=Orange4
            highlight statusline cterm=none
            highlight statusline ctermbg=236
            highlight statusline gui=none
            highlight statusline guibg=#303030
            highlight statuslinenc cterm=none
            highlight statuslinenc ctermbg=236
            highlight statuslinenc gui=none
            highlight statuslinenc guibg=#303030
            " make the vert split and statusline a unified color, different from background
            "highlight vertsplit guibg=#303030
            highlight vertsplit guifg=#303030
            "highlight vertsplit ctermbg=236
            highlight vertsplit ctermfg=236
            " change the color of the cursor columns
            highlight CursorColumn guibg=grey15
            highlight CursorLine guibg=grey15
            highlight CursorColumn ctermbg=235
            highlight CursorLine ctermbg=235
        endif
    endif
endfunction          
