" Vim Compiler File
" Compiler:	vcom
" Maintainer:	Alan Canniff
" Last Change:	2018/12/15

if exists("current_compiler")
    finish
endif
let current_compiler = "vcom"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim
 
let b:context_args =  [
                \ '-2002',
                \ '-lint',
                \ '-check_synthesis',
                \ '-bindAtCompile',
                \ '-quiet',
                \ '-work',
                \ ]
 
if exists("g:my_cache_vcom")
    let b:context_args += [g:my_cache_vcom]
else
    let b:context_args += ['work']
endif                   

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
    let g:neomake_vhdl_vcom_maker = {
                \ 'args': b:context_args,
                \ 'errorformat': b:context_errorformat,
                \ }
    let g:neomake_vhdl_enabled_makers = ['vcom']
endif

let &cpo = s:cpo_save
unlet s:cpo_save    
