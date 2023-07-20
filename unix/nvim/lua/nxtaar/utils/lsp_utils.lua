local config = require('nxtaar.lsp_settings')
local M = {}

M.language_servers = vim.tbl_keys(config.servers)

M.formatting_settings = config.formatting

M.skip_servers = config.skip_servers

M.diagnostic = config.diagnostic

for server, config in pairs(config.servers) do
    local files_list = config.autoformat_files

    if (files_list) then
        M.formatting_settings.servers = M.formatting_settings.servers or {}
        M.formatting_settings.servers[server] = files_list
    end
end

function M.apply_server_settings(cb)
    for _, server in ipairs(M.language_servers) do
        if config.servers[server].lsp ~= nil then
            cb(server, config.servers[server].lsp)
        end
    end
end

function M.get_lsp_config(server)
    if config.servers[server] == nil or config.servers[server].lsp == nil then
        print('No LSP config for server: ' .. server)
    end

    return config.servers[server].lsp
end

return M