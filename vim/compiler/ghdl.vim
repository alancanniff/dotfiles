" Vim Compiler File
" Compiler:	ghdl
" Maintainer:	Alan Canniff
" Last Change:	2018/12/12

if exists("current_compiler")
    finish
endif
let current_compiler = "ghdl"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=ghdl\ -s\ --ieee=synopsys --std=02
CompilerSet errorformat=
    \%E%f:%l:%c:\ %m

if g:loaded_neomake
    let g:neomake_vhdl_enabled_makers = ['ghdl']
endif

let &cpo = s:cpo_save
unlet s:cpo_save    
