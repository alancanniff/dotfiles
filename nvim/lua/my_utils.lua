M = {}

M.buf_map = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
M.buf_opt = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end

return M
