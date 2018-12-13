" Neomake {{{ "
    " When writing a buffer (no delay).
    call neomake#configure#automake('w')
    let g:neomake_open_list = 0  " don't open the location list by default  - set to 2 if you want to changes this
    let g:neomake_logfile = g:my_cache_vim.'/neomake.log'

    " Neomake - VHDL {{{ "
        " I've started moving this stuff into the compiler directory...

        " ** Error: src/sync_fifo_v2.vhd(76): near "begin": (vcom-1576) expecting == or '+' or '-' or '&'.
        let &errorformat =
                    \ '** %tRROR: %f(%l): %m,'.
                    \ '** %tRROR: %m,' .
                    \ '** %tARNING: %f(%l): %m,' .
                    \ '** %tARNING: %m,' .
                    \ '** %tOTE: %m,' .
                    \ '%tRROR: %f(%l): %m,' .
                    \ '%tARNING[%*[0-9]]: %f(%l): %m,' .
                    \ '%tRROR: %m,' .
                    \ '%tARNING[%*[0-9]]: %m'

        " help vcom options?
        " -modelsimini <path/modelsim.ini>
        let g:my_cache_vcom = g:my_cache_home.'/vcom'
        let g:neomake_vhdl_vcom_maker = {
                    \ 'args': [
                                \ '-2002',
                                \ '-lint',
                                \ '-check_synthesis',
                                \ '-bindAtCompile',
                                \ '-quiet',
                                \ '-work', g:my_cache_vcom
                            \ ],
                    \ 'errorformat': &errorformat,
                    \ }
        let g:neomake_vhdl_enabled_makers = ['vcom']
    " }}} VHDL "
    " Neomake - Python {{{ "
        " --append-config=APPEND_CONFIG 
        " pip install flake8
        " I've set the env var PYLINTHOME to .cache/pylint.d to set the location of the stats file
        "let g:neomake_flake8_args = ['--max-line-length=240']
        "let g:neomake_python_enable_makers = ['flake8']
    " }}} Python "

" }}} Neomake "
