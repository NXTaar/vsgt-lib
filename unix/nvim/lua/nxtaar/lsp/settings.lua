local lsp = require('lsp-zero')
local json_schemas = require('schemastore').json.schemas()

local M = {}

M.settings = {
    jsonls = {
        autoformat_files = { 'json' },
        lsp = {
            settings = {
                json = {
                    validate = { enable = true },
                    schemas = json_schemas,
                },
            },
        }
    },
    yamlls = {
        autoformat_files = { 'yaml' },
        lsp = {
            schemastore = {
                enable = true,
            },
            settings = {
                yaml = {
                    hover = true,
                    completion = true,
                    validate = { enable = true },
                    schemas = json_schemas,
                },
            },
        }
    },
    lua_ls = {
        autoformat_files = { 'lua' },
        lsp = lsp.nvim_lua_ls({
            settings = {
                Lua = {
                    format = {
                        defaultConfig = {
                            quote_style = 'single',
                        }
                    }
                }
            }
        })
    },
    cssls = {},
    cssmodules_ls = {},
    html = {},
}

M.formatting_settings = {
    format_opts = {
        async = true,
        timeout_ms = 10000,
    },
}

M.language_servers = vim.tbl_filter(function(server)
    return server ~= 'tsserver'
end, vim.tbl_keys(M.settings))

for server, config in pairs(M.settings) do
    local files_list = config.autoformat_files

    if (files_list) then
        M.formatting_settings.servers = M.formatting_settings.servers or {}
        M.formatting_settings.servers[server] = files_list
    end
end

function M.apply_server_settings(cb)
    for _, server in ipairs(M.language_servers) do
        if M.settings[server].lsp ~= nil then
            cb(server, M.settings[server].lsp)
        end
    end
end

return M
