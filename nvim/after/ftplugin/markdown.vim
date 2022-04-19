setlocal textwidth=80
setlocal formatoptions+=t
setlocal spell
setlocal isfname-=#

augroup au_markdown
    autocmd!
    autocmd BufLeave *.md :setlocal isfname+=#
augroup END

let b:undo_ftplugin = 'setlocal formatoptions< textwidth< spell< isfname<'

