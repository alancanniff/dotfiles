setlocal tabstop=4                               " The width of a hard tabstop measured in spaces
setlocal softtabstop=4                           " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
setlocal shiftwidth=4                            " size of indent
setlocal expandtab                               " uses spaces instead of tab
let b:undo_ftplugin = 'setlocal expandtab< shiftwidth< softtabstop< tabstop<'

