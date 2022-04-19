setlocal comments=b:--
setlocal commentstring=--%s
setlocal tagcase=ignore
setlocal colorcolumn=120
setlocal path=.,**
setlocal suffixesadd=.vhd,.vhdl,.v,.sv
setlocal isfname-=.

augroup au_vhdl
    autocmd!
    autocmd BufLeave *.vhd,*.vhdl, :setlocal isfname+=.
augroup END

let g:vhdl_indent_genportmap = 0
let g:vhdl_indent_rhsassign = 0
let b:undo_ftplugin = "setlocal suffixesadd< path< fileformat< commentstring< tagcase< colorcolumn<"

