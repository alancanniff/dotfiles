local whitespace = require('galaxyline.provider_whitespace')
local lspclient = require('galaxyline.provider_lsp')
local vcs = require('galaxyline.provider_vcs')
local condition = require('galaxyline.condition')

local get_lsp_client = function(msg)
    msg = msg or 'N/A'
    local buf_ft = vim.api.nvim_buf_get_option(0,'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return nil
    end

    for _,client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
            return client.name
        end
    end
    return nil
end

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
    end
    return false
end

DiffAdd = vcs.diff_add             -- support vim-gitgutter vim-signify gitsigns
DiffModified = vcs.diff_modified   -- support vim-gitgutter vim-signify gitsigns
DiffRemove = vcs.diff_remove       -- support vim-gitgutter vim-signify gitsigns



local gl = require("galaxyline")

-----------------------------------------------------------

local icons  = {
    sep = { left = "", right = ""},
    subsep = { left = "", right = ""},
    git = "",
    readonly = '',
}

function icons:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function icons:get_func(first, second)
    if second == nil then
        return function () 
            return self[first]
        end
    else
        return function () 
             return self[first][second]
        end        
    end
end

local detail = icons:new()

-----------------------------------------------------------

local gls = gl.section
local Space = function() return ' ' end

-- local checkwidth = function()
--     if vim.fn.winwidth(0)/2 > 40 then
--         return true
--     end
--     return false
-- end

gl.short_line_list = {" "} -- keeping this table { } as empty will show inactive statuslines

local FileNameAbsolute = function() 
    return vim.fn.expand("%:p")
end

local colors = {
    bg = "#282c34",
    line_bg = "#282c34",
    fg = "#D8DEE9",
    fg_green = "#65a380",
    yellow = "#A3BE8C",
    cyan = "#22262C",
    darkblue = "#61afef",
    green = "#BBE67E",
    orange = "#FF8800",
    purple = "#252930",
    magenta = "#c678dd",
    blue = "#22262C",
    red = "#DF8890",
    lightbg = "#3C4048",
    nord = "#81A1C1",
    greenYel = "#EBCB8B"
}

-- gls.left[1] = {
--     ViMode = {
--         provider = function()
--             local alias = {
--                 n = "NORMAL",
--                 i = "INSERT",
--                 c = "COMMAND",
--                 V = "VISUAL",
--                 [""] = "VISUAL",
--                 v = "VISUAL",
--                 R = "REPLACE"
--             }
--             return alias[vim.fn.mode()]
--         end,
--         highlight = {colors.bg, colors.red}
--     }
-- }

-- gls.left = {}

local paste_mode = {
    PasteMode = {
        provider = function()
            return "set paste"
        end,
        condition = function()
            return vim.o.paste
        end,
        highlight = {colors.bg, colors.red},
        event = "OptionSet"
        -- event = "BufWritePost"
        -- this needs an event
    }
}

local paste_sep = {
    PasteSep = {
        provider = detail:get_func("sep", "left"),
        highlight = {colors.red, colors.bg}
    }          
}

local git_branch = {    
    GitBranch = {
        icon = detail.git,
        provider = "GitBranch",
        condition = buffer_not_empty,
        highlight = {colors.green, colors.line_bg}
    }
}
local git_sep = {
    GitSep = {
        provider = detail:get_func("sep", "left"),
        highlight = {colors.bg, colors.lightbg}
    }
}

local filename = {
    FileName = {
        provider = FileNameAbsolute,
        condition = buffer_not_empty,
        -- separator = " ",
        -- separator_highlight = {colors.fg, colors.lightbg},
        highlight = {colors.fg, colors.lightbg}
    }
}

local readonly = {
    ReadOnly = {
        icon = " ",
        provider = detail:get_func("readonly"),
        condition = function ()
            return vim.bo.readonly
        end,
        separator_highlight = {colors.fg, colors.lightbg},
        highlight = {colors.fg, colors.lightbg}
    }
}
local end_sep = {
    End = {
        provider = detail:get_func("sep", "left"),
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.lightbg, colors.bg}
    }
}

table.insert(gls.left, paste_mode )
table.insert(gls.left, left_sep )
table.insert(gls.left, git_branch )
table.insert(gls.left, git_sep )

-- gls.left[6] = {
--     DiffAdd = {
--         provider = DiffAdd,
--         icon = " ",
--         highlight = {colors.greenYel, colors.line_bg}
--     }
-- }

-- gls.left[7] = {
--     DiffModified = {
--         provider = {Space, "DiffModified"},
--         condition = function()
--             return vcs.check_git_workspace
--         end,         
--         icon = " ",
--         highlight = {colors.orange, colors.line_bg}
--     }
-- }

-- gls.left[8] = {
--     DiffRemove = {
--         provider = {Space, "DiffRemove"},
--         condition = function()
--             return vcs.check_git_workspace
--         end,         
--         icon = " ",
--         highlight = {colors.red, colors.line_bg}
--     }
-- }

-- gls.left[10] = {
--     DiagnosticError = {
--         provider = "DiagnosticError",
--         icon = "  ",
--         highlight = {colors.red, colors.bg}
--     }
-- }

-- gls.left[11] = {
--     Space = {
--         provider = function()
--             return " "
--         end,
--         highlight = {colors.line_bg, colors.line_bg}
--     }
-- }

-- gls.left[12] = {
--     DiagnosticWarn = {
--         provider = "DiagnosticWarn",
--         icon = "  ",
--         highlight = {colors.blue, colors.bg}
--     }
-- }


-- TODO wrap this in a augroup
vim.cmd('au OptionSet * lua require("galaxyline").load_galaxyline()')



-- gls.right[4] = {
--     ViMode = {
--         provider = function()
--             local alias = {
--                 n = "NORMAL",
--                 i = "INSERT",
--                 c = "COMMAND",
--                 V = "VISUAL",
--                 [""] = "VISUAL",
--                 v = "VISUAL",
--                 R = "REPLACE"
--             }
--             return alias[vim.fn.mode()]
--         end,
--         highlight = {colors.bg, colors.red}
--     }
-- }


gls.right[1] = {
    RightEnd = {
        provider = function ()
            return detail.sep.right
        end,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}
gls.right[3] = {
    FileType = {
        provider = function ()
            return vim.bo.filetype
        end,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}
-- gls.right[3] = {
--     FileIcon = {
--         provider = {"FileIcon"},
--         condition = condition.buffer_not_empty,
--         highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
--     }
-- }

gls.right[4] = {
    LspClient = {
        provider = "GetLspClient",
        -- condition = function() 
        --     return get_lsp_client ~= nil
        -- end,
        separator = "|",
        separator_highlight = {colors.bg, colors.fg},
        highlight = {colors.bg, colors.fg}
    }
}
gls.right[5] = {
    LineStats = {
        provider = {"LineColumn", "LinePercent"},
        -- separator = " ",
        separator = "|",
        separator_highlight = {colors.bg, colors.fg},
        highlight = {colors.bg, colors.fg}
    }
}

gls.right[6] = {
    rightRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.fg, colors.bg}
    }
}
