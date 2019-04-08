
set visualbell                              " Use visual bell instead of beeping when doing something wrong
set t_vb=
if has("autocmd")

" group the commands so they are cleared when you re-source the vimrc file.
augroup aug_gvim
    autocmd!
    autocmd GUIEnter * simalt ~x
augroup END
