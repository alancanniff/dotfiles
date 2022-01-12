M = {}

M.buf_map = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
M.buf_opt = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end

local uv = vim.loop

local function dirname(path)
    local strip_dir_pat = '/([^/]+)$'
    local strip_sep_pat = '/$'
    if not path or #path == 0 then
        return
    end
    local result = path:gsub(strip_sep_pat, ''):gsub(strip_dir_pat, '')
    if #result == 0 then
        if is_windows then
            return path:sub(1, 2):upper()
        else
            return '/'
        end
    end
    return result
end

-- Traverse the path calling cb along the way.
local function traverse_parents(path, cb)
    path = uv.fs_realpath(path)
    local dir = path
    -- Just in case our algo is buggy, don't infinite loop.
    for _ = 1, 100 do
        dir = dirname(dir)
        if not dir then
            return
        end
        -- If we can't ascend further, then stop looking.
        if cb(dir, path) then
            return dir, path
        end
        if is_fs_root(dir) then
            break
        end
    end
end
return M
