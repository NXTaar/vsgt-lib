local cmd = vim.cmd
local register_keymap_action = require('nxtaar.core.keymapper').register_keymap_action

local GSTATUS_HEIGHT = 20

vim.g.merginal_windowWidth = 60

register_keymap_action('git.open-figutive', function()
    cmd('Git')
    cmd(GSTATUS_HEIGHT .. 'wincmd_')
end)

register_keymap_action('git.open-flog-tree', 'Flog -all', 'cmd')

register_keymap_action('git.branches-list.toggle', 'MerginalToggle', 'cmd')
