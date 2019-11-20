if exists('g:GuiLoaded')

    function! Toggle_Fullscreen()
        if g:GuiWindowFullScreen 
            call GuiWindowFullScreen(0)
        else
            call GuiWindowFullScreen(1)
        endif
    endfunction

    nnoremap <silent> <A-x> :call Toggle_Fullscreen()<CR>

    GuiTabline 0
    GuiPopupmenu 0
    GuiFont! Consolas NF:h11
endif

if exists('g:fvim_loaded')
    " good old 'set guifont' compatibility
    "set guifont=Iosevka\ Slab:h16
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

set novisualbell 
