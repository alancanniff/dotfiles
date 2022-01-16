------------------------------------

return

-- require('lfs')
-- 
-- local function get_filename(filename)
--   return filename:match("^(.+)%..+$")
-- end
-- 
-- local function get_extension(filename)
--   return filename:match("^.+%.(.+)$")
-- end
-- 
-- local function split(filename)
--     return get_filename(filename), get_extension(filename)
-- end
-- 

-- for file in lfs.dir('.') do
--     -- print(file)
--     if lfs.attributes(file,"mode") == "file" then
--         name, ext = split(file)
--         if (ext == "lua") and (name ~= "init") then
--             require(name)
--         end
--     end
-- end

