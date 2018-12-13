if g:loaded_quick_scope
    finish
endif

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg=yellow gui=NONE ctermfg=yellow cterm=NONE
highlight QuickScopeSecondary guifg=green gui=NONE ctermfg=green cterm=NONE

augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg=yellow gui=NONE ctermfg=yellow cterm=NONE
    autocmd ColorScheme * highlight QuickScopeSecondary guifg=green gui=NONE ctermfg=green cterm=NONE
augroup END
