if !exists("g:loaded_airline")
    finish
endif

let g:airline_detect_spell=0                            " I never use spelling in vim, so turn it off
let g:airline_detect_spelllang=0                        " ^^
let g:airline_section_c = '%t'                          " only display the filename
let g:airline_powerline_fonts = 1                       " powerline fonts for facny airline look

