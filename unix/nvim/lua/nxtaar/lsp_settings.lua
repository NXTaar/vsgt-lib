local lsp = require('lsp-zero')
local json_schemas = require('schemastore').json.schemas()
local register_keymap_action = require('nxtaar.core.keymapper').register_keymap_action

return {
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
        cssls = {},
        cssmodules_ls = {},
        html = {}
    },
    skip_servers = { 'tsserver' }
}
