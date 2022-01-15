M = {}

-- M.map = function(...) vim.api.nvim_set_keymap(...) end
M.map = function(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then 
      options = vim.tbl_extend('force', options, opts) 
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.opt = function(...) vim.api.nvim_set_option(...) end

return M
