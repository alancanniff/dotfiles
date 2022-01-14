M = {}

M.map = function(...) vim.api.nvim_set_keymap(...) end
M.opt = function(...) vim.api.nvim_set_option(...) end

return M
