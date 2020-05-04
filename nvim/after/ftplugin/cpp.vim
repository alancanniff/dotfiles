" https://vimways.org/2018/from-vimrc-to-vim/
setlocal tabstop=8                               " The width of a hard tabstop measured in spaces
setlocal softtabstop=2                           " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
setlocal shiftwidth=2                            " size of indent
setlocal expandtab                               " uses spaces instead of tab
let b:undo_ftplugin = 'setlocal expandtab< shiftwidth< softtabstop< tabstop<'

