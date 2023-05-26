local lsp = require('lsp-zero')
local json_schemas = require('schemastore').json.schemas()
local register_keymap_action = require('nxtaar.keymaps.utils').register_keymap_action

local M = {}

local settings = {
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
    tsserver = {
        lsp = {
            server = {
                on_attach = function()
                    register_keymap_action('typescript.add-missing-imports', '<cmd>TypescriptAddMissingImports<cr>')
                    register_keymap_action('typescript.remove-unused-imports', '<cmd>TypescriptRemoveUnused<cr>')
                end
            }
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

M.language_servers = vim.tbl_keys(settings)

for server, config in pairs(settings) do
    local files_list = config.autoformat_files

    if (files_list) then
        M.formatting_settings.servers = M.formatting_settings.servers or {}
        M.formatting_settings.servers[server] = files_list
    end
end

function M.apply_server_settings(cb)
    for _, server in ipairs(M.language_servers) do
        if settings[server].lsp ~= nil then
            cb(server, settings[server].lsp)
        end
    end
end

function M.get_lsp_config(server)
    if settings[server] == nil or settings[server].lsp == nil then
        print('No LSP config for server: ' .. server)
    end

    return settings[server].lsp
end

return M
