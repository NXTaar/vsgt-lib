local reach = require('reach')
local register_keymap_action = require('nxtaar.core.keymapper').register_keymap_action

reach.setup()

register_keymap_action('buffers.open', function()
    vim.cmd('ReachOpen buffers')
end)
