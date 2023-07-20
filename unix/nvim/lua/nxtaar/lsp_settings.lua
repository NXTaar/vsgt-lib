local lsp = require('lsp-zero')
local json_schemas = require('schemastore').json.schemas()
local register_keymap_action = require('nxtaar.core.keymapper').register_keymap_action
local tbl_find = require('nxtaar.utils.table').tbl_find

local settings = {
    formatting = {
        format_opts = {
            async = true,
            timeout_ms = 10000
        }
    },
    diagnostic = {
        icons = {
            error = '',
            warn = '',
            hint = '⚑',
            info = ''
        },
        virtual_text = false
    },
    servers = {
        jsonls = {
            autoformat_files = { 'json' },
            lsp = {
                settings = {
                    json = {
                        validate = {
                            enable = true
                        },
                        schemas = json_schemas
                    }
                }
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
                    enable = true
                },
                settings = {
                    yaml = {
                        hover = true,
                        completion = true,
                        validate = {
                            enable = true
                        },
                        schemas = json_schemas
                    }
                }
            }
        },
        lua_ls = {
            autoformat_files = { 'lua' },
            lsp = lsp.nvim_lua_ls({
                settings = {
                    Lua = {
                        format = {
                            defaultConfig = {
                                quote_style = 'single'
                            }
                        }
                    }
                }
            })
        },
        eslint = {
            autoformat_files = {
                'typescript'
            },
            lsp = {
                on_attach = function(client, bufnr)
                    local path = vim.api.nvim_buf_get_name(bufnr)

                    local use_custom_config = tbl_find({
                        'tochka/reports',
                        'tochka/tar%-core',
                        'tochka/tar%-demand',
                        'tochka/tax%-patents',
                        'tochka/tax%-auto%-reports'
                    }, function(pattern) return string.find(path, pattern) end)

                    if use_custom_config then
                        client.config.settings.options = {
                            configFile = './.eslintrc.prettier.json',
                        }
                    end

                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = bufnr,
                        command = 'EslintFixAll',
                    })
                end,
            }
        },
        bashls = {},
        cssls = {},
        cssmodules_ls = {},
        html = {}
    },
    skip_servers = { 'tsserver' }
}

return settings
