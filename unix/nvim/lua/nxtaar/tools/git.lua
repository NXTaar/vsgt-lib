local M = {
    'tpope/vim-fugitive',
    'rbong/vim-flog',
    'idanarye/vim-merginal',
}

function M.config()
    local cmd = vim.cmd
    local notification = require('nxtaar.editor.notifications')

    local GSTATUS_HEIGHT = 20

    vim.g.merginal_windowWidth = 60

    register_keymap_action('git.open-figutive', function()
        cmd('Git')
        cmd(GSTATUS_HEIGHT .. 'wincmd_')
    end)

    register_keymap_action('git.push', function()
        cmd('Git push')
    end)

    register_keymap_action('git.pull', 'Git pull -r', 'cmd')

    register_keymap_action('git.push-force', 'Git push -f', 'cmd')

    register_keymap_action('git.open-flog-tree', 'Flog -all', 'cmd')

    register_keymap_action('git.branches-list.toggle', 'MerginalToggle', 'cmd')
end

return M
