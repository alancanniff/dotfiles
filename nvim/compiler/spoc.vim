" Vim Compiler File
" Compiler: spoc
" Maintainer:   Alan Canniff
" Last Change:  2018/12/15

if exists("current_compiler")
    finish
endif
let current_compiler = "spoc"

if exists(":CompilerSet") != 2      " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim
       
" ./scripts/docker_compile.sh --spoc
       
let b:context_args =  ['--spoc']

let b:context_makeprg = './scripts/docker_compile.sh '
for arg in b:context_args
    let b:context_makeprg .= ' '. arg 
endfor

execute 'CompilerSet makeprg=' . escape(b:context_makeprg, ' ')

let b:context_errorformat = ''
                    \ . '# ** %trror: %f(%l): %m,'
                    \ . '# ** %trror: %m,'
                    \ . '# ** %tarning: %f(%l): %m,'
                    \ . '# ** %tarning: %m,'
                    \ . '# ** %tote: %m,'
                    \ . '%trror: %f(%l): %m,'
                    \ . '%tarning[%*[0-9]]: %f(%l): %m,'
                    \ . '%trror: %m,'
                    \ . '%tarning[%*[0-9]]: %m'
execute 'CompilerSet errorformat=' . escape(b:context_errorformat, ' ')

if g:loaded_neomake

    " let g:neomake_asciidoc_asciidoc_postprocess = { entry -> entry.type ==? 'W' ? extend(entry, {'valid': -1}) : entry}

    function! Postprocess_vhdl_spoc_maker(entry)
      if a:entry.type ==? 'W'
          " extend(a:entry, {'valid': -1})
          let a:entry.valid = -1
      endif
    endfunction

    let g:neomake_vhdl_spoc_maker = {
                \ 'exe': './scripts/docker_compile.sh',
                \ 'args': b:context_args,
                \ 'errorformat': b:context_errorformat,
                \ 'postprocess': function('Postprocess_vhdl_spoc_maker')
                \ }

    let g:neomake_vhdl_enabled_makers = ['spoc']

endif

let &cpo = s:cpo_save
unlet s:cpo_save    
