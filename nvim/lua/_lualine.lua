local ok, _ = pcall(require, 'lualine')
if not ok then
    return nil
end


-- require('lualine').setup {
--   options = {
--     icons_enabled = true,
--     theme = 'auto',
--     component_separators = { left = '', right = ''},
--     section_separators = { left = '', right = ''},
--     disabled_filetypes = {},
--     always_divide_middle = true,
--   },
--   sections = {
--     lualine_a = {'mode'},
--     lualine_b = {'branch', 'diff', 'diagnostics'},
--     lualine_c = {'filename'},
--     lualine_x = {'encoding', 'fileformat', 'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'location'},
--     lualine_y = {},
--     lualine_z = {}
--   },
--   tabline = {},
--   extensions = {}
-- }

-- stylua: ignore
local colors = {
    green  = '#98be65',
    blue   = '#80a0ff',
    cyan   = '#79dac8',
    red    = '#ff5189',
    black  = '#080808',
    white  = '#c6c6c6',
    violet = '#d183e8',
    grey   = '#303030',
}

local custom_auto_theme = require'lualine.themes.auto'
custom_auto_theme.normal.a.fg = colors.black
custom_auto_theme.normal.a.bg = colors.green

custom_auto_theme.insert.a.fg = colors.black
custom_auto_theme.insert.a.bg = colors.green

custom_auto_theme.visual.a.fg = colors.black
custom_auto_theme.visual.a.bg = colors.green

custom_auto_theme.replace.a.fg = colors.black
custom_auto_theme.replace.a.bg = colors.green

custom_auto_theme.command.a.fg = colors.black
custom_auto_theme.command.a.bg = colors.green

-- custom_auto_theme.inactive.a.fg = colors.white
-- custom_auto_theme.inactive.a.bg = colors.black

local trailing_whitespace = function()
    if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
        return ""
    end
    local space = vim.fn.search([[\s\+$]], 'nwc')
    -- return space ~= 0 and "TW:"..space or ""
    return space ~= 0 and "TW" or ""
end

local mixed_indent = function()
    local space_pat = [[\v^ +]]
    local tab_pat = [[\v^\t+]]
    local space_indent = vim.fn.search(space_pat, 'nwc')
    local tab_indent = vim.fn.search(tab_pat, 'nwc')
    local mixed = (space_indent > 0 and tab_indent > 0)
    local mixed_same_line
    if not mixed then
        mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
        mixed = mixed_same_line > 0
    end
    if not mixed then return '' end
    if mixed_same_line ~= nil and mixed_same_line > 0 then
        -- return 'MI:'..mixed_same_line
        return 'MI'
    end
    local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
    local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
    if space_indent_cnt > tab_indent_cnt then
        -- return 'MI:'..tab_indent
        return 'MI'
    else
        -- return 'MI:'..space_indent
        return 'MI'
    end
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

lualine = require('lualine')

local ABSOLUTE_PATH = 2
local RELATIVE_PATH = 1

lualine.setup {
    options = {
        theme = custom_auto_theme,
        -- component_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = '' },
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = '' },

        icons_enabled = false,
    },
    sections = {
        lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end } },
        lualine_b = {
            'branch',
            {'diff', fmt = trunc(nil, nil, 80)},
        },
        lualine_c = {
            { 'filename', path=RELATIVE_PATH, shorting_target=0, }
        },

        lualine_y = {
            mixed_indent,
            trailing_whitespace,
            {'diagnostics', icons_enabled = false},
        },
        lualine_x = {
            {'fileformat', icons_enabled = false, fmt = trunc(nil, nil, 120)},
            {'filetype', icons_enabled = false, fmt = trunc(nil, nil, 100)},
        },
    },
    inactive_sections = {
        lualine_c = {
            { 'filename', path=RELATIVE_PATH, shorting_target=0, }
        },
        lualine_x = {},
    }
}
