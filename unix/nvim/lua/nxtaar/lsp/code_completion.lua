local cmp = require('cmp')
local lsp_zero = require('lsp-zero')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        [get_keymap_config_for_action('completion.previous').key] = cmp.mapping.select_prev_item(cmp_select),
        [get_keymap_config_for_action('completion.next').key] = cmp.mapping.select_next_item(cmp_select),
        [get_keymap_config_for_action('completion.confirm').key] = cmp.mapping.confirm({ select = true }),
        [get_keymap_config_for_action('completion.complete').key] = cmp.mapping.complete(),
    }),
    window = {
        documentation = {
            max_width = 100,
        }
    },
})

