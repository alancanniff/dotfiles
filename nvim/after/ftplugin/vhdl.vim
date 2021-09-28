" https://vimways.org/2018/from-vimrc-to-vim/
setlocal commentstring=--%s
setlocal tagcase=ignore
setlocal colorcolumn=120
setlocal fileformat=unix
setlocal path=.,**
setlocal suffixesadd=.vhd,.vhdl,.v,.sv
setlocal isfname-=.
let g:vhdl_indent_genportmap = 0
let g:vhdl_indent_rhsassign = 0
let b:undo_ftplugin = 'setlocal isfname< suffixesadd< path< fileformat< commentstring< tagcase< colorcolumn<'

