local M = {
    'toppair/reach.nvim'
}

function M.config()
    local reach = require('reach')

    reach.setup()

    register_keymap_action('buffers.open', function()
        vim.cmd('ReachOpen buffers')
    end)
end

return M

