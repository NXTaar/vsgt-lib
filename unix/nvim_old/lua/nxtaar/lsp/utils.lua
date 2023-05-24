local tbl_find = require('nxtaar.utils.table').tbl_find
local exports = {}

local custom_eslint_configs = {
    ['tochka/reports'] = './.eslintrc.prettier.json',
    ['tochka/tar%-core'] = './.eslintrc.prettier.json',
    ['tochka/tar%-demand'] = './.eslintrc.prettier.json',
    ['tochka/tax%-patents'] = './.eslintrc.prettier.json',
    ['tochka/tax%-auto%-reports'] = './.eslintrc.prettier.json',
}

local custom_eslint_config_patterns = vim.tbl_keys(custom_eslint_configs)

function exports.has_eslint_config(buffer_number)
    local clients = vim.lsp.get_active_clients({ bufnr = buffer_number })
    local attached_servers = {}

    for _, cl in ipairs(clients) do
        attached_servers[cl.name] = true
    end

    return not not attached_servers.eslint
end

function exports.check_for_custom_config(root_dir)
    local res = tbl_find(custom_eslint_config_patterns, function(pattern)
        return string.find(root_dir, pattern)
    end)

    return custom_eslint_configs[res]
end

return exports
