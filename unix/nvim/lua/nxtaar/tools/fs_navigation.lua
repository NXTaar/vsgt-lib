local oil = require('oil')
local register_keymap_action = require 'nxtaar.core.keymapper'.register_keymap_action

oil.setup({
    float = {
        -- Padding around the floating window
        max_width = 80,
        max_height = 20,
        border = 'rounded',
        win_options = {
            winblend = 10,
        },
    },
    view_options = {
        show_hidden = false }
})

register_keymap_action('oil.open', function()
    vim.cmd('Oil --float')
end)
