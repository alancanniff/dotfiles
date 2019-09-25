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
 
set novisualbell 
