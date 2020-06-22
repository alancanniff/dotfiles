if !exists("g:loaded_neomake")
    finish
endif

" Neomake {{{ "

    call neomake#configure#automake('w')                    " When writing a buffer (no delay).
    let g:neomake_open_list = 2                             " don't open the location list by default  - set to 2 if you want to changes this
    let g:neomake_logfile = stdpath('cache').'/neomake.log'

    " the default is to disable because of lsp
    NeomakeDisable
    
    " Neomake - VHDL {{{ "
 
        " ../../compiler/rsim.vim 
        " ../../compiler/vcom.vim 

    " }}} VHDL "
    " Neomake - Python {{{ "
         
        " I've set the env var PYLINTHOME to .cache/pylint.d to set the location of the stats file

        let g:neomake_flake8_args = ['--config', stdpath('config').'/flake8.ini']
        let g:neomake_pylama_args = ['-o', stdpath('config').'/pylama.ini']

        let g:neomake_python_enabled_makers = ['flake8', 'pylama']

    " }}} Python "

    hi NeomakeVirtualtextError ctermfg=203 guifg=#f54646
" }}} Neomake "
