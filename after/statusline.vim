if exists("g:loaded_lightline")
    finish
endif

if !exists("g:loaded_airline")
    finish
endif
 
" Statusline {{{  "

set ruler                                   " show the ruler 
set statusline=                             " clear the statusline for when vimrc is reloaded
set statusline+=%f\                         " file name
set statusline+=%h%m%r%w                    " flags
set statusline+=[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&fileformat}]             " file format
set statusline+=%=
set statusline+=%10((%l/%L,%c)%)\           " line and column
set statusline+=%P\                         " percentage of file
hi StatusLine gui=NONE
hi StatusLineNC gui=NONE
'%<${ repeat("─", winwidth(0)) }>'
" https://github.com/ralismark/vimfiles
let &statusline = '%f%h%m%r%w '. repeat("\u2014", winwidth(0)-40) 

" }}} Statusline "
