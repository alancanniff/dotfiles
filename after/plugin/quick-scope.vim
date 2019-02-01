if !exists("g:loaded_quick_scope")
    finish
endif

highlight QuickScopePrimary guifg=yellow gui=NONE ctermfg=yellow cterm=NONE
highlight QuickScopeSecondary guifg=red gui=NONE ctermfg=red cterm=NONE

augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg=yellow gui=NONE ctermfg=yellow cterm=NONE
    autocmd ColorScheme * highlight QuickScopeSecondary guifg=red gui=NONE ctermfg=red cterm=NONE
augroup END  
