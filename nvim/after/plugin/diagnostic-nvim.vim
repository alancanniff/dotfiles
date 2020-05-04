
if !exists('g:loaded_diagnostic') | finish | endif

lua require'nvim_lsp'.pyls.setup{on_attach=require'diagnostic'.on_attach}
lua require'nvim_lsp'.clangd.setup{on_attach=require'diagnostic'.on_attach}

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_auto_popup_while_jump = 0
let g:space_before_virtual_text = 10
let g:diagnostic_insert_delay = 5
