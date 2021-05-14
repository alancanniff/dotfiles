
if !exists('g:loaded_completion') | finish | endif


"" lua require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach}
"" lua require'nvim_lsp'.clangd.setup{on_attach=require'completion'.on_attach}
"" lua require'nvim_lsp'.vimls.setup{on_attach=require'completion'.on_attach}
"lua require'lspconfig'.vhdl_ls.setup{on_attach=require'completion'.on_attach}
"" let g:completion_enable_snippet = 'UltiSnips'
"let g:completion_enable_auto_popup  = 1
"" let g:completion_confirm_key = "\<C-y>"
"" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
""map <c-p> to manually trigger completion
"imap <silent> <c-p> <Plug>(completion_trigger)

"" Set completeopt to have a better completion experience
"set completeopt=menuone,noinsert,noselect

"" Avoid showing message extra message when using completion
"set shortmess+=c
