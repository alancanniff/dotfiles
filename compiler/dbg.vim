 

let b:my_args =  [
                \ '-2002',
                \ '-lint',
                \ '-check_synthesis',
                \ '-bindAtCompile',
                \ '-quiet',
                \ '-work'
                \ ]


if 1
    let b:my_args += ['work']
endif

let g:my_neomaker = {
            \ 'args': b:my_args,
            \ }
                           
let b:my_str = 'vcom'
for arg in b:my_args
    let b:my_str .= ' '. arg 
endfor
echom(b:my_str)

