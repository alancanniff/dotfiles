function! my_utils#Monotone_Mods() abort
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
    highlight Fixme cterm=bold,italic ctermfg=58 gui=bold,italic guifg=Orange4
endfunction          
 
function! my_utils#Make_Directory(path)
    if !isdirectory(a:path)
        call mkdir(a:path, "p", 0700)
    endif
endfunction

function my_utils#Trim_Whitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction    

function! my_utils#Copy_Generic(arg)

    if a:arg ==# "full"
        let @+ = expand("%")
    endif
    
endf


