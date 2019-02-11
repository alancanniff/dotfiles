
syn match   vhdlPreProc "\v(^|\s)--\s*pragma\s.*"
                         
hi clear vhdlPreProc
hi vhdlPreProc guifg=cyan
