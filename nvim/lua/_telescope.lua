 -- in lua/finders.lua

local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}

local finders = {}

--  -- Dropdown list theme using a builtin theme definitions :
--  local center_list = require'telescope.themes'.get_dropdown({
--      winblend = 10,
--      width = 0.5,
--      prompt = " ",
--      results_height = 15,
--      previewer = false,
--  })

--  -- Settings for with preview option
--  local with_preview = {
--      winblend = 10,
--      show_line = false,
--      results_title = false,
--      preview_title = false,
--      layout_config = {
--          preview_width = 0.5,
--      },
--  }

--  -- Find in neovim config with center theme
--  finders.fd_in_nvim = function()
--      local opts = vim.deepcopy(center_list)
--      opts.prompt_prefix = 'Nvim>'
--      opts.cwd = vim.fn.stdpath("config")
--      require'telescope.builtin'.fd(opts)
--  end

--  -- Find files with_preview settings
--  function fd()
--      local opts = vim.deepcopy(with_preview)
--      opts.prompt_prefix = 'FD>'
--      require'telescope.builtin'.fd(opts)
--  end

--  return finders

 -- make sure to map it:
 -- nnoremap <leader>ff :lua require'finders'.fd_in_nvim()<cr> 
 -- nnoremap <leader>ff :lua require'finders'.fd()<cr>

--local has_telescope, telescope = pcall(require, 'telescope')

--if not has_telescope then
--    error('This plugins requires nvim-telescope/telescope.nvim')
--end

--local finders = require('telescope.finders')
--local previewers = require('telescope.previewers')
--local pickers = require('telescope.pickers')

---- Create a new finder.
----  This finder, rather than taking a Lua list,
----  generates a shell command that should be run.
----
----  Each line of the shell command is converted to an entry,
----  and is possible to preview with builtin previews.
----
---- In this example, we use ripgrep to search over your entire directory
---- live as you type.
--local test_grepper = finders.new_job(function(prompt)
--  if not prompt or prompt == "" then
--    return nil
--  end

--  return { 'ag', "--vimgrep", prompt}
--end)

---- Create and run the Picker.
----
---- NOTE: No sorter is needed to be passed.
--pickers.new(opts, {
--    prompt    = 'Alan Grep',
--    finder    = test_grepper,
--    previewer = previewers.vimgrep,
--}):find()



