" Vim Compiler File
" Compiler: mvc
" Maintainer:   Alan Canniff
" Last Change:  2018/12/15

if exists("current_compiler")
    finish
endif
let current_compiler = "mvc"

if exists(":CompilerSet") != 2      " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim
       
" vcom  -2002  -lint  -check_synthesis  -bindAtCompile  -quiet  -f  endace_files.lst  -work work
       
let b:context_args =  [
                \ '-2002',
                \ '-lint',
                \ '-check_synthesis',
                \ '-bindAtCompile',
                \ '-quiet',
                \ '-f',
                \ 'file.lst',
                \ '-work',
                \ ]
 
let b:context_args += ['work']

let b:context_makeprg = 'vcom'
for arg in b:context_args
    let b:context_makeprg .= ' '. arg 
endfor

execute 'CompilerSet makeprg=' . escape(b:context_makeprg, ' ')

let b:context_errorformat = ''
                    \ . '** %tRROR: %f(%l): %m,'
                    \ . '** %tRROR: %m,'
                    \ . '** %tARNING: %f(%l): %m,'
                    \ . '** %tARNING: %m,'
                    \ . '** %tOTE: %m,'
                    \ . '%tRROR: %f(%l): %m,'
                    \ . '%tARNING[%*[0-9]]: %f(%l): %m,'
                    \ . '%tRROR: %m,'
                    \ . '%tARNING[%*[0-9]]: %m'
execute 'CompilerSet errorformat=' . escape(b:context_errorformat, ' ')

if g:loaded_neomake

    " let g:neomake_asciidoc_asciidoc_postprocess = { entry -> entry.type ==? 'W' ? extend(entry, {'valid': -1}) : entry}

    let g:neomake_vhdl_mvc_maker = {
                \ 'exe': 'vcom',
                \ 'args': b:context_args,
                \ 'errorformat': b:context_errorformat,
                \ }

    let g:neomake_vhdl_enabled_makers = ['mvc']

endif

let &cpo = s:cpo_save
unlet s:cpo_save     
