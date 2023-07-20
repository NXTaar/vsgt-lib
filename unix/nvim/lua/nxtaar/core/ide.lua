local cmp = require('cmp')
local lsp_zero = require('lsp-zero')
local neovim_lua_hints = require('neodev')
local typescript = require('typescript')
local keymapper = require('nxtaar.core.keymapper')
local action = require('nxtaar.utils.actions').action
local lsp_utils = require('nxtaar.utils.lsp_utils')

local get_keymap_config_for_action = keymapper.get_keymap_config_for_action
local register_keymap_action = keymapper.register_keymap_action
local apply_server_settings = lsp_utils.apply_server_settings
local get_lsp_config = lsp_utils.get_lsp_config
local diagnostic = lsp_utils.diagnostic

register_keymap_action('lsp.show-lsp-info', 'LSPInfo', 'cmd')

neovim_lua_hints.setup {}

local lsp = lsp_zero.preset({
    name = 'recommended',
    configure_diagnostics = false,
    manage_nvim_cmp = {
        set_extra_mappings = true,
    },
})

lsp.ensure_installed(lsp_utils.language_servers)
lsp.format_on_save(lsp_utils.formatting_settings)
lsp.skip_server_setup(lsp_utils.skip_servers)

apply_server_settings(function(server, opts)
    lsp.configure(server, opts)
end)

vim.diagnostic.config({
    virtual_text = diagnostic.virtual_text,
})

lsp.set_sign_icons(diagnostic.icons)

lsp.on_attach(function()
    register_keymap_action('lsp.show-hint', vim.lsp.buf.hover)
    register_keymap_action('lsp.go-to-definition', vim.lsp.buf.definition)
    register_keymap_action('lsp.go-to-declaration', vim.lsp.buf.declaration)
    register_keymap_action('lsp.go-to-implementation', vim.lsp.buf.implementation)
    register_keymap_action('lsp.go-to-type-definition', vim.lsp.buf.type_definition)
    register_keymap_action('lsp.go-to-references', action('trouble.show-references'))
    register_keymap_action('lsp.signature-help', vim.lsp.buf.signature_help)
    register_keymap_action('lsp.rename', vim.lsp.buf.rename)
    register_keymap_action('lsp.format-async', function()
        vim.lsp.buf.format({ async = true })
    end)
    register_keymap_action('lsp.code-action', vim.lsp.buf.code_action)
    register_keymap_action('lsp.show-info', vim.diagnostic.open_float)
    register_keymap_action('lsp.diagnostic-go-to-prev', vim.diagnostic.goto_prev)
    register_keymap_action('lsp.diagnostic-go-to-next', vim.diagnostic.goto_next)
end)

lsp.setup()

cmp.setup({
    mapping = {
        [get_keymap_config_for_action('completion.select').key] = cmp.mapping.confirm({ select = true }),
    },
    window = {
        documentation = {
            max_width = 100,
        }
    },
})

typescript.setup(get_lsp_config('tsserver'))
