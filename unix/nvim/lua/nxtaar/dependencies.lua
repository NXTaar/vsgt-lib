local root = '~/.config/nvim/lua/nxtaar'
local deps_file = 'deps.lua'
local exports = {}

local dictionary = {}

local deps_files = vim.fs.find(deps_file, {
    type = 'file',
    limit = math.huge,
    path = vim.fs.normalize(root)
})

for _, path in ipairs(deps_files) do
    local deps = dofile(path)
    for k, plugin in pairs(deps) do
        dictionary[plugin] = true
    end
end

exports.list = vim.tbl_keys(dictionary)       

return exports