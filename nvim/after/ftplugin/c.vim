setlocal tabstop=4                               " The width of a hard tabstop measured in spaces
setlocal softtabstop=4                           " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
setlocal shiftwidth=4                            " size of indent
setlocal expandtab                               " uses spaces instead of tab
setlocal formatoptions-=ro                       " turn off auto comment
setlocal textwidth=80
let b:undo_ftplugin = 'setlocal formatoptions< expandtab< shiftwidth< softtabstop< tabstop<'

