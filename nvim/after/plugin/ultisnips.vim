if !exists('did_plugin_ultisnips')
    finish
endif

" Ultisnips {{{ "
    let g:my_config_ultisnips = expand(stdpath('config')).'/UltiSnips'
    call my_utils#Make_Directory(g:my_config_ultisnips)

    let g:UltiSnipsExpandTrigger="<tab>"                    " this is the default - tab expands snippet (<c-j> goes to next field
    let g:UltiSnipsSnippetsDir=g:my_config_ultisnips
    let g:UltiSnipsEditSplit="horizontal"                   " show this snippet file in a horizontal split
" }}} Ultisnips "
