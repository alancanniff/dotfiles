if !exists("g:loaded_neomake")
    finish
endif

" Neomake {{{ "
    
    call neomake#configure#automake('w')                    " When writing a buffer (no delay).
    let g:neomake_open_list = 2                             " don't open the location list by default  - set to 2 if you want to changes this
    let g:neomake_logfile = g:my_cache_vim.'/neomake.log'

    " Neomake - VHDL {{{ "
 
        " ../../compiler/rsim.vim 
        " ../../compiler/vcom.vim 

    " }}} VHDL "
    " Neomake - Python {{{ "
         
        " I've set the env var PYLINTHOME to .cache/pylint.d to set the location of the stats file

        let g:neomake_flake8_args = ['--config', g:my_config_vim.'/flake8.ini']
        let g:neomake_pylama_args = ['-o', g:my_config_vim.'/pylama.ini']

        let g:neomake_python_enabled_makers = ['pylama']

    " }}} Python "

" }}} Neomake "
