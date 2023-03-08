setlocal comments=b:--
setlocal commentstring=--%s
setlocal tagcase=ignore
setlocal colorcolumn=100
setlocal path=.,**
setlocal suffixesadd=.vhd,.vhdl,.v,.sv
setlocal includeexpr=substitute(v:fname,'.*\\.','','g')
setlocal spell

let g:vhdl_indent_genportmap = 1
let g:vhdl_indent_rhsassign = 0
let b:undo_ftplugin = "setlocal suffixesadd< path< fileformat< commentstring< tagcase< colorcolumn<"

